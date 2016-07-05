//
//  UserDefaults.h
//  BaseProject
//
//  Created by wangzhi on 15-1-24.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoEntity.h"

#define UserDefaultKeyPushDeviceToken   @"PushDeviceToken"
#define UserDefaultKeyUserInfoEntity    @"UserInfoEntity"
#define UserDefaultKeyShopSearchHistory      @"ShopSearchHistory"
#define UserDefaultKeyOfficeSearchHistory    @"OfficeSearchHistory"

#define UserDefaultKeyMarkedShopHouse        @"markedShopHouse"
#define UserDefaultKeyMarkedOfficeHouse      @"markedOfficeHouse"

#define UserDefaultKeyVersion      @"CFBundleShortVersionString"


@interface UserDefaults : NSObject

+ (void)saveObject:(NSObject*)object forKey:(NSString*)key;

+ (NSObject*)restoreObjectForKey:(NSString*)key;

//PUSH时用到的deviceToken
+(void)setPushDeviceToken:(NSString*)deviceToken;
+(NSString*)pushDeviceToken;

//登录用户的相关信息
+(void)setUserInfoEntity:(UserInfoEntity*)userInfo;
+(UserInfoEntity*)userInfo;

+ (NSString *)getCurrentVersion;
+ (NSString *)lastVersion;
+ (void)saveCurrentVersion;

@end
