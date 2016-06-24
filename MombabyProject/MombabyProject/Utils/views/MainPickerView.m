//
//  MainPickerView.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/19.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "MainPickerView.h"


@implementation MainPickerView {
    NSString * _dateStr;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createBottomView];
        self.allowSelectLater = NO;
    }
    return self;
}

- (void)createBottomView {
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:self.bottomView];
    
    self.blackView = [[UIView alloc] initWithFrame:self.bounds];
    self.blackView.backgroundColor = [[UIColor colorFromHexRGB:@"333333"] colorWithAlphaComponent:0.4];
    UITapGestureRecognizer * tapBlack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePickerView)];
    [self.blackView addGestureRecognizer:tapBlack];
    [self.bottomView addSubview:self.blackView];
    
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString * defaultDate = [dateFormatter stringFromDate:[NSDate date]];
    
    self.pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottomView.height + 240, self.width, 240)];
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:self.pickerView];
    
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 35)];
    topView.backgroundColor = [UIColor colorFromHexRGB:@"f5f5f5"];
    [self.pickerView addSubview:topView];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.deleteBtn.frame = CGRectMake(10, 5, 60, 25);
    [self.deleteBtn addTarget:self action:@selector(hidePickerView) forControlEvents:UIControlEventTouchUpInside];
    self.deleteBtn.layer.cornerRadius = 4;
    [topView addSubview:self.deleteBtn];
    
    self.chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.chooseBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.chooseBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    self.chooseBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.chooseBtn.layer.cornerRadius = 4;
    self.chooseBtn.tag = 999;
    self.chooseBtn.frame = CGRectMake(self.width - 70, 5, 60, 25);
    [self.chooseBtn addTarget:self action:@selector(chooseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:self.chooseBtn];
    
    self.whitePicker = [[WhiteDatePicker alloc]initWithFrame:CGRectMake(0, 35, self.width, 200) pickModel:ModelDate];
    self.whitePicker.defauleDateStr = defaultDate;
    self.whitePicker.dateDelegate = self;
    [self.pickerView addSubview:self.whitePicker];
    
    _dateStr = [NSDate getCurrentDateString];
}

- (void)showPickerView {
    
    [kAppDelegate.window addSubview:self];
    self.blackView.alpha = 0;
    self.whitePicker.allowSelectLater = self.allowSelectLater;
    [UIView animateWithDuration:0.5f animations:^{
        self.pickerView.frame = CGRectMake(0, self.bottomView.height - 240, self.width, 240);
        self.blackView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hidePickerView {
    
    [UIView animateWithDuration:0.5f animations:^{
        self.pickerView.frame = CGRectMake(0, self.bottomView.height + 240, self.width, 240);
        self.blackView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished == YES) {
            [self removeFromSuperview];
        }
    }];
}

- (void)chooseBtnAction{
    [self.delegate dateString:_dateStr];
    [self hidePickerView];
}


- (void)reloadSelectDateStr:(NSString *)selectStr Date:(NSDate *)selectDate{
    _dateStr = selectStr;
}


@end
