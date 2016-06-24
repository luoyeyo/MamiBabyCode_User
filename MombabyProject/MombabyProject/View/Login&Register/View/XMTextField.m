//
//  XMTextField.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "XMTextField.h"

@implementation XMTextField 

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.borderStyle = UITextBorderStyleRoundedRect;
        
        // 设置内容 -- 垂直居中
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        // 设置左边显示的图片
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.width = 30;
        _leftImageView.height = 30;
        // 设置leftView的内容居中
        _leftImageView.contentMode = UIViewContentModeRight;
        self.leftView = _leftImageView;
        // 设置左边的view永远显示
        self.leftViewMode = UITextFieldViewModeAlways;
        
//        self.clearButtonMode = UITextFieldViewModeUnlessEditing;
        
        // 设置右边显示的图片
//        _rightImageView = [[UIImageView alloc] init];
//        _rightImageView.image = [UIImage imageNamed:@"pushImage"];
//        _rightImageView.width = (_rightImageView.image.size.width) + 15;
//        _rightImageView.height = (_rightImageView.image.size.height);
//        // 设置leftView的内容居中
//        _rightImageView.contentMode = UIViewContentModeCenter;
//        self.rightView = _rightImageView;
////         设置右边的view永远显示
//        self.rightViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

+ (instancetype)dataField
{
    return [[self alloc] init];
}
@end

