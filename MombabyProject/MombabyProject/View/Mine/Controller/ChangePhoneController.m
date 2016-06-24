//
//  ChangePhoneController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/26.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "ChangePhoneController.h"
#import "InputCell.h"
#import "VerifyPhoneCell.h"

@interface ChangePhoneController ()<UITableViewDelegate,UITableViewDataSource> {
    NSString *_phone;
    NSString *_code;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIButton *modifyBtn;
- (void)confirmChanges:(UIButton *)sender;

@end

@implementation ChangePhoneController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换绑定手机";
    [self.tableView addSubview:self.modifyBtn];
    [self customNavgationBar];
    self.navTitle.text = @"更换绑定手机";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isNewPhone == YES) {
        self.title = @"绑定新手机号";
        [self.modifyBtn setTitle:@"绑定" forState:UIControlStateNormal];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        VerifyPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VerifyPhoneCell"];
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        if (_isNewPhone) {
            cell.phoneTF.placeholder = @"请输入新的手机号";
        }
        cell.needVerify = !_isNewPhone;
        return cell;
    } else {
        InputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InputCell"];
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)confirmChanges:(UIButton *)sender {
    ReturnIf(![self checkInfoIsComplete]);
    // 如果不是绑定新手机页面 就是验证之前手机的页面
    if (_isNewPhone == NO) {
        [self verifyPhone];
    } else {
        [self modifyPhone];
    }
}

/**
 *  验证之前的手机
 */
- (void)verifyPhone {
    [self.view showPopupLoading];
    Input_params *params = [[Input_params alloc] init];
    params.phone = _phone;
    params.code = _code;
    [[[Network_Mine alloc] init] verifyBindingPhoneWith:params responseBlock:^(LLError *error) {
        [self.view hidePopupLoading];
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            [self.view showToastMessage:@"验证成功"];
            [self BindingANewPhone];
        }
    }];
}

/**
 *  修改手机号
 */
- (void)modifyPhone {
    
    [self.view showPopupLoading];
    Input_params *params = [[Input_params alloc] init];
    params.phone = _phone;
    params.code = _code;
    [[[Network_Mine alloc] init] modifyBindingPhoneWith:params responseBlock:^(LLError *error) {
        [self.view hidePopupLoading];
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            [self.view showToastMessage:@"新手机绑定成功，请重新登录哦"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [kUserInfo exitUser];
                [kAppDelegate toLogin];
            });
        }
    }];
}

/**
 *  绑定新手机
 */
- (void)BindingANewPhone {
    ChangePhoneController *change = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePhoneController"];
    [self pushViewController:change];
    change.isNewPhone = YES;
}

- (BOOL)checkInfoIsComplete {
    
    VerifyPhoneCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    InputCell *verifyCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    _phone = cell.phoneTF.text;
    _code = verifyCell.inputTF.text;
    if (![_phone isValidPhoneNumber]) {
        
        [self.view showToastMessage:@"请输入正确的手机号"];
        return NO;
    }
    if (_code.length == 0) {
        
        [self.view showToastMessage:@"请输验证码"];
        return NO;
    }
    return YES;
}

- (UIButton *)modifyBtn {
    if (!_modifyBtn) {
        _modifyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _modifyBtn.frame = CGRectMake(0, 0, 148, 45);
        _modifyBtn.backgroundColor = kColorTheme;
        [_modifyBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_modifyBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        _modifyBtn.titleLabel.font = SystemBoldFont(18);
        _modifyBtn.layer.cornerRadius = 22.5;
        _modifyBtn.center = CGPointMake(ScreenWidth / 2, ScreenHeight - 90 - 64);
        [_modifyBtn addTarget:self action:@selector(confirmChanges:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modifyBtn;
}

- (BOOL)isNewPhone {
    if (!_isNewPhone) {
        _isNewPhone = NO;
    }
    return _isNewPhone;
}

@end
