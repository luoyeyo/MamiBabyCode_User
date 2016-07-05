//
//  MainPickerView.h
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/19.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WhiteDatePicker.h"

@protocol mainPickerDlegater <NSObject>
//赋值方法
- (void)dateString:(NSString *)str;

@end

@interface MainPickerView : UIView<whiteDatePickerDelegate>

@property (nonatomic, strong) WhiteDatePicker * whitePicker;
@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView * blackView;
@property (nonatomic, strong) UIView * pickerView;
@property (nonatomic, strong) UIButton * chooseBtn;
@property (nonatomic, strong) UIButton * deleteBtn;
/**
 *  允许选择今天以后的时间 默认为no
 */
@property (nonatomic, assign) BOOL allowSelectLater;

@property (nonatomic, assign) id<mainPickerDlegater> delegate;

- (void)showPickerView;

- (void)hidePickerView;

@end
