//
//  Network_Mine.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/10.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "Network_Mine.h"

@implementation Network_Mine

- (void)verifyBindingPhoneWith:(Input_params *)params responseBlock:(void (^)(LLError *))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self get:kApiCheckVerifyCode params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)modifyBindingPhoneWith:(Input_params *)params responseBlock:(void (^)(LLError *))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self put:kApiModifyPhone params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)modifyMyInfoWith:(NSDictionary *)params responseBlock:(void (^)(LLError *))responseBlock {
    NSString *url = [NSString stringWithFormat:@"%@/%ld",kApiModifyMyInfo,kUserInfo.Id];
    [self put:url params:params additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)feedbackWith:(NSString *)content responseBlock:(void (^)(LLError *))responseBlock {
    [self post:kApiFeedback params:@{@"content":content} additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)requestQiNiuUploadTokenResponseBlock:(void (^)(LLError *error, NSString *token))responseBlock {
    [self get:kApiQiNiuImageToken params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            NSString *qiniu;
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                qiniu = responseData[@"upToken"];
            }
            responseBlock(nil,qiniu);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getMyCollectionArticlesWith:(Input_params *)params responseBlock:(void (^)(LLError *err,id responseData))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self get:kGET_GET_ARTICLES params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil,responseData);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)deleteMyCollectionArticlesWith:(NSString *)idStr responseBlock:(void (^)(LLError *err))responseBlock {
    NSString *url = [NSString stringWithFormat:@"%@?ids=%@",kDELETE_DELETE_ARTICLES,idStr];
    [self deleteR:url params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}


@end
