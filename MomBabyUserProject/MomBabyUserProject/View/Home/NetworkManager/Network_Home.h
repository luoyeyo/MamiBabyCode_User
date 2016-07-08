//
//  Network_Vaccinate.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/10.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "NetworkManager.h"
#import "SystemMessage.h"
#import "DiscoverListModel.h"
#import "ArticleDetailsModel.h"

#define kShareManager_Home [Network_Home sharedManager]

@interface Network_Home : NetworkManager

// 首页数据
@property (nonatomic, strong) DiscoverListModel *homeInfo;

+ (instancetype)sharedManager;
/**
 *  获取系统消息
 *
 *  @param responseBlock
 */
- (void)getMessageWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id data))responseBlock;

/**
 *  获取宝宝信息
 *
 *  @param responseBlock
 */
- (void)getHomeInfoWithParams:(Input_params *)params responseBlock:(void (^)(LLError *error))responseBlock;

/**
 *  获取文章详情
 *
 *  @param Id
 *  @param responseBlock 
 */
- (void)getArticlesDetailsInfoWithId:(NSString *)Id responseBlock:(void (^)(LLError *error,ArticleDetailsModel *data))responseBlock;

- (void)getRecommendArticlesListWithId:(NSString *)Id responseBlock:(void (^)(LLError *error,ArticleListModel *data))responseBlock;
//
///**
// *  添加宝宝
// *
// *  @param responseBlock
// */
//- (void)addNewBabyInfoWithBabyID:(NSString *)babyId responseBlock:(void (^)(LLError *error))responseBlock;
//
///**
// *  获取接种单位信息
// *
// *  @param Id
// *  @param responseBlock 
// */
//- (void)getOrganizationInfoWithOrganizationID:(NSString *)Id responseBlock:(void (^)(LLError *error))responseBlock;
//
//- (void)getNewVersionResponseBlock:(void (^)(AppVersion *))responseBlock;
//
///**
// *  查询宝宝
// *
// *  @param params
// *  @param responseBlock
// */
//- (void)queryBabyWith:(Input_params *)params responseBlock:(void (^)(LLError *error,NSArray *list))responseBlock;
//
///**
// *  获取宝宝接种计划
// *
// *  @param params
// *  @param responseBlock 
// */
//- (void)getBabyInoculatePlanWith:(Input_params *)params responseBlock:(void (^)(LLError *error))responseBlock;
//
///**
// *  获取用户添加的baby
// *
// *  @param params
// *  @param responseBlock
// */
//- (void)getUserBabyResponseBlock:(void (^)(LLError *error))responseBlock;
//
//
//#pragma mark - 消息
//
///**
// *  获取通知消息
// *
// *  @param params
// *  @param responseBlock
// */
//- (void)getNotiMessageWith:(Input_params *)params responseBlock:(void (^)(LLError *error))responseBlock;

@end
