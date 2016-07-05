//
//  XMAccountTool.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/12/8.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BabyInfoModel.h"

@class XMAccountModel;
@class BabyInfoModel;

@interface XMAccountTool : NSObject


/***  存储babyInfo*/
+ (void)saveBabyInfo:(NSMutableDictionary *)babyInfo;
/***  读取babyInfo*/
+ (BabyInfoModel *)BabyInfo;



/***  存储vip值*/
+ (void)saveVipType:(NSString *)vipType;
/***  读取vip值*/
+ (NSString *)vipType;



/***  存储用户地理位置*/
+ (void)saveLocation:(NSMutableDictionary *)userLocation;
/***  获取用户地理位置*/
+ (NSDictionary *)userLocation;


///***  存储预产期日期*/
//+ (void)saveDate:(NSString *)date;
///***  读取预产期日期*/
//+ (NSString *)date;

@end
