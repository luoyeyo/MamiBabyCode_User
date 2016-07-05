//
//  UIView+Util.m
//  HouseMarket
//
//  Created by wangzhi on 15-2-6.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import "UIView+Util.h"
#import <Masonry/Masonry.h>

#define kaddDefaultSepraterBottomLineTag    0x5793680
#define kTopErrorLabelViewTag               0x5793681

#define kMiddleTextPlaceHolderViewTag       0x5793682
#define kMiddleImagePlaceHolderViewTag      0x5793683
#define kPlaceHolderViewTag 0x5793687

#define kMiddleImageTextPlaceHolderViewTag  0x5793684
#define kMiddleImageTextPlaceHolderViewImageTag     0x5793685
#define kMiddleImageTextPlaceHolderViewTextTag      0x5793686

@implementation UIView (Util)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)bottom {
    return self.y + self.height;
}

- (CGFloat)right {
    return self.x + self.width;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;

    if (width != frame.size.width) {
        frame.size.width = width;
        self.frame = frame;
    }
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;

    if (height != frame.size.height) {
        frame.size.height = height;
        self.frame = frame;
    }
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;

    if (size.width != frame.size.width
        || size.height != frame.size.height) {
        frame.size = size;
        self.frame = frame;
    }
}
/**
 *  透明色背景
 *
 *  @return
 */
-(UIView*)clearBackgroundColor
{
    self.backgroundColor = [UIColor clearColor];

    return self;
}
/**
 *  圆形视图(一半圆角)
 */
- (void)circleView
{
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.frame.size.width / 2;
}
/**
 *  设置圆角
 *
 *  @param radius
 */
- (void)circleCornerWithRadius:(CGFloat)radius
{
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = radius;
}
/**
 *  图层框
 *
 *  @param borderWidth
 *  @param color
 */
- (void)circleView:(CGFloat)borderWidth color:(UIColor*)color
{
    [self circleView];
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
}

- (UIView*)circleCorner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    maskLayer.strokeColor = [UIColor clearColor].CGColor;
    maskLayer.masksToBounds = YES;
    self.layer.mask = maskLayer;

    return self;
}

- (void)removeAllSubviews
{
    for (UIView *subView in self.subviews)
    {
        [subView removeFromSuperview];
    }
}

- (UIView *)addLineTo:(kFrameLocation)locate color:(UIColor *)color
{
    UIView *line = [[UIView alloc]init];
    if (color) {
        line.backgroundColor = color;
    } else {
        line.backgroundColor = kColorLineGray;
    }
    line.alpha = 1;
    [self addSubview:line];
    [self bringSubviewToFront:line];
    
    CGFloat fineness = 0.5;
    
    switch (locate) {
        case kFrameLocationTop:
        case kFrameLocationBottom:
        {
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                if (kFrameLocationBottom == locate) {
                    make.bottom.equalTo(self).offset(0);
                }else {
                    make.top.equalTo(self);
                }
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.equalTo(@(fineness));
            }];
        }
            break;
        case kFrameLocationLeft:
        case kFrameLocationRight:
        {
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                if (kFrameLocationLeft == locate) {
                    make.left.equalTo(self);
                }else {
                    make.right.equalTo(self);
                }
                make.top.equalTo(self);
                make.bottom.equalTo(self);
                make.width.equalTo(@(fineness));
            }];
        }
            break;
        default:
            break;
    }
    return line;
}


- (UIView *)addBottomLine:(UIColor*)color
{
    UIView *line = [self viewWithTag:kaddDefaultSepraterBottomLineTag];
    if (nil == line) {
        CGFloat lineHeight = 0.5;

        CGRect frame =  CGRectMake(0, self.height - lineHeight, self.width, lineHeight);
        UIView *line = [[UIView alloc]initWithFrame:frame];
        line.backgroundColor = color;
        line.alpha = 1;
        line.tag = kaddDefaultSepraterBottomLineTag;
        line.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        [self addSubview:line];
    }
    [self bringSubviewToFront:line];

    return line;
}
/**
 *  绘制线段
 *
 *  @param color
 *  @param frame
 */
- (void)addLineWithColor:(UIColor *)color frame:(CGRect)frame
{
    UIView *line = [[UIView alloc]initWithFrame:frame];
    line.backgroundColor = color;
    [self addSubview:line];
}

- (void)addDefaultLine {
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 1, ScreenWidth, 0.5)];
    line.backgroundColor = kColorLineGray;
    [self addSubview:line];
}

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width {
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.cornerRadius = 5;
}

- (void)addSingleTapEventWithTarget:(id)target action:(SEL)action
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:gesture];
}

@end
