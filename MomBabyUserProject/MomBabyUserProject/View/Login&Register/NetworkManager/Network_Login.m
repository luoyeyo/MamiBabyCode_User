//
//  Network_Login.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/1.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "Network_Login.h"

@implementation Network_Login

- (void)loginWithParams:(Input_params *)params responseBlock:(void (^)(LLError *,NSString *token))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self post:kApiLogin params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            UserInfoEntity *data = [[UserInfoEntity alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,data.token);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getUserInfoWithToken:(NSString *)token responseBlock:(void (^)(LLError *))responseBlock {
    NSDictionary *dic = @{@"Authorization":token ? token : @""};
    [self get:kApiGetUserInfo params:nil additionalHeader:dic response:^(LLError *error, id responseData) {
        if (!error) {
            
            UserInfoEntity *data = [[UserInfoEntity alloc] initWithDictionary:responseData error:nil];
            // 这2个请求下来是没有的
            data.token = token;
            if (data.babys.count > 0) {
                data.currentBaby = data.babys[0];
            }
            // 如果是已登录的用户调用这个方法 证明是首页在刷新用户信息 这是修改用户的状态为本地修改后的状态 以为每次会被服务器重置
            if (kUserInfo.isLogined) {
                data.status = kUserInfo.status;
            }
            // 同步信息
            [UserInfoEntity syncUserInfo:data];
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)getVerifyCodeWith:(Input_params *)params responseBlock:(void (^)(LLError *err))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self get:kApiGetVerify params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)putUserInfoWith:(Input_params *)params responseBlock:(void (^)(LLError *error))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    NSString *url = [NSString stringWithFormat:@"%@/%ld",kApiGetUserInfo,kUserInfo.Id];
    [self put:url params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

@end
