//
//  HttpData.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/15.
//  Copyright © 2016年 iMac. All rights reserved.
//



@interface PageInfoModel : JSONModel
@property(nonatomic, assign)NSInteger count;
@property(nonatomic, assign)NSInteger lastPage;
@property(nonatomic, assign)NSInteger limit;
@property(nonatomic, assign)NSInteger page;
@property(nonatomic, assign)NSInteger size;
@end

@interface LLError : NSObject
@property(nonatomic, assign)NSInteger errorcode;
@property(nonatomic, copy)NSString *errormsg;
@property(nonatomic, assign)BOOL sysError;
+ (LLError *)errorWithErrorCode:(NSInteger)code message:(NSString *)message;
@end

@interface PhotoModel : JSONModel
@property(nonatomic, copy)NSString *key;
@property(nonatomic, copy)NSString *medium;
@property(nonatomic, copy)NSString *real;
@end

@protocol PhotoModel <NSObject>

@end

@interface HttpResponseData : JSONModel
@property(nonatomic, assign)NSInteger errorcode;
@property(nonatomic, copy)NSString *errormsg;
@property(nonatomic, strong)PageInfoModel *pageInfo;
@end

@interface AppVersion : HttpResponseData
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *downloadUrl;
@property (nonatomic, copy) NSString *versionName;
@property (nonatomic, assign) NSInteger versionCode;
@end
