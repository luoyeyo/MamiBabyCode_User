//
//  LoginViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/29.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "LoginViewController.h"
#import "GetVerifyButton.h"
#import "JPUSHService.h"

@interface LoginViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate> {
    BOOL _hideKeyboard;
}

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet InputLimitField *phoneTF;
@property (strong, nonatomic) IBOutlet InputLimitField *verifyTF;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet GetVerifyButton *verifyBtn;
/**
 *  返回到选择页面
 *
 *  @param sender
 */
- (IBAction)backToChoose:(UIButton *)sender;

- (IBAction)getVerifyCode:(id)sender;

- (IBAction)toLogin:(UIButton *)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_phoneTF setValue:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    _phoneTF.MAXLenght = 13;
    _verifyTF.MAXLenght = 8;
    [_verifyTF setValue:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.3] forKeyPath:@"_placeholderLabel.textColor"];
    _verifyTF.tintColor = kColorTint;
    _phoneTF.tintColor = kColorTint;
    self.navigationController.navigationBar.hidden = YES;
    _phoneTF.text = @"18782905385";
    UIEdgeInsets insets = UIEdgeInsetsMake(20, (ScreenWidth - 70) / 2, 20, (ScreenWidth - 70) / 2);
    UIImage *image = ImageNamed(@"page1_btn");
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeTile];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
    
    _hideKeyboard = NO;
    [self.verifyTF addTarget:self action:@selector(beginEdit) forControlEvents:UIControlEventEditingDidBegin];
//    UIPanGestureRecognizer *gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapScrollView:)];
//    gesture.delegate = self;
//    [self.scrollView addGestureRecognizer:gesture];
}

- (IBAction)backToChoose:(UIButton *)sender {
    if ([kAppDelegate.window.rootViewController isEqual:self.navigationController]) {
        [kAppDelegate toChooseUserState];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)getVerifyCode:(id)sender {
    if (![self.phoneTF.text isValidPhoneNumber]) {
        [self.view showToastMessage:@"请输入正确的手机号码"];
        return;
    }
    [self getVerifyCode];
}

- (IBAction)toLogin:(UIButton *)sender {
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

/**
 *  获取验证码
 */
- (void)getVerifyCode {
    
    [self.verifyBtn beginTimer];
    Input_params *params = [[Input_params alloc] init];
    params.phone = self.phoneTF.text;
    [[[Network_Login alloc] init] getVerifyCodeWith:params responseBlock:^(LLError *error) {
        if (error) {
            [self.view showToastMessage:error.errormsg];
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
//    params.password = self.verifyTF.text;
    [[[Network_Login alloc] init] loginWithParams:params responseBlock:^(LLError *error) {
        if (!error) {
            [self getUserInfo];
        } else {
            [self.view showToastMessage:error.errormsg];
            [self.view hidePopupLoading];
        }
    }];
}

/**
 *  获取用户信息
 */
- (void)getUserInfo {
    [[[Network_Login alloc] init] getUserInfoWithToken:kUserInfo.token responseBlock:^(LLError *error) {
        [self.view hidePopupLoading];
        if (!error) {
            [self.view showPopupOKMessage:@"登录成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self loginSuccess];
            });
        } else {
            // 防止登陆时获取到token
            [kUserInfo exitUser];
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (_hideKeyboard == YES) {
        [self.view endEditing:YES];
    }
}

- (void)loginSuccess {
    
    if ([kAppDelegate.window.rootViewController isEqual:kAppDelegate.homeTab]) {
        [self dismissViewControllerAnimated:YES completion:^{
            [self changeRoot];
        }];
    } else {
        [self changeRoot];
    }
    
    
    // 创建用户数据库
//    [DataManager createDefaultTable];
//    NSString *userId = [NSString stringWithFormat:@"yimiaoer%@",kUserInfo.phone];
//    [JPUSHService setTags:nil alias:userId callbackSelector:nil object:nil];
}

- (void)changeRoot {
    if (kUserInfo.userType == kUserTypeVIP) {
        [kAppDelegate toMain];
    } else {
        if (kUserInfo.status == kUserStateNo) {
            [kAppDelegate toChooseUserState];
        } else {
            [kAppDelegate toMain];
        }
    }
}

- (void)beginEdit {
    _hideKeyboard = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _hideKeyboard = YES;
    });
}

@end
