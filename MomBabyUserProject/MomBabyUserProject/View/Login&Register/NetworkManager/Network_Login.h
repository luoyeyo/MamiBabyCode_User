//
//  Network_Login.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/1.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "NetworkManager.h"

@interface Network_Login : NetworkManager

/**
 *  登陆注册 同一个
 *
 *  @param params
 *  @param responseBlock  
 */
- (void)loginWithParams:(Input_params *)params responseBlock:(void (^)(LLError *error,NSString *token))responseBlock;

- (void)getUserInfoWithToken:(NSString *)token responseBlock:(void (^)(LLError *error))responseBlock;

- (void)getVerifyCodeWith:(Input_params *)params responseBlock:(void (^)(LLError *error))responseBlock;

/**
 *  上传用户信息
 *
 *  @param params
 *  @param responseBlock    
 */
- (void)putUserInfoWith:(Input_params *)params responseBlock:(void (^)(LLError *error))responseBlock;

@end
