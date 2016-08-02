//
//  WebItem.m
//  testsss
//
//  Created by 罗野 on 16/4/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "WebItem.h"
#import <objc/runtime.h>

@implementation WebItem
//if (array.count == 0) {
//    item.defaultUrl = url;
//}else if (array.count == 1) { //
//    item.defaultUrl = array[0];
//}else
+ (WebItem *)createWebItemWithUrl:(NSString *)url {
    if (url.length == 0) {
        return nil;
    }
    // 先用参数分隔符? 分隔参数
    NSRange range = [url rangeOfString:@"?"];
    NSMutableArray *array = [NSMutableArray array];
    if (range.length == 0) {
        [array addObject:url];
    } else {
        NSString *strOne = [url substringToIndex:range.location + 1];
        NSString *strTwo = [url substringFromIndex:range.location + 1];
        [array addObject:strOne];
        [array addObject:strTwo];
    }
    WebItem *item = [[self alloc] init];
    // 存放所有参数
    NSArray *params;
    if (array.count > 1) {
        // 用& 分隔参数
        params = [[array lastObject] componentsSeparatedByString:@"&"];
    } else {
        // 不带参数直接返回
        item.defaultUrl = [array firstObject];
        return item;
    }
    // 因为可能吧ID之类的参数也截取了  所以需要把它拼接回去
    NSMutableString *baseUrl = [NSMutableString stringWithString:[NSString stringWithFormat:@"%@",[array firstObject]]];
    // 用来存放参数拼接
    // 遍历arr  与对象的各个属性名称进行比较
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([WebItem class], &propsCount);
    for(int i = 0;i < propsCount; i++)
    {
        objc_property_t prop = props[i];
        // 获取属性名称
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        for (NSString *str in params) {
            if ([str ios7IsContainsString:propName]) {
                // 查询到开始位置与这段字符的长度是否在首位 不在首位就跳过 防止后面的参数也有这个字段
                NSRange range = [str rangeOfString:propName];
                if (range.location != 0) break;
                // 减掉属性名称
                NSString *newStr = [str stringByReplacingOccurrencesOfString:propName withString:@""];
                // 去掉= (第一个开始截取)
                // 将url进行解码
                NSString *value = [[newStr substringFromIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                // kvc赋值
                [item setValue:value forKey:propName];
            }
        }
    }
    // 拼接回参数
    for (NSString *str in params) {
        if (![str ios7IsContainsString:@"labelTitle"] && ![str ios7IsContainsString:@"labelItemTitle"] && ![str ios7IsContainsString:@"labelItemUrl"]) {
            // 解码
            NSString *uncodeStr = [str stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [baseUrl appendString:[NSString stringWithFormat:@"%@&",uncodeStr]];
        }
    }
    item.defaultUrl = baseUrl;
    return item;
}

- (void)setDefaultUrl:(NSString *)defaultUrl {
    NSString *code = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)defaultUrl, NULL, NULL,  kCFStringEncodingUTF8 ));
    _defaultUrl = code;
    
}

@end
