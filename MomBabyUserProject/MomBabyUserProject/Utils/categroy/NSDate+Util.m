//
//  NSDate+Util.m
//  imageTest
//
//  Created by 罗野 on 15/11/11.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "NSDate+Util.h"

@implementation GestationalWeeks


@end

@implementation NSDate (Util)

+ (NSArray *)getAfterWeeks {
    
    NSMutableArray *dateArr = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"ee";
    for (int i = 0; i < 8; i ++) {
        NSString *weekStr = [dateFormatter stringFromDate:[self getNextDay:[NSDate date] WithInterval:i]];
        [dateArr addObject:KCWeeks[[weekStr integerValue] - 1]];
    }
    return dateArr;
}

+ (NSArray *)getAfterDays {
    NSMutableArray *dateArr = [NSMutableArray array];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"d";
    for (int i = 0; i < 6; i ++) {
        NSString *dayStr = [dateFormatter stringFromDate:[self getNextDay:[NSDate date] WithInterval:i]];
        [dateArr addObject:dayStr];
    }
    return dateArr;
}

+ (NSDate *)getNextDay:(NSDate *)aDate WithInterval:(NSInteger)index
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day] + index)];
    NSDate *tomorrow = [gregorian dateFromComponents:components];
    return tomorrow;
}

+ (NSDate *)getDateEntryWithDateString:(NSString *)string {
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

+ (GestationalWeeks *)calculationGestationalWeeksWith:(NSTimeInterval)date {
    NSTimeInterval current = [[NSDate date] timeIntervalSince1970];

    long long oneDay = 60 * 60 * 24;
    long long timeInterval = current - date + oneDay;
    GestationalWeeks *weeks = [[GestationalWeeks alloc] init];
    if (date == 0) {
        weeks.week = @0;
        weeks.day = @0;
        weeks.allDay = @0;
        return weeks;
    }
    weeks.week = @((NSInteger)(timeInterval / (oneDay * 7)));
    weeks.day = @((NSInteger)((timeInterval / oneDay) % 7));
    weeks.allDay = @((NSInteger)(timeInterval / oneDay));
    return weeks;
}

+ (GestationalWeeks *)calculationIntervalWeeksWithStart:(NSTimeInterval)startDate end:(NSTimeInterval)endDate {
    
    long long oneDay = 60 * 60 * 24;
    long long timeInterval = endDate - startDate + oneDay;
    GestationalWeeks *weeks = [[GestationalWeeks alloc] init];
    weeks.week = @((NSInteger)(timeInterval / (oneDay * 7)));
    weeks.day = @((NSInteger)((timeInterval / oneDay) % 7));
    weeks.allDay = @((NSInteger)(timeInterval / oneDay));
    return weeks;
}

+ (NSString *)calculationIntervalWithStart:(NSTimeInterval)startDate {
    
    NSDate *current = [self getTimeInTheMorningToday];
    long long oneDay = 60 * 60 * 24;
    long long timeInterval = startDate - current.timeIntervalSince1970;
    NSNumber *day = @((NSInteger)(timeInterval / oneDay));
    return [NSString stringWithFormat:@"%@",day];
}

/**
 *  获取今天凌晨时间
 *
 *  @return
 */
+ (NSDate *)getTimeInTheMorningToday {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSDate *result = [formatter dateFromString:dateStr];
    return result;
}

+ (id)dateFormatter
{
    return [[self alloc] init];
}

+ (id)dateFormatterWithFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return dateFormatter;
}

+ (id)defaultDateFormatter
{
    return [self dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSString *)dateStringWithTimeInterval:(NSTimeInterval)time formatterStr:(NSString *)str {
    NSDateFormatter *formatter = [self dateFormatterWithFormat:str];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    if (time == 0) {
        return @"-";
    }
    return [formatter stringFromDate:date];
}

+ (NSString *)dateStringWithTimeInterval:(NSTimeInterval)time {
    NSDateFormatter *formatter = [self dateFormatterWithFormat:@"M月d日"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    if (time == 0) {
        return @"-";
    }
    return [formatter stringFromDate:date];
}

+ (NSString *)getCurrentDateString {
    NSDateFormatter *formatter = [self dateFormatterWithFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:[NSDate date]];
}

+ (CGFloat)calculationInculateTimePercentageWithLast:(NSTimeInterval)last next:(NSTimeInterval)next {
    
    NSTimeInterval total = next - last;
    NSTimeInterval current = [NSDate date].timeIntervalSince1970;
    NSTimeInterval surplus = next - current;
    return surplus * 1.0f / (total * 1.0f);
}


@end
