//
//  NSDate+Birthday.h
//  OCTEST
//
//  Created by 罗野 on 16/5/11.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgeEntity : NSObject

// 年月日
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger day;
// 拼接的字符串   -- 1岁2个月2天
@property (nonatomic, copy) NSString *ageString;

@end

@interface NSDate (Birthday)

/**
 *  根据生日获取年龄
 *
 *  @param birthday
 *
 *  @return 
 */
+ (AgeEntity *)getAgeWithBirthday:(NSTimeInterval)birthday;

/**
 *  获取宝宝个个月零
 *
 *  @param birth
 *
 *  @return
 */
+ (NSArray *)getBabyVaccineTimeSoltWithBirthday:(NSTimeInterval)birth;

@end
