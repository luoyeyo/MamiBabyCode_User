//
//  NSDate+Birthday.m
//  OCTEST
//
//  Created by 罗野 on 16/5/11.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "NSDate+Birthday.h"

@implementation AgeEntity

@end

@implementation NSDate (Birthday)

+ (AgeEntity *)getAgeWithBirthday:(NSTimeInterval)birthday {
    
    AgeEntity *age = [[AgeEntity alloc] init];
    if (!birthday || birthday == 0) {
        return age;
    }
    
    NSDate *birth = [NSDate dateWithTimeIntervalSince1970:birthday];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:birth toDate:now options:NSCalendarWrapComponents];
    
    age.year = [dateComponent year];
    age.month = [dateComponent month];
    age.day = [dateComponent day];
    NSMutableString *ageStr = [NSMutableString string];
    if (age.year != 0) {
        [ageStr appendFormat:@"%ld岁",age.year];
    }
    if (age.month != 0) {
        [ageStr appendFormat:@"%ld个月",age.month];
    }
    if (age.day != 0) {
        [ageStr appendFormat:@"%ld天",age.day];
    }
    age.ageString = ageStr;
    return age;
}

/**
 *  获取宝宝月龄
 *
 *  @param birth
 *
 *  @return
 */
+ (NSArray *)getBabyVaccineTimeSoltWithBirthday:(NSTimeInterval)birth {
    
    NSMutableArray *dateArr = [NSMutableArray array];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDateComponents *dateComponent = [[NSDateComponents alloc] init];
    NSDate * const startDate = [NSDate dateWithTimeIntervalSince1970:birth];
    for (int i = 0; i < 18; i ++) {
        // 在一年以内 都是按照天
        if (i < 13) {
            [dateComponent setMonth:i];
            NSDate *date = [calendar dateByAddingComponents:dateComponent toDate:startDate options:NSCalendarMatchNextTime];
            NSString *dateString = [formatter stringFromDate:date];
            [dateArr addObject:dateString];
            continue;
        }
        switch (i) {
                // 13 开始 分别是  1.5岁  2岁  3岁。。。。。。
            case 13:
                [dateComponent setMonth:18];
                break;
            case 14:
                [dateComponent setMonth:0];
                [dateComponent setYear:2];
                break;
            case 15:
                [dateComponent setYear:3];
                break;
            case 16:
                [dateComponent setYear:4];
                break;
            default:
                [dateComponent setYear:6];
                break;
        }
        NSDate *date = [calendar dateByAddingComponents:dateComponent toDate:startDate options:NSCalendarMatchNextTime];
        NSString *dateString = [formatter stringFromDate:date];
        
        [dateArr addObject:dateString];
    }
    // 拼写时间段
    NSMutableArray *newDateArr = [NSMutableArray array];
    for (int i = 0; i < dateArr.count; i ++) {
        if (i == dateArr.count - 1) {
            [newDateArr addObject:[dateArr lastObject]];
            break;
        }
        NSString *dateString = dateArr[i];
        NSString *newDateString = dateArr[i + 1];
        [newDateArr addObject:[NSString stringWithFormat:@"%@-%@",dateString,newDateString]];
    }
    return newDateArr;
}

@end
