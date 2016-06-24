//
//  Network_Discover.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/2.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "NetworkManager.h"
#import "DiscoverListModel.h"

@interface Network_Discover : NetworkManager

/**
 *  获取发现栏目列表
 *
 *  @param status        如果是yes  表示是小孩的栏目 否则是妈妈的
 *  @param params
 *  @param responseBlock 
 */
- (void)getDiscoverListCellWithStatus:(BOOL)status params:(Input_params *)params ResponseBlock:(void (^)(LLError *error,NSArray *list))responseBlock;

/**
 *  获取文章列表
 *
 *  @param params
 *  @param responseBlock
 */
- (void)getArticlesListWithParams:(Input_params *)params ResponseBlock:(void (^)(LLError *error,NSArray *list))responseBlock;

/**
 *  获取文章详情
 *
 *  @param params
 *  @param responseBlock
 */
- (void)getArticlesDetailsWithParams:(NSString *)articlesId ResponseBlock:(void (^)(LLError *error,id response))responseBlock;

/**
 *  收藏文章
 *
 *  @param articlesId
 *  @param responseBlock 
 */
- (void)postCollectThisArticlesWithId:(NSString *)articlesId ResponseBlock:(void (^)(LLError *error))responseBlock;

/**
 *  取消收藏
 *
 *  @param articlesId
 *  @param responseBlock
 */
- (void)deleteCollectThisArticlesWithId:(NSString *)articlesId ResponseBlock:(void (^)(LLError *error))responseBlock;

/**
 *  获取WiKiVC的数据 获取子栏目
 *  接口关联的产品页面:育儿会员-发现、孕期会员-发现
 *  @param params
 *  @param responseBlock
 */
- (void)getWikiViewControllerWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id response))responseBlock;

/**
 *  获取食物信息
 *  接口关联的产品页面:营养查询
 *  @param params
 *  @param responseBlock
 */
- (void)getFoodsInfoWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id response))responseBlock;

/**
 *  获取食物类别列表
 *  接口关联的产品页面:营养查询
 *  @param params
 *  @param responseBlock
 */
- (void)getFoodListWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id response))responseBlock;

/**
 *  获取营养信息
 *  接口关联的产品页面:营养查询
 *  @param params
 *  @param responseBlock
 */
- (void)getNutritionDataWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id response))responseBlock;


@end
