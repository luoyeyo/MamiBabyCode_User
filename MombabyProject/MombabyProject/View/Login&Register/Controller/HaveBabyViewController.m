//
//  HaveBabyViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/21.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "HaveBabyViewController.h"
//#import "SelfViewController.h"
#import "MainPickerView.h"
#import "XMTextField.h"
#import "XMAccountTool.h"

@interface HaveBabyViewController () <UITextFieldDelegate, mainPickerDlegater>
{
    BabyInfoModel *_babyInfo;
    
    XMTextField *_nameField;
    XMTextField *_birthdayField;
    
    UIButton *_boyBtn;
    UIButton *_girlBtn;
    
    Input_params *_params;
    
}
@property (nonatomic, copy) NSString *babySex;
@property (nonatomic, copy) NSString *defaultDate;
@property (nonatomic, strong) MainPickerView *datePicker;


@end

@implementation HaveBabyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
//    [MobClick beginLogPageView:@"设置宝贝信息"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
//    [MobClick endLogPageView:@"设置宝贝信息"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置宝贝信息";
    self.view.backgroundColor = COLOR_C4;
    // 修改的时候
    if (self.navigationController.navigationBar.hidden == YES) {
        [self customNavgationBar];
        self.navTitle.text = @"设置宝贝信息";
    }
    _params = [Input_params new];
    [self createUI];
}

