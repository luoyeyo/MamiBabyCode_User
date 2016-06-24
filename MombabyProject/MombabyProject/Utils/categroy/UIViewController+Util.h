//
//  UIViewController+Util.h
//  HouseMarket
//
//  Created by wangzhi on 15-2-5.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LLError;
@interface UIViewController (Util)

//读背景色
- (UIColor*)backGroundColor;

//设置背景色
- (void)setBackGroundColor:(UIColor *)backGroundColor;

//用图片做背景，背景图片大小最好与屏大小一致
- (void)setBackGroundImage:(UIImage *)backGroundImage;

//push vc
-(void)pushViewController:(UIViewController*)vc;

//pop vc
-(UIViewController*)popViewController;

-(UIViewController*)popViewControllerWithAnimate:(BOOL)animate;

//POP出最底层的VC
-(NSArray*)popToRootViewController;

//POP出指定的VC
-(NSArray*)popTo:(UIViewController*)popVc;

//当不需要左按钮时，调用它
- (void)clearNavBarLeftView;

//受限自定义导航栏左按钮（文本按钮）
-(void)setNavBarBackgroundColor:(UIColor*)color;

//自定义导航栏左视图
- (void)setNavBarLeftView:(UIView*)customLeftView;

- (void)setNavBarLeftButton:(NSString*)title clicked:(SEL)selector;

//受限自定义导航栏左按钮（图片按钮）
- (void)setNavBarLeftButton:(UIImage*)normalImage highlighted:(UIImage*)pressedImage clicked:(SEL)selector;

//自定义导航栏中间标题视图
- (void)setNavBarTitleView:(UIView*)customRightView;

//自定义导航栏右视图
- (void)setNavBarRightView:(UIView*)customRightView;

//受限自定义导航栏右按钮（文本按钮）
- (void)setNavBarRightButton:(NSString*)title clicked:(SEL)selector;

//受限自定义导航栏右按钮（文本按钮）带颜色
- (void)setNavBarRightButton:(NSString*)title titleColor:(UIColor *)color clicked:(SEL)selector;

//受限自定义导航栏右按钮（图片按钮）
- (UIButton*)setNavBarRightButton:(UIImage*)normalImage highlighted:(UIImage*)pressedImage clicked:(SEL)selector;

//受限自定义导航栏右按钮（图片按钮）
- (UIButton*)setNavBarRightButton:(UIImage*)normalImage highlighted:(UIImage*)pressedImage selected:(UIImage*)selectImage clicked:(SEL)selector;

- (void)setTitleColor:(UIColor*)color;

- (UIViewController *)getLastVC;

/**
 *  显示错误信息
 *
 *  @param error
 *  @param message 
 */
- (void)showErrorToastWithError:(LLError *)error message:(NSString *)message;

@end
