//
//  NSString+Size.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/2.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

/**
 *  字符串转时间戳
 *
 *  @return
 */
- (NSString *)getTimestamp;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

//注册用户 计算天数
- (int)getVipNumberDay:(NSString *)currentTime;

@end
