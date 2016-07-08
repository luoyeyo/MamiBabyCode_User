//
//  Network_Vaccinate.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/10.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "Network_Home.h"

@implementation Network_Home

+ (instancetype)sharedManager {
    static id _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (void)getMessageWithParams:(NSDictionary *)params ResponseBlock:(void (^)(LLError *error,id data))responseBlock {
    [self get:kApiGetNotiMessage params:params additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            responseBlock(nil,responseData);
        } else {
            responseBlock(error,nil);
        }
    }];
}

- (void)getHomeInfoWithParams:(Input_params *)params responseBlock:(void (^)(LLError *))responseBlock {
    NSString *url;
    if (kUserInfo.status == kUserStateMum) {
        url = kApiGetHomeMumInfo;
    } else {
        url = kApiGetHomeBabyInfo;
    }
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
    [self get:url params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (!error) {
            self.homeInfo = [[DiscoverListModel alloc] initWithDictionary:responseData error:nil];
            kUserInfo.hospitalId = self.homeInfo.hospitalId;
            [kUserInfo synchronize];
            responseBlock(nil);
        } else {
            responseBlock(error);
        }
    }];
}

- (void)getArticlesDetailsInfoWithId:(NSString *)Id responseBlock:(void (^)(LLError *,ArticleDetailsModel *data))responseBlock {
    NSString *url = [NSString stringWithFormat:@"%@/%@",kGET_ARTICLES_DETAILS,Id];
    [self get:url params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
        if (error) {
            responseBlock(error,nil);
        } else {
            ArticleDetailsModel *model = [[ArticleDetailsModel alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,model);
        }
    }];
}

- (void)getRecommendArticlesListWithId:(NSString *)Id responseBlock:(void (^)(LLError *error,ArticleListModel *data))responseBlock {
    NSDictionary *dic = @{@"id":Id};
    [self get:kApiGetRecommendList params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
        if (error) {
            responseBlock(error,nil);
        } else {
            ArticleListModel *model = [[ArticleListModel alloc] initWithDictionary:responseData error:nil];
            responseBlock(nil,model);
        }
    }];
}

//- (void)addNewBabyInfoWithBabyID:(NSString *)babyId responseBlock:(void (^)(LLError *))responseBlock {
//    if (!babyId) {
//        babyId = @"";
//    }
//    [self post:kApiGetBabyInfo params:@{@"id":babyId} additionalHeader:nil response:^(LLError *error, id responseData) {
//        if (!error) {
//            kUserInfo.currentBaby = [[BabyDetailsInfo alloc] initWithDictionary:responseData error:nil];
//            [kUserInfo synchronize];
//            responseBlock(nil);
//        } else {
//            responseBlock(error);
//        }
//    }];
//}
//
//- (void)getOrganizationInfoWithOrganizationID:(NSString *)Id responseBlock:(void (^)(LLError *))responseBlock {
//    if (!Id) {
//        Id = @"";
//    }
//    [self get:kApiGetOrganizations params:@{@"id":Id} additionalHeader:nil response:^(LLError *error, id responseData) {
//        if (!error) {
//            self.organizationInfo = [[OrganizationDetailsInfo alloc] initWithDictionary:responseData error:nil];
//            responseBlock(nil);
//        } else {
//            responseBlock(error);
//        }
//    }];
//}
//
//- (void)getNewVersionResponseBlock:(void (^)(AppVersion *))responseBlock {
//    [self get:kApiVersion params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
//        if (!error && responseData && [responseData isKindOfClass:[NSDictionary class]]) {
//            AppVersion *version = [[AppVersion alloc] initWithDictionary:responseData[@"version"] error:nil];
//            
//            responseBlock(version);
//        } else {
//            responseBlock(nil);
//        }
//    }];
//}
//
//- (void)queryBabyWith:(Input_params *)params responseBlock:(void (^)(LLError *,NSArray *))responseBlock {
//    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
//    [self get:kApiQueryBaby params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
//        if (!error) {
//            BabyListModel *list = [[BabyListModel alloc] initWithDictionary:responseData error:nil];
//            responseBlock(nil,list.list);
//        } else {
//            responseBlock(error,nil);
//        }
//    }];
//}
//
//- (void)getBabyInoculatePlanWith:(Input_params *)params responseBlock:(void (^)(LLError *))responseBlock {
//    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
//    [self get:kApiInoculatePlan params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
//        if (!error) {
//            kUserInfo.inoculatePlanList = [InoculatePlanListModel createInoculatePlanListWith:responseData];
//            [UserInfoEntity syncUserInfo:kUserInfo];
//            responseBlock(nil);
//        } else {
//            responseBlock(error);
//        }
//    }];
//}
//
//- (void)getUserBabyResponseBlock:(void (^)(LLError *error))responseBlock {
//    [self get:kApiUserBaby params:nil additionalHeader:nil response:^(LLError *error, id responseData) {
//        if (!error) {
//            BabyListModel *list = [[BabyListModel alloc] initWithDictionary:responseData error:nil];
//            kUserInfo.userBaby = list.list;
//            // 如果当前没有存宝宝信息 并且列表里有  就把第一个作为默认
//            if (!kUserInfo.currentBaby && list.list.count > 0) {
//                kUserInfo.currentBaby = list.list[0];
//            }
//            [UserInfoEntity syncUserInfo:kUserInfo];
//            responseBlock(nil);
//        } else {
//            responseBlock(error);
//        }
//    }];
//}
//
//- (void)getNotiMessageWith:(Input_params *)params responseBlock:(void (^)(LLError *))responseBlock {
//    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:params];
//    [self get:kApiGetNotiMessage params:dic additionalHeader:nil response:^(LLError *error, id responseData) {
//        if (!error) {
//            if ([responseData[@"list"] isKindOfClass:[NSArray class]] && responseData[@"list"] != nil && [responseData[@"list"] count] > 0) {
//                [DataManager saveMessage:responseData[@"list"]];
//                [DataManager updateLastReceiveMessageTime];
//            }
//            responseBlock(nil);
//        } else {
//            responseBlock(error);
//        }
//    }];
//}

@end
