//
//  UIView+Util.h
//  HouseMarket
//
//  Created by wangzhi on 15-2-6.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, kFrameLocation)
{
    kFrameLocationLeft = 0,
    kFrameLocationRight,
    kFrameLocationTop,
    kFrameLocationBottom,
    kFrameLocationCenter
};

@interface UIView (Util)

- (CGFloat)bottom;

- (CGFloat)right;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

/**
 * @brief get views's width
 */
-(CGFloat)width;

/**
 * @brief get views's height
 */
-(CGFloat)height;

/**
 * @brief get views's size
 */
-(CGSize)size;

/**
 * @brief set views's width
 */
-(void)setWidth:(CGFloat)width;

/**
 * @brief set views's height
 */
-(void)setHeight:(CGFloat)height;

/**
 * @brief set views's size
 */
-(void)setSize:(CGSize)size;

/**
 * @brief Clear background color
 */
-(UIView*)clearBackgroundColor;

/**
 * @brief 圆角化视图
 * @note 将视图以圆形显示,没有边框,如果显示正圆形，则需先将宽高设为相等的值
 */
- (void)circleView;

/**
 * @brief 圆角化角边
 * @param radius 边角化值
 */
- (void)circleCornerWithRadius:(CGFloat)radius;

/**
 * @brief 圆角化视图
 * @param borderWidth: 边框宽度
 * @param color: 边框颜色
 * @note 将视图以圆形显示,如果显示正圆形，则需先将宽高设为相等的值
 */
- (void)circleView:(CGFloat)borderWidth color:(UIColor*)color;

/**
 * @brief 圆角化视图
 * @param corners : which corner
 * @param cornerRadii:
 * @note 
 */
-(UIView*)circleCorner:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/** 移除所有子视图
 *
 */
- (void)removeAllSubviews;

//height 为1
- (UIView*)addBottomLine:(UIColor*)color;

- (UIView *)addLineTo:(kFrameLocation)locate color:(UIColor *)color;

//addLine
- (void)addLineWithColor:(UIColor *)color frame:(CGRect)frame;
- (void)addDefaultLine;

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width;

- (void)addSingleTapEventWithTarget:(id)target action:(SEL)action;
@end
