//
//  CalendarLogic1.h
//  Calendar
//
//  Created by 张凡 on 14-7-3.
//  Copyright (c) 2014年 张凡. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CalendarDayModel.h"
#import "NSDate+WQCalendarLogic.h"

@interface CalendarLogic : NSObject
@property (nonatomic, assign) NSInteger todayIndex;
- (NSMutableArray *)reloadCalendarView:(NSDate *)date  selectDate:(NSDate *)date1 needDays:(NSUInteger)days_number;
- (void)selectLogic:(CalendarDayModel *)day;
@end
