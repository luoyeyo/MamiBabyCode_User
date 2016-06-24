//
//  UserInfoEntity.m
//  BaseProject
//
//  Created by luoye on 15-1-24.
//  Copyright (c) 2015年 luoye. All rights reserved.
//

#import "UserInfoEntity.h"
#import "UserDefaults.h"
#import "JPUSHService.h"

#define ClassImageFilepath [NSHomeDirectory() stringByAppendingString:@"/Documents/classImage.data"]
// 医院info
#define UserHospitalInfoFilepath [NSHomeDirectory() stringByAppendingString:@"/Documents/hospitalInfo.data"]

@implementation UserInfoEntity

//单例化
+ (instancetype)sharedInstance {
    static UserInfoEntity *sUserInfoEntity = nil;
    static dispatch_once_t sOnceToken;
    dispatch_once(&sOnceToken, ^{
        UserInfoEntity *userEntityCache = [UserDefaults userInfo];
        if (nil != userEntityCache) {
            sUserInfoEntity = userEntityCache;
        } else {
            sUserInfoEntity = [[self alloc] init];
        }
    });

    return sUserInfoEntity;
}

- (BabyInfoModel *)currentBaby {
    
    if (!_currentBaby) {
        _currentBaby = [[BabyInfoModel alloc] init];
    }
    return _currentBaby;
}

+ (void)syncUserInfo:(UserInfoEntity *)data {
    UserInfoEntity *user = [UserInfoEntity sharedInstance];

    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([UserInfoEntity class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        // 获取属性名称
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        // 利用运行时赋值
        id newObj = [data valueForKey:propName];
        [user setValue:newObj forKey:propName];
    }
    [user synchronize];
}

- (void)synchronize {
    [UserDefaults setUserInfoEntity:self];
}

- (BOOL)isLogined {
    return ![NSString isEmptyString:self.token];
}

- (void)exitUser {
    UserInfoEntity *userNew = [[UserInfoEntity alloc] init];
    [UserInfoEntity syncUserInfo:userNew];
    [UserDefaults saveObject:nil forKey:@"userIcon"];
    [JPUSHService setTags:nil alias:@"" callbackSelector:nil object:nil];
    [UserInfoEntity saveHospitalInfo:nil];
}

/**
 *  请求获取用户信息
 *
 *  @param token
 */
- (void)updateUserInfo {
    if (![kUserInfo isLogined]) {
        return;
    }
    [[[Network_Login alloc] init] getUserInfoWithToken:kUserInfo.token responseBlock:^(LLError *error) {
        if (!error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotiModifyUserInfo object:nil];
        }
    }];
}

- (void)setUserUnreadCount:(NSInteger)unreadCount {
    kUserInfo.unreadCount = unreadCount;
    [kUserInfo synchronize];
    if (unreadCount == 0) {
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:kObserverBadgeNum object:nil];
}

- (void)userTokenFailure {
    ReturnIf(!self.token || self.token.length == 0);
    [self exitUser];
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotiTokenFailure object:nil];
//    [kAppDelegate toLoginAgain];
}

//存储建档医院信息
+ (void)saveHospitalInfo:(id)arr {
    
    if (UserHospitalInfoFilepath.length == 0) {
        [[NSFileManager defaultManager] createDirectoryAtPath:UserHospitalInfoFilepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // 归档
    if ([NSKeyedArchiver archiveRootObject:arr toFile:UserHospitalInfoFilepath]) {
        
    } else {
        
    }
}

+ (id)hospitalInfo {
    // 解档
    id hospital = [NSKeyedUnarchiver unarchiveObjectWithFile:UserHospitalInfoFilepath];
    return hospital;
}

@end
