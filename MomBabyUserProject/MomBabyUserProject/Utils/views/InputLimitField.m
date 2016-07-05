//
//  InputLimitField.m
//  imageTest
//
//  Created by 罗野 on 15/11/9.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "InputLimitField.h"

@implementation InputLimitField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.MAXLenght = 200;
        [self addTarget:self action:@selector(textFieldContentDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.MAXLenght = 200;
        [self addTarget:self action:@selector(textFieldContentDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)textFieldContentDidChange  {
    if (self.cancelLimit) {
        return;
    }
    if (self.text.length > 0) {
        // 第一位不能输入0
//        NSString *single = [self.text substringToIndex:1];//当前输入的字符
//        if([self.text length] == 1) {
//            if([single  isEqual: @"0"]){
//                self.text = @"";
//            }
//        }
        if (self.text.length > self.MAXLenght) {
            self.text = [self.text substringToIndex:self.MAXLenght];
        }
    }
}

- (void)setText:(NSString *)text {
    if (![text isEqualToString:@"0"]) {
        [super setText:text];
    }
}

@end