// 创建UI
- (void)createUI
{
    // 获得系统时间
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.defaultDate = [dateFormatter stringFromDate:[NSDate date]];
    
    // 默认宝贝是男孩
    self.babySex = @"1";
    
    // 宝贝名字提醒文字
    CGFloat babyNameX = 20;
    CGFloat babyNameY = 64 + 20;
    CGFloat babyNameW = ScreenWidth - babyNameX * 2;
    CGFloat babyNameH = 15;
    UILabel *babyName = [[UILabel alloc] initWithFrame:CGRectMake(babyNameX, babyNameY, babyNameW, babyNameH)];
    babyName.textColor = COLOR_C3;
    babyName.font = UIFONT_H4_15;
    babyName.text = @"宝宝昵称";
    babyName.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:babyName];
    
    
    //输入宝贝名字
    _nameField = [[XMTextField alloc] init];
    CGFloat nameFieldX = babyNameX;
    CGFloat nameFieldY = babyNameY + babyNameH + 20;
    CGFloat nameFieldW = babyNameW;
    CGFloat nameFieldH = 39;
    _nameField.frame = CGRectMake(nameFieldX, nameFieldY, nameFieldW, nameFieldH);
    _nameField.leftImageView.image = [UIImage imageNamed:@"babyIcon"];
    _nameField.delegate = self;
    _nameField.placeholder = @"请输入宝贝昵称";
    _nameField.tag = 10;
    _nameField.keyboardType = UIKeyboardTypeDefault;
    [self.view addSubview:_nameField];
    
    // 宝贝生日提醒文字
    CGFloat babyBirthdayX = 20;
    CGFloat babyBirthdayY = nameFieldY + nameFieldH + 20;
    CGFloat babyBirthdayW = ScreenWidth - babyNameX * 2;
    CGFloat babyBirthdayH = 15;
    UILabel *babyBirthday = [[UILabel alloc] initWithFrame:CGRectMake(babyBirthdayX, babyBirthdayY, babyBirthdayW, babyBirthdayH)];
    babyBirthday.textColor = COLOR_C3;
    babyBirthday.font = UIFONT_H4_15;
    babyBirthday.text = @"宝宝生日";
    babyBirthday.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:babyBirthday];
    
    
    // 输入宝贝生日
    _birthdayField = [[XMTextField alloc] init];
    
    CGFloat birthdayFieldX = babyNameX;
    CGFloat birthdayFieldY = babyBirthdayY + babyBirthdayH + 20;
    CGFloat birthdayFieldW = babyNameW;
    CGFloat birthdayFieldH = 39;
    _birthdayField.frame = CGRectMake(birthdayFieldX, birthdayFieldY, birthdayFieldW, birthdayFieldH);
    _birthdayField.leftImageView.image = [UIImage imageNamed:@"dateIcon"];
    _birthdayField.delegate = self;
    _birthdayField.placeholder = @"请输入宝贝生日";
    _birthdayField.tag = 11;
    [self.view addSubview:_birthdayField];
    
    
    // 选择性别提醒文字
    CGFloat babySexX = 20;
    CGFloat babySexY = birthdayFieldY + birthdayFieldH + 20;
    CGFloat babySexW = ScreenWidth - babyNameX * 2;
    CGFloat babySexH = 15;
    UILabel *babySex = [[UILabel alloc] initWithFrame:CGRectMake(babySexX, babySexY, babySexW, babySexH)];
    babySex.textColor = COLOR_C3;
    babySex.font = UIFONT_H4_15;
    babySex.text = @"宝宝性别";
    babySex.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:babySex];
    

    _boyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat boyBtnX = 20;
    CGFloat boyBtnY = babySexY + babySexH + 20;
    CGFloat boyBtnW = (ScreenWidth - 80) * 0.5;
    CGFloat boyBtnH = 39;
    _boyBtn.frame = CGRectMake(boyBtnX, boyBtnY, boyBtnW, boyBtnH);
    _boyBtn.layer.masksToBounds = YES;
    _boyBtn.layer.cornerRadius = 3;
    _boyBtn.titleLabel.font = UIFONT_H6_16;
    [_boyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_boyBtn setTitle:@"小王子" forState:UIControlStateNormal];
    [_boyBtn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [_boyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_boyBtn setBackgroundColor:[UIColor whiteColor]];
    [_boyBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_boyBtn setBackgroundImage:[UIImage imageNamed:@"boy"] forState:UIControlStateSelected];
    [_boyBtn addTarget:self action:@selector(boyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_boyBtn];
    
    
    _girlBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat girlBtnX = 20 + ((ScreenWidth - 80) * 0.5 + 40);
    CGFloat girlBtnY = babySexY + babySexH + 20;
    CGFloat girlBtnW = (ScreenWidth - 80) * 0.5;
    CGFloat girlBtnH = 39;
    _girlBtn.frame = CGRectMake(girlBtnX, girlBtnY, girlBtnW, girlBtnH);
    _girlBtn.layer.masksToBounds = YES;
    _girlBtn.layer.cornerRadius = 3;
    _girlBtn.titleLabel.font = UIFONT_H6_16;
    [_girlBtn setTitle:@"小公主" forState:UIControlStateNormal];
    [_girlBtn setTitleColor:kColorTheme forState:UIControlStateNormal];
    [_girlBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_girlBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_girlBtn setBackgroundImage:[UIImage imageNamed:@"girl"] forState:UIControlStateSelected];
    [_girlBtn setBackgroundColor:[UIColor whiteColor]];
    [_girlBtn addTarget:self action:@selector(girlBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_girlBtn];
    
    // 设置显示信息
    if (kUserInfo.isLogined) { // 注册用户
        
        _nameField.text = kUserInfo.currentBaby.nickname;
        if (kUserInfo.currentBaby.birth.integerValue == 0) {
            _birthdayField.text = self.defaultDate;
        }
        else
        {
            _birthdayField.text = [NSDate dateStringWithTimeInterval:[[NSString stringWithFormat:@"%@", kUserInfo.currentBaby.birth] doubleValue] formatterStr:@"yyyy-MM-dd"];
        }
        if (kUserInfo.currentBaby.gender && ![kUserInfo.currentBaby.gender isKindOfClass:[NSNull class]]) {  // 如果性别有值
            self.babySex = [NSString stringWithFormat:@"%@", kUserInfo.currentBaby.gender];
            if ([kUserInfo.currentBaby.gender integerValue] == 1) {
                _boyBtn.selected = YES;
                _girlBtn.selected = NO;
            }
            else
            {
                _boyBtn.selected = NO;
                _girlBtn.selected = YES;
            }
        }
        else  // 如果没有值 默认是男孩
        {
            self.babySex = @"1";
            _boyBtn.selected = YES;
            _girlBtn.selected = NO;
        }
        
    }
    else // 游客
    {
        _babyInfo = kUserInfo.currentBaby;
        _nameField.text = _babyInfo.nickname;
        _birthdayField.text = [NSDate dateStringWithTimeInterval:_babyInfo.birth.doubleValue formatterStr:@"yyyy-MM-dd"];
        if (_babyInfo.gender.integerValue == 0 || _babyInfo.gender == nil ||_babyInfo.gender.length == 0) {
            self.babySex = @"1";
            _boyBtn.selected = YES;
            _girlBtn.selected = NO;
        }
        else if (_babyInfo.gender.integerValue == 1) {
            self.babySex = _babyInfo.gender;
            _boyBtn.selected = YES;
            _girlBtn.selected = NO;
        }
        else
        {
            self.babySex = _babyInfo.gender;
            _boyBtn.selected = NO;
            _girlBtn.selected = YES;
        }
    }

    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat sureBtnX = babyNameX;
    CGFloat sureBtnY = boyBtnY + boyBtnH + 40;
    CGFloat sureBtnW = ScreenWidth - sureBtnX * 2;
    CGFloat sureBtnH = 39;
    sureBtn.frame = CGRectMake(sureBtnX, sureBtnY, sureBtnW, sureBtnH);
    sureBtn.layer.masksToBounds = YES;
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = kColorTheme;
    [sureBtn setTitle:@"确定"  forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureBtn];
    
    
    // 实例化实现选择器
    self.datePicker = [[MainPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.datePicker.delegate = self;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 10) {
        return YES;
    }
    else
    {
        [_nameField resignFirstResponder];
        [_datePicker showPickerView];
    }
    
    return NO;
}

#pragma mark - mainPickerDlegater
- (void)dateString:(NSString *)str
{
    NSString *dateStr = [str getTimestamp];
    NSString *defaultDateStr = [self.defaultDate getTimestamp];
    if (str.length == 0) {
        _birthdayField.text = self.defaultDate;
    }
    else if (dateStr.integerValue > defaultDateStr.integerValue)
    {
        [self.view showToastMessage:@"您选择的时间有误"];
        _birthdayField.text = self.defaultDate;
    }
    else
    {
        _birthdayField.text = str;
    }
    
}

- (void)boyBtnClick
{
    self.babySex = @"1";
    _boyBtn.selected = YES;
    _girlBtn.selected = NO;
    _boyBtn.userInteractionEnabled = NO;
    _girlBtn.userInteractionEnabled = YES;
    
}
    
- (void)girlBtnClick
{
    self.babySex = @"2";
    _boyBtn.userInteractionEnabled = YES;
    _girlBtn.userInteractionEnabled = NO;
    _boyBtn.selected = NO;
    _girlBtn.selected = YES;
}

#pragma mark - 确定按钮点击事件
- (void)sureBtnAction
{
    // 0、删除孕期信息
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *documentsFile = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *dataFilePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/date.data"];
    
    if ([manager fileExistsAtPath:documentsFile]) {
        [manager removeItemAtPath:dataFilePath error:nil];
    }
    
    if (_birthdayField.text.length == 0) {
        [self.view showToastMessage:@"宝宝生日不能为空"];
        
    }
    else
    {
        // 2、上传信息
        if (kUserInfo.isLogined) {
            
            [self putUserInfo];
        }
        else
        {
            [self jumpToMainTabBarVC];
        }
        
    }
}

// 上传宝贝信息
- (void)putUserInfo {
    NSString *netBabyBirth = [NSString stringWithFormat:@"%@", kUserInfo.currentBaby.birth];
    NSString *chooseBabyBirth = [_birthdayField.text getTimestamp];
    
    _params.token = kUserInfo.token;
    _params.babyNickname = _nameField.text;
    _params.babyGender = self.babySex;
    _params.status = @(kUserStateChild);
    if (![chooseBabyBirth isEqualToString:netBabyBirth]) {
        _params.babyBirth = chooseBabyBirth;
    }
    [self.view showPopupLoading];
    [[Network_Login new] putUserInfoWith:_params responseBlock:^(LLError *error) {
        [self.view hidePopupLoading];
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            
            [self jumpToMainTabBarVC];
        }
    }];
}
// 上传用户信息成功以后做的事情
- (void)jumpToMainTabBarVC {
    // 1、存储baby信息
    [self saveBabyInfo];
    [kAppDelegate toMain];
}

- (void)saveBabyInfo {
    kUserInfo.status = kUserStateChild;
    kUserInfo.dueDateStr = nil;
    NSTimeInterval birth = [NSDate getDateEntryWithDateString:_birthdayField.text].timeIntervalSince1970;
    kUserInfo.currentBaby.birth = [NSString stringWithFormat:@"%@",@(birth)];
    kUserInfo.currentBaby.nickname = _nameField.text;
    kUserInfo.currentBaby.gender = self.babySex;
    [kUserInfo synchronize];
}


#pragma mark - 键盘回收

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [_nameField resignFirstResponder];
    [_birthdayField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
