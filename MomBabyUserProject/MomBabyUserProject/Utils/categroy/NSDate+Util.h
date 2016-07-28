//
//  NSDate+Util.h
//  imageTest
//
//  Created by 罗野 on 15/11/11.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>
// 适配英文环境
#define KCWeeks @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"]

@interface GestationalWeeks : NSObject
// 周余数天
@property (nonatomic, copy) NSNumber *day;
@property (nonatomic, copy) NSNumber *allDay;
@property (nonatomic, copy) NSNumber *week;

@end

@interface NSDate (Util)
/**
 *  获取今天之后的6天 星期数组
 *
 *  @return
 */
+ (NSArray *)getAfterWeeks;

/**
 *  获取今天之后的6天 星期日期
 *
 *  @return
 */
+ (NSArray *)getAfterDays;


/**
 *  获取以某天为参考的 间隔一定天数的date
 *
 *  @param aDate 参考时间
 *  @param index 间隔天数
 *
 *  @return
 */
+ (NSDate *)getNextDay:(NSDate *)aDate WithInterval:(NSInteger)index;
/**
 *  计算孕周
 *
 *  @param date
 *
 *  @return
 */
+ (GestationalWeeks *)calculationGestationalWeeksWith:(NSTimeInterval)date;

/**
 *  把时间字符串转换成时间
 *
 *  @param string （YYYY-MM-dd）只限这个格式
 *
 *  @return 
 */
+ (NSDate *)getDateEntryWithDateString:(NSString *)string;
+ (NSString *)calculationIntervalWithStart:(NSTimeInterval)startDate;

/**
 *  计算两天的时间差(周)
 *
 *  @param startDate
 *  @param endDate
 *
 *  @return
 */
+ (GestationalWeeks *)calculationIntervalWeeksWithStart:(NSTimeInterval)startDate end:(NSTimeInterval)endDate;

/**
 *  获取时间字符串
 *
 *  @param time
 *
 *  @return 
 */
+ (NSString *)dateStringWithTimeInterval:(NSTimeInterval)time;

+ (NSString *)dateStringWithTimeInterval:(NSTimeInterval)time formatterStr:(NSString *)str;

+ (NSString *)getCurrentDateString;

/**
 *  计算接种时间的差距
 *
 *  @param last
 *  @param next
 *
 *  @return
 */
+ (CGFloat)calculationInculateTimePercentageWithLast:(NSTimeInterval)last next:(NSTimeInterval)next;

@end
