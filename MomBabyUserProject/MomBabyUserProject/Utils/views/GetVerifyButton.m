//
//  GetVerifyButton.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/30.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "GetVerifyButton.h"

@interface GetVerifyButton (){
    NSTimer *_timer;
    NSInteger _timeOut;
    UIColor *_defaultColor;
}

@end

@implementation GetVerifyButton

- (UIColor *)highlightColor {
    if (!_highlightColor) {
        _highlightColor = [UIColor clearColor];
    }
    return _highlightColor;
}

/**
 *  开始计时
 */
- (void)beginTimer {
    if (!_timer) {
        _defaultColor = self.backgroundColor;
        self.backgroundColor = self.highlightColor;
        _timeOut = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimeOutText) userInfo:nil repeats:YES];
        self.userInteractionEnabled = NO;
    }
    [_timer fire];
}

/**
 *  停止计时
 */
- (void)stopTimer {
    _timeOut = 60;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
    [_timer invalidate];
    _timer = nil;
    self.backgroundColor = _defaultColor;
}

/**
 *  超时数字
 */
- (void)showTimeOutText {
    _timeOut --;
    NSString *timeStr = [NSString intStr:_timeOut];
    [self setTitle:timeStr forState:UIControlStateNormal];
    if (_timeOut == 0) {
        [self stopTimer];
    }
}

@end
