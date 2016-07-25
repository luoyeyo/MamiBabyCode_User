//
//  NetworkManager.m
//  AgentForWorld
//
//  Created by 罗野 on 15/9/9.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "NetworkManager.h"
#import <AFHTTPSessionManager.h>
#import "UserDefaults.h"
#import <Qiniu/QiniuSDK.h>

@implementation NetworkManager

- (NSMutableURLRequest*)makeUploadImageRequest:(NSData*)imageData uploadTo:(NSString*)uploadPath
{
    NSString *uploadFullPath = [NSString stringWithFormat:@"%@%@",kServerBaseUrl, uploadPath];
    
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:uploadFullPath]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    
    //添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"boris.png\"\r\n"];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:imageData];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    
    //设置Content-Length
    NSInteger contentLength = [myRequestData length];
    [request setValue:[NSString stringWithFormat:@"%@", @(contentLength)] forHTTPHeaderField:@"Content-Length"];
    
    //设置http body
    [request setHTTPBody:myRequestData];
    
    //http method
    [request setHTTPMethod:@"POST"];
    
    return request;
}

//moreHeaders 为自添加的头域
- (AFHTTPSessionManager *)makeSessionManager:(NSDictionary*)moreHeaders
{
    NSURL *baseUrl = [NSURL URLWithString:kServerBaseUrl];
    
    NSDictionary * newHeaders;
    NSString * OS_Version = [[UIDevice currentDevice] systemVersion];
    NSString * Platform = @"iOS";
    NSString * VersionNum = [NSString stringWithFormat:@"%d",locationVersion];
    if (moreHeaders) {
        NSString * Authorization = [moreHeaders objectForKey:@"Authorization"];
        newHeaders = @{@"OS_Version":OS_Version,@"Platform":Platform,@"Authorization":Authorization,@"VersionNum":VersionNum};
    } else {
        newHeaders = @{@"OS_Version":OS_Version,@"Platform":Platform,@"VersionNum":VersionNum};
    }
    NSURLSessionConfiguration *config = [self configSessionConfiguration:newHeaders];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseUrl sessionConfiguration:config];
    return manager;
}

- (NSURLSessionConfiguration*)configSessionConfiguration:(NSDictionary*)moreHeaders
{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //设置我们的缓存大小 其中内存缓存大小设置10M  磁盘缓存5M
    NSURLCache *cache = [[NSURLCache alloc]initWithMemoryCapacity:kNetWorkDataMemoryCache
                                                     diskCapacity:kNetWorkDataDiskCache
                                                         diskPath:nil];
    [config setURLCache:cache];
    
    [config setRequestCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    [config setTimeoutIntervalForRequest:kNetWorkRequestTimeOut];
    [config setTimeoutIntervalForResource:kNetWorkRequestTimeOut];
    
    //设置头
    NSDictionary *baseHeaders = [self getBaseHttpHeaders];
    NSMutableDictionary *headerDic = [[NSMutableDictionary alloc] initWithDictionary:baseHeaders];
    [headerDic addEntriesFromDictionary:moreHeaders];
    [config setHTTPAdditionalHeaders:headerDic];
    
    return config;
}

#pragma mark - 配置Header域基础项
/**
 *  设置请求头
 *
 *  @return
 */
- (NSDictionary*)getBaseHttpHeaders {
    NSMutableDictionary *baseHeaders = [[NSMutableDictionary alloc]init];
    
    //系统名称
    //    NSString *osName = @"IOS";
    //    [baseHeaders setObject:osName forKey:ksOsName];
    
    //系统版本
    //    NSString *systemVersion = [[UIDevice currentDevice]systemVersion];
    //    [baseHeaders setObject:systemVersion forKey:ksSystemVersion];
    
    //App 版本号
    //    [baseHeaders setObject:[NSString appVersion] forKey:@"appVersion"];
    
    //App bundle Id
    //    [baseHeaders setObject:[NSString appBundleId] forKey:@"appBundle"];
    
    //add user token if logined
    UserInfoEntity *user = [UserInfoEntity sharedInstance];
    if ([user isLogined] && ![NSString isEmptyString:user.token]) {
        [baseHeaders setObject:user.token forKey:@"Authorization"];
    }
    
    //Push Device Token
    //    if (![Util isEmptyString:[UserDefaults pushDeviceToken]]) {
    //        [baseHeaders setObject:[UserDefaults pushDeviceToken] forKey:@"appPushDeviceToken"];
    //    }
    
    //city code
    //    if ([user.cityCode isNotEmpty]) {
    //        [baseHeaders setObject:user.cityCode forKey:@"cityCode"];
    //    }
    return baseHeaders;
}

#pragma mark - 上传

- (void)upload:(NSString*)relativePath imageData:(NSData*)imageData response:(RequestCallBackBlock)requestCallBackBlock
{
    AFHTTPSessionManager *manager = [self makeSessionManager:nil];
    
    NSMutableURLRequest *request = [self makeUploadImageRequest:imageData uploadTo:relativePath];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        LLError *err = nil;
        if (nil == error) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if ([responseObject[kErrorCode] integerValue] != kHttpReturnCodeSuccess) {
                    err = [LLError errorWithErrorCode:[responseObject[kErrorCode] integerValue] message:responseObject[kErrorMsg]];
                }
            }
            requestCallBackBlock(err, responseObject);
        }else {
            DLog(@"\n[API:%@]return:%@, %@", relativePath, @(error.code), error.localizedDescription);
            LLError *err = nil;
            err = [LLError errorWithErrorCode:error.code message:error.localizedDescription];
            requestCallBackBlock(err, nil);
        }
    }];
    [task resume];
}

