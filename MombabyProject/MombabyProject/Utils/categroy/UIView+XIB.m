//
//  UIView+XIB.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/22.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "UIView+XIB.h"

@implementation UIView (XIB)

+ (instancetype )defaultClassNameNibViewWithFrame:(CGRect)frame
{
    NSString *className = NSStringFromClass([self class]);
    NSArray *views = [[UINib nibWithNibName:className bundle:nil] instantiateWithOwner:nil options:nil];
    
    for (UIView *custom in views) {
        if ([custom isMemberOfClass:[self class]]) {
            custom.frame = frame;
            return custom;
        }
    }
    NSAssert(NO, @"Expect file: %@", [NSString stringWithFormat:@"%@.xib", NSStringFromClass([self class])]);
    return nil;
}

+ (instancetype )defaultClassNameNibView
{
    NSString *className = NSStringFromClass([self class]);
    NSArray *views = [[UINib nibWithNibName:className bundle:nil] instantiateWithOwner:nil options:nil];
    
    for (UIView *custom in views) {
        if ([custom isMemberOfClass:[self class]]) {
            return custom;
        }
    }
    NSAssert(NO, @"Expect file: %@", [NSString stringWithFormat:@"%@.xib", NSStringFromClass([self class])]);
    return nil;
}


@end
