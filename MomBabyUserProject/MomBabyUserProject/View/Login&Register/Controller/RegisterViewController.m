//
//  RegisterViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/30.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "RegisterViewController.h"
#import "GetVerifyButton.h"

@interface RegisterViewController ()
@property (strong, nonatomic) IBOutlet InputLimitField *phoneTF;
@property (strong, nonatomic) IBOutlet InputLimitField *verifyTF;
@property (strong, nonatomic) IBOutlet GetVerifyButton *verifyBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
- (IBAction)getVerifyCode:(UIButton *)sender;
- (IBAction)registerAndLogin:(UIButton *)sender;
- (IBAction)backLast:(UIButton *)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_phoneTF setValue:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    [_verifyTF setValue:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    _verifyTF.tintColor = kColorTint;
    _phoneTF.tintColor = kColorTint;
    self.phoneTF.MAXLenght = 13;
    self.verifyTF.MAXLenght = 8;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(20, (ScreenWidth - 70) / 2, 20, (ScreenWidth - 70) / 2);
    UIImage *image = ImageNamed(@"page1_btn");
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
}

- (IBAction)getVerifyCode:(UIButton *)sender {
    if (![self.phoneTF.text isValidPhoneNumber]) {
        [self.view showToastMessage:@"请输入正确的手机号码"];
        return;
    }
    [self getVerifyCode];
}

- (IBAction)registerAndLogin:(UIButton *)sender {
    if (![self.phoneTF.text isValidPhoneNumber]) {
        [self.view showToastMessage:@"请输入正确的手机号码"];
        return;
    } else if (self.verifyTF.text.length == 0) {
        [self.view showToastMessage:@"请输入验证码"];
        return;
    }
    [self.view endEditing:YES];
    [self userLogin];
}

- (IBAction)backLast:(UIButton *)sender {
    [self popViewController];
}

/**
 *  获取验证码
 */
- (void)getVerifyCode {
    [self.verifyBtn beginTimer];
    Input_params *params = [[Input_params alloc] init];
    params.phone = self.phoneTF.text;
    [[[Network_Login alloc] init] getVerifyCodeWith:params responseBlock:^(LLError *error) {
        if (error) {
            [self.view showToastMessage:@"验证码发送失败"];
            [self.verifyBtn stopTimer];
        }
    }];
}

/**
 *  登陆
 */
- (void)userLogin {
    [self.view showPopupLoading];
    Input_params *params = [[Input_params alloc] init];
    params.phone = self.phoneTF.text;
    params.code = self.verifyTF.text;
    [[[Network_Login alloc] init] loginWithParams:params responseBlock:^(LLError *error,NSString *token) {
        if (!error) {
            [self getUserInfoWithToken:token];
        } else {
            [self.view showToastMessage:error.errormsg];
            [self.view hidePopupLoading];
        }
    }];
}

/**
 *  获取用户信息
 */
- (void)getUserInfoWithToken:(NSString *)token {
    [[[Network_Login alloc] init] getUserInfoWithToken:token responseBlock:^(LLError *error) {
        [self.view hidePopupLoading];
        if (!error) {
            [self.view showPopupOKMessage:@"注册成功，立即登录"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [kAppDelegate toMain];
            });
        } else {
            [self.view showToastMessage:error.errormsg];
            [self popViewController];
        }
    }];
}
@end
