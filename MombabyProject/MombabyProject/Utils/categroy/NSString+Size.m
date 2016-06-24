//
//  NSString+Size.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/2.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (NSString *)getTimestamp {
    NSString * timeStr = self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    
    NSTimeZone * timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:timeStr];
    
    NSString * physicalTime = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return physicalTime;
}

//返回字符串所占用的尺寸.
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (int)getVipNumberDay:(NSString *)currentTime
{
    //得到服务器时间.(忽略命名)
    NSTimeInterval dueTime = [self doubleValue];
    NSDate * dueDate =[NSDate dateWithTimeIntervalSince1970:dueTime];
    
    //得到末次月经时间
    NSTimeInterval curTime = [currentTime doubleValue];
    NSDate * currentTimeDate =[NSDate dateWithTimeIntervalSince1970:curTime];
    
    NSTimeInterval chaTime = dueDate.timeIntervalSince1970 - currentTimeDate.timeIntervalSince1970;
    //怀孕天数需要加1
    int day = chaTime/60/60/24 + 1;
    
    return day;
}


@end
