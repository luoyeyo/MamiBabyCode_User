//
//  VerifyPhoneCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/26.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "VerifyPhoneCell.h"

@interface VerifyPhoneCell () {
    NSTimer *_timer;
    NSInteger _timeOut;
}

@end

@implementation VerifyPhoneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.verifyBtn.layer.borderColor = kColorLineGray.CGColor;
    self.verifyBtn.layer.borderWidth = .5f;
    [self.phoneTF addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    self.phoneTF.MAXLenght = 13;
}

- (void)textChange {
    ReturnIf(_timer);
    if ([self.phoneTF.text isValidPhoneNumber]) {
        self.verifyBtn.backgroundColor = kColorWhite;
        [self.verifyBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
        self.verifyBtn.layer.borderColor = kColorTheme.CGColor;
    } else {
        self.verifyBtn.layer.borderColor = kColorLineGray.CGColor;
        self.verifyBtn.backgroundColor = kColorClear;
        [self.verifyBtn setTitleColor:[UIColor colorFromHexRGB:@"BABABA"] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (self.verifyBtn.userInteractionEnabled == YES && selected) {
        [self sendVerify:self.verifyBtn];
    }
}

- (IBAction)sendVerify:(UIButton *)sender {
    // 如果手机号不合法 不发送
    NSString *promet = nil;
    promet = [self checkIsValidUserName:self.phoneTF.text];
    
    if (promet) {
        [kAppDelegate.window showToastMessage:promet];
        return;
    }
    if (self.needVerify == YES && ![self.phoneTF.text isEqualToString:kUserInfo.phone]) {
        [kAppDelegate.window showToastMessage:@"请输入当前登录手机号"];
        return;
    }
    [self getVerifyCode];
    if (self.sendVerifyBlock) {
        self.sendVerifyBlock(self.phoneTF.text);
    }
}

/**
 *  获取验证码
 */
- (void)getVerifyCode {
    [self beginTimer];
    Input_params *params = [[Input_params alloc] init];
    params.phone = self.phoneTF.text;
    [[[Network_Login alloc] init] getVerifyCodeWith:params responseBlock:^(LLError *error) {
        if (error) {
            [kAppDelegate.window showToastMessage:@"验证码发送失败"];
            [self stopTimer];
        }
    }];
}

/**
 *  开始计时
 */
- (void)beginTimer {
    if (!_timer) {
        self.verifyBtn.backgroundColor = kColorLineGray;
        _timeOut = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showTimeOutText) userInfo:nil repeats:YES];
        self.verifyBtn.userInteractionEnabled = NO;
    }
    [_timer fire];
}

/**
 *  停止计时
 */
- (void)stopTimer {
    _timeOut = 60;
    [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _verifyBtn.userInteractionEnabled = YES;
    [_timer invalidate];
    _timer = nil;
    _verifyBtn.backgroundColor = kColorWhite;
}

/**
 *  超时数字
 */
- (void)showTimeOutText {
    _timeOut --;
    NSString *timeStr = [NSString intStr:_timeOut];
    [_verifyBtn setTitle:timeStr forState:UIControlStateNormal];
    if (_timeOut == 0) {
        [self stopTimer];
    }
}

/**
 *  判断账户
 *
 *  @param username
 *
 *  @return
 */
- (NSString *)checkIsValidUserName:(NSString *)username {
    
    if (![username isValidPhoneNumber]) {
        return @"请输入正确的手机号码";
    }
    return nil;
}
@end
