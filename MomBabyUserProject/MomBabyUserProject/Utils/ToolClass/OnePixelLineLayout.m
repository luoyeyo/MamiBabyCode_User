//
//  CustomLayout.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/30.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "OnePixelLineLayout.h"

@implementation OnePixelLineLayout

- (void)setOnePixelConstant:(NSInteger)onePixelConstant
{
    _onePixelConstant = onePixelConstant;
    self.constant = onePixelConstant * 1.0 / [UIScreen mainScreen].scale;
}

@end
