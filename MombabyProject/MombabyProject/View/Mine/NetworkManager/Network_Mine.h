//
//  Network_Mine.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/10.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "NetworkManager.h"

@interface Network_Mine : NetworkManager

/**
 *  验证当前绑定手机号
 *
 *  @param params  手机号和验证码
 *  @param responseBlock
 */
- (void)verifyBindingPhoneWith:(Input_params *)params responseBlock:(void (^)(LLError *))responseBlock;
/**
 *  绑定新手机
 *
 *  @param params        新手机号和验证码
 *  @param responseBlock
 */
- (void)modifyBindingPhoneWith:(Input_params *)params responseBlock:(void (^)(LLError *))responseBlock;

/**
 *  修改个人信息
 *
 *  @param params
 *  @param responseBlock 
 */
- (void)modifyMyInfoWith:(NSDictionary *)params responseBlock:(void (^)(LLError *))responseBlock;

/**
 *  信息反馈
 *
 *  @param content
 *  @param responseBlock
 */
- (void)feedbackWith:(NSString *)content responseBlock:(void (^)(LLError *))responseBlock;

/**
 *  获取七牛token
 *
 *  @param responseBlock 
 */
- (void)requestQiNiuUploadTokenResponseBlock:(void (^)(LLError *error, NSString *token))responseBlock;

/**
 *  获取我的收藏的文章
 *
 *  @param params
 *  @param responseBlock 
 */
- (void)getMyCollectionArticlesWith:(Input_params *)params responseBlock:(void (^)(LLError *err,id responseData))responseBlock;

/**
 *  删除收藏的文章
 *
 *  @param idStr  文章ID
 *  @param responseBlock
 */
- (void)deleteMyCollectionArticlesWith:(NSString *)idStr responseBlock:(void (^)(LLError *err))responseBlock;

@end
