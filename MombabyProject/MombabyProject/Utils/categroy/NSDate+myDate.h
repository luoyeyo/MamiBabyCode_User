//
//  NSDate+myDate.h
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/12/10.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (myDate)

//得到预产期
- (NSDate *)getDueDate;

//得到末次月经时间
- (NSDate *)getMensesDate;

//预产期 减去 手机当前的时间 得到 还有多少天出生
- (int)getNumberDay;

//手机当前的时间 减去 末次月经 得到怀孕多少天
- (int)getHuaiYunNumberDay;


//手机当前时间 减去生日 得到出生多少天
- (int)getChuShengNumberDay;
@end
