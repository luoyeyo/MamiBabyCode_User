//
//  NSObject+Util.h
//  AgentForWorld
//
//  Created by 罗野 on 15/9/10.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Util)

/**
 *  字典转对象
 *
 *  @param dic 数据字典
 *
 *  @return 对象
 */
- (instancetype)initializeWithDic:(NSDictionary*)dic;

@end
