//
//  CustomListView.m
//  listView
//
//  Created by 罗野 on 15/10/3.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "CustomMenuView.h"
#import "AppDelegate.h"
#define ListHeight 40

@interface CustomMenuView () {
    UIView *_btnBase;
}

@end

@implementation CustomMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        self.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.240];
    }
    return self;
}

- (void)setDataSource:(NSArray *)dataSource {
    if (_dataSource != dataSource) {
        _dataSource = dataSource;
    }
    [self initAppearance];
}

- (void)initAppearance {
    
    CGFloat width = 110;
    _btnBase = [[UIView alloc] init];
    _btnBase.clipsToBounds = YES;
    _btnBase.alpha = 0;
    [self addSubview:_btnBase];

    for (int i = 0 ; i < _dataSource.count ; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, ListHeight * i, width, ListHeight)];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:_dataSource[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor colorWithRed:0.102 green:0.102 blue:0.102 alpha:0.5];
        [button setBackgroundColor:[UIColor colorWithWhite:0.449 alpha:1.000] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i + 10;
        [_btnBase addSubview:button];
        if (i != _dataSource.count - 1) {
            [button addLineWithColor:kColorLineGray frame:CGRectMake(5, 39.5, width - 10, 1)];
        }
    }
}

- (void)showListView {
    CGFloat width = 110;
    UIWindow *windows = [UIApplication sharedApplication].keyWindow;
    [windows addSubview:self];
    CGRect frame = CGRectMake(self.bounds.size.width - width - 10, 64, width, self.dataSource.count * ListHeight);
    if (self.Position == kPositionCenter) {
        frame = CGRectMake(self.width / 2 - width / 2, 64, width, self.dataSource.count * ListHeight);
    } else if (self.Position == kPositionLeft) {
        frame = CGRectMake(10, 64, width, self.dataSource.count * ListHeight);
    }
    _btnBase.frame = frame;
    _btnBase.height = 0;
    [UIView animateWithDuration:0.4 animations:^{
        _btnBase.frame = frame;
        _btnBase.alpha = 1;
    } completion:^(BOOL finished) {
        [_btnBase circleCornerWithRadius:3];
    }];
}

- (void)buttonDidSelect:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(menuSelected:)]) {
        [self.delegate menuSelected:sender.tag - 10];
        [self removeFromSuperview];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.delegate menuSelected:10];
    [self removeFromSuperview];
}

@end
