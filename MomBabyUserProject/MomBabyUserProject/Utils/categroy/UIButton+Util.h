//
//  UIButton+Util.h
//  HouseMarket
//
//  Created by wangzhi on 15-2-5.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Util)

//Image Button
+ (instancetype)imageButtonWithNorImg:(NSString*)norImgName selImg:(NSString*)selImgName;

//Image Button
+ (instancetype)imageButtonWithNorImg:(NSString*)norImgName selImg:(NSString*)selImgName size:(CGSize)size target:(id)target action:(SEL)action;
//设置标题
- (void)setTitleForAllStatus:(NSString*)title;

//设置图标
- (void)setBgImageForAllStatus:(NSString*)imageName;

//带下划线、深灰文本按钮
+ (UIButton*)buttonWithUnderlineText:(NSString*)title;

//添加三角图标到右下角
- (UIButton*)addBottomRightTriangleIcon;

//左文本右图片
- (UIButton *)layoutLeftTextRightImageButton;

//上图下文本
- (UIButton *)layoutTopImageBottomTextButton;

//带边框文本
+ (UIButton*)borderTextButton:(NSString*)text color:(UIColor*)color;

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

+ (UIButton *)createNavBackBtn:(NSString *)image;
@end
