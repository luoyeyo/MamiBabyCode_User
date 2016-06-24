//
//  UserDefaults.m
//  BaseProject
//
//  Created by wangzhi on 15-1-24.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+ (void)saveObject:(NSObject*)object forKey:(NSString*)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (nil != object) {
        [userDefaults setObject:object forKey:key];
    }else {
        [userDefaults removeObjectForKey:key];
    }

    [userDefaults synchronize];
}

+ (NSObject*)restoreObjectForKey:(NSString*)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:key];
}

+ (void)setPushDeviceToken:(NSString*)deviceToken;
{
    [[self class]saveObject:deviceToken forKey:UserDefaultKeyPushDeviceToken];
}

+ (NSString*)pushDeviceToken
{
    return (NSString*)[[self class]restoreObjectForKey:UserDefaultKeyPushDeviceToken];
}

+ (void)setUserInfoEntity:(UserInfoEntity*)userInfo
{
    NSData *userData = nil;

    if (nil != userInfo) {
        userData = [NSKeyedArchiver archivedDataWithRootObject:userInfo];
    }
    [[self class]saveObject:userData forKey:UserDefaultKeyUserInfoEntity];
}

+ (UserInfoEntity*)userInfo
{
    NSData *userData = (NSData*)[[self class]restoreObjectForKey:UserDefaultKeyUserInfoEntity];
    if (nil != userData) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    }
    return nil;
}

+ (NSString *)getCurrentVersion {
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[UserDefaultKeyVersion];
    return currentVersion;
}

+ (NSString *)lastVersion {
    // 上一次的使用版本（存储在沙盒中的版本号）
    return [[NSUserDefaults standardUserDefaults] objectForKey:UserDefaultKeyVersion];
}

+ (void)saveCurrentVersion {
    // 将当前的版本号存进沙盒
    [[NSUserDefaults standardUserDefaults] setObject:[self getCurrentVersion] forKey:UserDefaultKeyVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
