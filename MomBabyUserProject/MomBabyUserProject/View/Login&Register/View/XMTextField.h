//
//  XMTextField.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMTextField : UITextField <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;




+ (instancetype)dataField;

//- (void)createTextFieldWithLeftTitle:(NSString *)leftTitle date:(NSString *)date insideText:(NSString *)text;

@end
