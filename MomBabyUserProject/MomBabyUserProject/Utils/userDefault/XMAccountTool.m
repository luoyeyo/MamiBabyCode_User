//
//  XMAccountTool.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/12/8.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "XMAccountTool.h"

// 预产日期路径
#define DateFilepath [NSHomeDirectory() stringByAppendingString:@"/Documents/date.data"]
// 宝贝信息路径
#define BabyInfoFilepath [NSHomeDirectory() stringByAppendingString:@"/Documents/babyInfo.data"]
// 用户地理位置
#define UserLocationFilepath [NSHomeDirectory() stringByAppendingString:@"/Documents/userLocation.data"]
// vip信息路径
#define VipFilepath [NSHomeDirectory() stringByAppendingString:@"/Documents/vip.data"]

@implementation XMAccountTool


/**
 *  存储预产期日期
 */
+ (void)saveDate:(NSString *)date
{

    // 归档
    if (DateFilepath.length == 0) {
        [[NSFileManager defaultManager] createDirectoryAtPath:DateFilepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if ([NSKeyedArchiver archiveRootObject:date toFile:DateFilepath]) {
//        XMLog(@"存储孕期时间成功date===%@", date);
    }
    else
    {
//        XMLog(@"存储孕期时间失败date===%@", date);
    }
}

/**
 *  读取预产期日期
 */
+ (NSString *)date
{
    // 解档
    NSString *date = [NSKeyedUnarchiver unarchiveObjectWithFile:DateFilepath];
    return date;
}

/**
 *  存储vip值
 */
+ (void)saveVipType:(NSString *)vipType
{
    if (VipFilepath.length == 0) {
        [[NSFileManager defaultManager] createDirectoryAtPath:VipFilepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // 归档
    if ([NSKeyedArchiver archiveRootObject:vipType toFile:VipFilepath]) {
        
//        XMLog(@"存储孕期时间成功BabyInfo===%@", vipType);
    }
    else
    {
//        XMLog(@"存储孕期时间失败BabyInfo===%@", vipType);
    }
}

/**
  *  读取vip值
  */
+ (NSString *)vipType
{
    // 解档
    NSString *vipType = [NSKeyedUnarchiver unarchiveObjectWithFile:VipFilepath];
    return vipType;
}

/**
 *  存储babyInfo
 */
+ (void)saveBabyInfo:(NSMutableDictionary *)babyInfo
{
    if (BabyInfoFilepath.length == 0) {
        [[NSFileManager defaultManager] createDirectoryAtPath:BabyInfoFilepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // 归档
    if ([NSKeyedArchiver archiveRootObject:babyInfo toFile:BabyInfoFilepath]) {
        
//        XMLog(@"存储孕期时间成功BabyInfo===%@", babyInfo);
    }
    else
    {
//        XMLog(@"存储孕期时间失败BabyInfo===%@", babyInfo);
    }
    
}

/**
 *  读取babyInfo
 */
+ (BabyInfoModel *)BabyInfo
{
    // 解档
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:BabyInfoFilepath];
    
    BabyInfoModel *BabyInfo;
    if (dict) {
        BabyInfo = [[BabyInfoModel alloc] initWithDictionary:dict error:nil];
    }
    return BabyInfo;
}

//存储用户地理位置
+ (void)saveLocation:(NSMutableDictionary *)userLocation {
    
    if (UserLocationFilepath.length == 0) {
    [[NSFileManager defaultManager] createDirectoryAtPath:UserLocationFilepath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // 归档
    if ([NSKeyedArchiver archiveRootObject:userLocation toFile:UserLocationFilepath]) {
        
//        XMLog(@"存储用户地理位置成功userLocation===%@", userLocation);
    }
    else
    {
//        XMLog(@"存储用户地理位置失败userLocation===%@", userLocation);
    }
}

+ (NSDictionary *)userLocation{
    // 解档
    NSDictionary *userLocation = [NSKeyedUnarchiver unarchiveObjectWithFile:UserLocationFilepath];
    return userLocation;
}



@end
