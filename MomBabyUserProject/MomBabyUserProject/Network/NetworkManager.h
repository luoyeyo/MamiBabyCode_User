//
//  NetworkManager.h
//  AgentForWorld
//
//  Created by 罗野 on 15/9/9.
//  Copyright (c) 2015年 luo. All rights reserved.

#import "HttpResponseData.h"
#import "ApiFile.h"

//服务端地址
static NSString *const sServerBaseUrl = kServerBaseUrl;

//http 请求类型
typedef NS_ENUM(NSInteger, kHttpRequestType)
{
    kHttpRequestTypeGet = 0,
    kHttpRequestTypePost = 1
};

//网络请求返回BLOCK
typedef void (^RequestCallBackBlock)(LLError *error, id responseData);
typedef void (^responseBlock)(LLError *error, HttpResponseData *responseData);


#pragma mark - 网络请求管理

@interface NetworkManager : NSObject

//@property(nonatomic, strong) AFHTTPSessionManager *manager;

//additonalHeader 为针对特定请求自添加的头域
- (void)get:(NSString*)relativePath params:(NSDictionary *)params additionalHeader:(NSDictionary*)additonalHeader response:(RequestCallBackBlock)requestCallBackBlock;

- (void)post:(NSString *)relativePath params:(NSDictionary *)params additionalHeader:(NSDictionary*)additonalHeader response:(RequestCallBackBlock)requestCallBackBlock;

- (void)put:(NSString*)relativePath params:(id)params additionalHeader:(NSDictionary*)additonalHeader response:(RequestCallBackBlock)requestCallBackBlock;
- (void)deleteR:(NSString*)relativePath params:(id)params additionalHeader:(NSDictionary*)additonalHeader response:(RequestCallBackBlock)requestCallBackBlock;

/**
 *  上传图片
 *
 *  @param relativePath         接口
 *  @param imageData            图片data
 *  @param requestCallBackBlock
 */
- (void)upload:(NSString*)relativePath imageData:(NSData*)imageData response:(RequestCallBackBlock)requestCallBackBlock;
- (void)uploadImageWithQiNiuImageData:(NSData *)imageData token:(NSString *)token response:(RequestCallBackBlock)requestCallBackBlock;

@end