- (void)uploadImageWithQiNiuImageData:(NSData *)imageData token:(NSString *)token response:(RequestCallBackBlock)requestCallBackBlock {
    //    NSString *keyUTF8 = [NSString stringWithCString:[key UTF8String] encoding:NSUnicodeStringEncoding];
    NSString *tokenUTF8 = [NSString stringWithCString:[token UTF8String] encoding:NSUTF8StringEncoding];
    [NSString stringWithCString:[kUserInfo.token UTF8String] encoding:NSUnicodeStringEncoding];
    QNUploadManager *manager = [[QNUploadManager alloc] init];
    [manager putData:imageData key:nil token:tokenUTF8 complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        LLError *error;
        if (info.error) {
            error.errorcode = info.error.code;
            error.errormsg = info.error.localizedDescription;
        }
        requestCallBackBlock(error,resp);
    } option:nil];
}

/**
 *  处理error
 *
 *  @param responseObject
 *  @param error
 *
 *  @return
 */
- (LLError *)handleSomeErrorIfNeed:(id)responseObject error:(NSError *)error
{
    LLError *err = nil;
    if (error) {
        // 通知服务器获取失败
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotiNoConnection object:nil];
        err = [LLError errorWithErrorCode:error.code message:error.localizedDescription];
        err.sysError = YES;
        return err;
    }
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        if ([responseObject[kErrorCode] integerValue] != kHttpReturnCodeSuccess) {
            err = [LLError errorWithErrorCode:[responseObject[kErrorCode] integerValue] message:responseObject[kErrorMsg]];
            err.sysError = NO;
        }
    }
    
    if (err.errorcode == kHttpReturnCodeTokenFailure) {
        [kUserInfo userTokenFailure];
    }
    return err;
}

#pragma mark - 网络请求

- (void)get:(NSString*)relativePath params:(NSDictionary *)params additionalHeader:(NSDictionary*)additonalHeader response:(RequestCallBackBlock)requestCallBackBlock
{
    AFHTTPSessionManager *manager = [self makeSessionManager:additonalHeader];
    [manager GET:relativePath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        LLError *err = [self handleSomeErrorIfNeed:responseObject error:nil];
        requestCallBackBlock(err, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"\n[请求失败:%@]return:%@, %@", relativePath, @(error.code), error.localizedDescription);
        LLError *err = [self handleSomeErrorIfNeed:nil error:error];
        requestCallBackBlock(err, nil);
    }];
}

- (void)post:(NSString*)relativePath params:(NSDictionary *)params additionalHeader:(NSDictionary*)additonalHeader response:(RequestCallBackBlock)requestCallBackBlock
{
    AFHTTPSessionManager *manager = [self makeSessionManager:additonalHeader];
    DLog(@"[请求：%@", relativePath);
    [manager POST:relativePath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        LLError *err = [self handleSomeErrorIfNeed:responseObject error:nil];
        requestCallBackBlock(err, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"\n[请求失败:%@]return:%@, %@", relativePath, @(error.code), error.localizedDescription);
        LLError *err = [self handleSomeErrorIfNeed:nil error:error];
        requestCallBackBlock(err, nil);
    }];
}

- (void)put:(NSString*)relativePath params:(id)params additionalHeader:(NSDictionary*)additonalHeader response:(RequestCallBackBlock)requestCallBackBlock {
    AFHTTPSessionManager *manager = [self makeSessionManager:additonalHeader];
    DLog(@"[请求：%@", relativePath);
    [manager PUT:relativePath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LLError *err = [self handleSomeErrorIfNeed:responseObject error:nil];
        requestCallBackBlock(err, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"\n[请求失败:%@]return:%@, %@", relativePath, @(error.code), error.localizedDescription);
        LLError *err = [self handleSomeErrorIfNeed:nil error:error];
        requestCallBackBlock(err, nil);
    }];
}

- (void)deleteR:(NSString*)relativePath params:(id)params additionalHeader:(NSDictionary*)additonalHeader response:(RequestCallBackBlock)requestCallBackBlock {
    AFHTTPSessionManager *manager = [self makeSessionManager:additonalHeader];
    DLog(@"[请求：%@", relativePath);
    [manager DELETE:relativePath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        DLog(@"[请求返回：%@ \n  data: %@", relativePath,responseObject);
        LLError *err = [self handleSomeErrorIfNeed:responseObject error:nil];
        requestCallBackBlock(err, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        LLError *err = [self handleSomeErrorIfNeed:nil error:error];
        requestCallBackBlock(err, nil);
    }];
}

@end
