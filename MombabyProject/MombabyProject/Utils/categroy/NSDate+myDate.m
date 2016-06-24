//
//  NSDate+myDate.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/12/10.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "NSDate+myDate.h"

@implementation NSDate (myDate)

// 月先加9 日再加7
//末次月经时间 得到预产期
- (NSDate *)getDueDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int year = [[formatter stringFromDate:self] intValue];
    [formatter setDateFormat:@"MM"];
    int month = [[formatter stringFromDate:self] intValue];
    [formatter setDateFormat:@"dd"];
    int day = [[formatter stringFromDate:self] intValue];
    
    int newMonth = month+9;
    if (newMonth > 12) {
        year++;
        newMonth -= 12;
    }
    
    int monthCount;
    switch (newMonth) {
        case 1:
            monthCount = 31;
            break;
        case 2:
            if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
                monthCount = 29;
            } else {
                monthCount = 28;
            }
            break;
        case 3:
            monthCount = 31;
            break;
        case 4:
            monthCount = 30;
            break;
        case 5:
            monthCount = 31;
            break;
        case 6:
            monthCount = 30;
            break;
        case 7:
            monthCount = 31;
            break;
        case 8:
            monthCount = 31;
            break;
        case 9:
            monthCount = 30;
            break;
        case 10:
            monthCount = 31;
            break;
        case 11:
            monthCount = 30;
            break;
        case 12:
            monthCount = 31;
            break;
        default:
            break;
    }
    
    int newDay = day+7;
    if (newDay > monthCount) {
        newMonth++;
        newDay -= monthCount;
    }
    NSString * dateString = [NSString stringWithFormat:@"%d %d %d",year,newMonth,newDay];
    [formatter setDateFormat:@"yyyy M d"];
    NSDate * date = [formatter dateFromString:dateString];
    return date;
}

// 反推 日先减7 然后 月减9
//预产期时间 反推出 末次月经时间
- (NSDate *)getMensesDate
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int year = [[formatter stringFromDate:self] intValue];
    [formatter setDateFormat:@"MM"];
    int month = [[formatter stringFromDate:self] intValue];
    [formatter setDateFormat:@"dd"];
    int day = [[formatter stringFromDate:self] intValue];
    
    int newMonth = month-9;
    
    int monthCount = 0;
    switch (month-1) {
        case 0:
            monthCount = 31;
            break;
        case 1:
            monthCount = 31;
            break;
        case 2:
            if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
                monthCount = 29;
            } else {
                monthCount = 28;
            }
            break;
        case 3:
            monthCount = 31;
            break;
        case 4:
            monthCount = 30;
            break;
        case 5:
            monthCount = 31;
            break;
        case 6:
            monthCount = 30;
            break;
        case 7:
            monthCount = 31;
            break;
        case 8:
            monthCount = 31;
            break;
        case 9:
            monthCount = 30;
            break;
        case 10:
            monthCount = 31;
            break;
        case 11:
            monthCount = 30;
            break;
        case 12:
            monthCount = 31;
            break;
        default:
            break;
    }
    
    int newDay = day - 7;
    if (newDay <= 0) {
        newMonth--;
        newDay = monthCount+newDay;
    }
    
    if (newMonth <= 0) {
        year--;
        newMonth = 12+newMonth;
    }
    
    NSString * dateString = [NSString stringWithFormat:@"%d %d %d",year,newMonth,newDay];
    [formatter setDateFormat:@"yyyy M d"];
    NSDate * date = [formatter dateFromString:dateString];
    return date;
}


//
- (int)getNumberDay
{
    NSDate * DueDate = [self getDueDate]; //得到预产期日期
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM dd"];
    NSString * dateString = [formatter stringFromDate:[NSDate date]];
    NSDate * date = [formatter dateFromString:dateString];//这里改成服务器时间
    NSTimeInterval chaTime = DueDate.timeIntervalSince1970-date.timeIntervalSince1970;
    int day = chaTime/60/60/24;
    return day;
}



- (int)getHuaiYunNumberDay
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM dd"];
    NSString * dateString = [formatter stringFromDate:[NSDate date]];
    NSDate * date = [formatter dateFromString:dateString];//这里改成服务器时间
    NSTimeInterval chaTime = date.timeIntervalSince1970-self.timeIntervalSince1970;
    int day = chaTime/60/60/24 + 1;
    if (day > 293) {
        day = 293;
    }
    return day;
}



- (int)getChuShengNumberDay
{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM dd"];
    NSString * dateString = [formatter stringFromDate:[NSDate date]];
    NSDate * date = [formatter dateFromString:dateString];//这里改成服务器时间
    NSTimeInterval chaTime = date.timeIntervalSince1970 + 28800-self.timeIntervalSince1970;
    int day = chaTime/60/60/24;
    return day;
}

@end
