//
//  NSObject+Util.m
//  AgentForWorld
//
//  Created by 罗野 on 15/9/10.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "NSObject+Util.h"
#import <objc/runtime.h>

@implementation NSObject (Util)

- (instancetype)initializeWithDic:(NSDictionary*)dic
{
    return [self setPropertiesWithDic:dic];
}

- (instancetype)setPropertiesWithDic:(NSDictionary *)info
{
    NSArray *objPropertList = [self propertyList];
    NSArray *dicAllKeys = [info allKeys];
    
    [objPropertList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *key = [self replaceKeyIfNeed:obj];
        if ([dicAllKeys containsObject:key]) {
            NSObject *value = [info objectForKey:key];
            if (nil != value && ![value isKindOfClass:[NSNull class]] && nil != key ) {
                [self setValue:value forKey:obj];
            }
        }
    }];
    return self;
}
/**
 *  关键字判断
 *
 *  @param key
 *
 *  @return
 */
- (NSString*)replaceKeyIfNeed:(NSString*)key
{
    if ([key isEqualToString:@"Id"]) {
        return @"id";
    }
    if ([key isEqualToString:@"Description"]) {
        return @"description";
    }
//    if ([key isEqualToString:@"desContent"]) {
//        return @"description";
//    }
    if ([key isEqualToString:@"Continue"]) {
        return @"continue";
    }
    return key;
}
/**
 *  获取属性列表
 */
- (NSMutableArray *)propertyList
{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [array addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return array;
}

//+ (UIColor *)colorFromHexRGB:(NSString *)inColorString
//{
//    UIColor *result = nil;
//    unsigned int colorCode = 0;
//    unsigned char redByte, greenByte, blueByte;
//    
//    if (nil != inColorString)
//    {
//        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
//        (void) [scanner scanHexInt:&colorCode]; // ignore error
//    }
//    redByte = (unsigned char) (colorCode >> 16);
//    greenByte = (unsigned char) (colorCode >> 8);
//    blueByte = (unsigned char) (colorCode); // masks off high bits
//    result = [UIColor
//              colorWithRed: (float)redByte / 0xff
//              green: (float)greenByte/ 0xff
//              blue: (float)blueByte / 0xff
//              alpha:1.0];
//    return result;
//}

@end
