//
//  InputLimitField.h
//  imageTest
//
//  Created by 罗野 on 15/11/9.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  输入限制 （首位不能为0、不能直接赋值0）
 */
@interface InputLimitField : UITextField <UITextFieldDelegate>
@property (nonatomic, assign) NSInteger MAXLenght;
@property (nonatomic, assign) BOOL cancelLimit;
@end
