//
//  Network_Discover.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/2.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "Network_Discover.h"

@implementation Network_Discover

- (void)getDiscoverListCellWithStatus:(BOOL)status params:(Input_params *)params ResponseBlock:(void (^)(LLError *, NSArray *))responseBlock {
    NSString *url = kGET_KID_DISCOVERY;
    if (status == YES) {
        url = kGET_MOM_DISCOVERY;
    }
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self get:url params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            DiscoverListModel *list = [[DiscoverListModel alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,list.list);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getArticlesListWithParams:(Input_params *)params ResponseBlock:(void (^)(LLError *error,NSArray *list))responseBlock {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self get:kGET_ARTICLES params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
//            DiscoverListModel *list = [[DiscoverListModel alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,[responseData objectForKey:@"list"]);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getArticlesDetailsWithParams:(NSString *)articlesId ResponseBlock:(void (^)(LLError *error,id response))responseBlock {
    NSString *url = [NSString stringWithFormat:@"%@/%@",kGET_ARTICLES_DETAILS,articlesId];
    [self get:url params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil,responseData);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)postCollectThisArticlesWithId:(NSString *)articlesId ResponseBlock:(void (^)(LLError *error))responseBlock {
//    NSString *url = [NSString stringWithFormat:@"%@/%@",kPOST_COLLECT_ARTICLES,articlesId];
    NSString *url = [kPOST_COLLECT_ARTICLES stringByReplacingOccurrencesOfString:@"articlesId" withString:articlesId];
    [self post:url params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotiCollectionSuccess object:nil];
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)deleteCollectThisArticlesWithId:(NSString *)articlesId ResponseBlock:(void (^)(LLError *error))responseBlock {
    NSDictionary * dic = @{@"ids":articlesId};
    [self deleteR:kDELETE_DELETE_ARTICLES params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotiCancelCollectionSuccess object:nil];
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)getWikiViewControllerWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id response))responseBlock {
    [self get:kGET_DISCOVERY_ITEM params:params additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil,responseData);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)postLikeThisArticlesWithId:(NSString *)articlesId ResponseBlock:(void (^)(LLError *error))responseBlock {
    
    NSDictionary *dic = @{@"id":articlesId};
    [self post:kPOST_LIKE_ARTICLES params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotiLikeSuccess object:nil];
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)deleteLikeThisArticlesWithId:(NSString *)articlesId ResponseBlock:(void (^)(LLError *error))responseBlock {
    NSString *url = [kDELETE_LIKE_ARTICLES stringByReplacingOccurrencesOfString:@":id" withString:articlesId];
    [self deleteR:url params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotiCancelLikeSuccess object:nil];
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)getFoodsInfoWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id response))responseBlock {
    [self get:kGET_FOODSINFO params:params additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil,responseData);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getNutritionDataWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id response))responseBlock {
    [self get:kGET_NUTRITIONS params:params additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil,responseData);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getFoodListWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id response))responseBlock {
    [self get:kGET_FOODLIST params:params additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil,responseData);
        } else {
            responseBlock(error,nil);
        }
    }];
}

@end
