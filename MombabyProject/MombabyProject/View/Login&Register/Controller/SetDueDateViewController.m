//
//  SetDueDateViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/20.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "SetDueDateViewController.h"
#import "XMTextField.h"
#import "XMAccountTool.h"
#import "NSDate+myDate.h"
#import "MainPickerView.h"

@interface SetDueDateViewController () <UITextFieldDelegate, UIAlertViewDelegate, mainPickerDlegater>
{
    // 数据源
    NSArray *_array1;
    NSArray *_array2;
    
    UIView *_scorllLine;
    
    // 页面一
    UIView  *_backView;
    UILabel *_title;
    UILabel *_alertTitle;
    XMTextField *_dateField;
    
    // 时间选择器
//    UIDatePicker *_datePicker;
    NSString *_dateString;      // 用户设置的时间
    NSInteger _lastMens;        // 末次月经时间戳
    NSString *_lastMensStrDue;  // 末次月经推算的孕期
    
}

@property (nonatomic, strong) NSString *lastMensStr;  // 末次月经时间
@property (nonatomic, strong) NSString *dueStr;       // 孕产期时间

@property (nonatomic, strong) MainPickerView *datePicker;

@end



@implementation SetDueDateViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
//    [MobClick beginLogPageView:@"设置预产期"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = NO;
//    [MobClick endLogPageView:@"设置预产期"];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置预产期";
    // 修改的时候
    if (self.navigationController.navigationBar.hidden == YES) {
        [self customNavgationBar];
        self.navTitle.text = @"设置预产期";
    }
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = COLOR_C4;
    
    
    NSArray * buttonTitle = @[@"输入预产期", @"计算预产期"];
    
    for (int i = 0; i < 2; i ++) {
        
        // 标签选择按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat buttonX = (ScreenWidth * 0.5) * i;
        CGFloat buttonY = 64;
        CGFloat buttonW = ScreenWidth * 0.5;
        CGFloat buttonH = 39;
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = UIFONT_H6_16;
        button.tag = 10 + i;
        [button setBackgroundColor:[UIColor whiteColor]];
        [button setTitle:buttonTitle[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:kColorTheme forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        if (i == 0) {
            button.selected = YES;
        }
    }
    
    UIView *Xline = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth * 0.5, 75, 1, 20)];
    Xline.backgroundColor = kColorTheme;
    [self.view addSubview:Xline];
    
    // 分界线
    _scorllLine = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth / 8, 64 + 37, ScreenWidth / 4, 2)];
    _scorllLine.backgroundColor = kColorTheme;
    [self.view addSubview:_scorllLine];
    
    // 背景View
    CGFloat firstViewX = 0;
    CGFloat firstViewY = 64 + 39;
    CGFloat firstViewW = ScreenWidth;
    CGFloat firstViewH = ScreenHeight - firstViewY;
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(firstViewX, firstViewY, firstViewW, firstViewH)];
    _backView.backgroundColor = COLOR_C4;
    [self.view addSubview:_backView];
    
    
    _array1 = @[@"输入产检时医生告诉的预产期，如尚未产检可以使用我们提供的“计算预产期”", @"输入预产期:"];
    _array2 = @[@"填写末次月经日期，我们将为你自动计算出预产期", @"末次月经日期:"];
    
    // 输入预产期页面提醒文字
    CGFloat titleX = 20;
    CGFloat titleY = 15;
    CGFloat titleW = ScreenWidth - titleX * 2;
    CGFloat titleH = 35;
    _title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
    _title.textColor = COLOR_C3;
    _title.font = UIFONT_H3_14;
    _title.text = _array1[0];
    _title.numberOfLines = 0;
    _title.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:_title];
    
    // 输入预产期页面输入框提醒文字
    CGFloat alertTitleX = titleX;
    CGFloat alertTitleY = titleY + titleH + 15;
    CGFloat alertTitleW = ScreenWidth - alertTitleX * 2;
    CGFloat alertTitleH = 15;
    _alertTitle = [[UILabel alloc] initWithFrame:CGRectMake(alertTitleX, alertTitleY, alertTitleW, alertTitleH)];
    _alertTitle.textColor = COLOR_C2;
    _alertTitle.font = UIFONT_H3_14;
    _alertTitle.text = _array1[1];
    _alertTitle.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:_alertTitle];
    

    // 设置日期选择框
    _dateField = [[XMTextField alloc] init];
    
    CGFloat dateFieldX = titleX;
    CGFloat dateFieldY = alertTitleY + alertTitleH + 15;
    CGFloat dateFieldW = titleW;
    CGFloat dateFieldH = 39;
    _dateField.frame = CGRectMake(dateFieldX, dateFieldY, dateFieldW, dateFieldH);
    _dateField.leftImageView.image = [UIImage imageNamed:@"dateIcon"];
    _dateField.delegate = self;
    _dateField.text = self.timeStr;
    _dateField.placeholder = @"输入您的日期";
    _dateField.tag = 10;
    [_backView addSubview:_dateField];

    // 确定按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat buttonX = dateFieldX;
    CGFloat buttonY = dateFieldY + dateFieldH + 30;
    CGFloat buttonW = ScreenWidth - buttonX * 2;
    CGFloat buttonH = 39;
    button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    button.backgroundColor = kColorTheme;
    [button setTitle:@"确定"  forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [_backView addSubview:button];
    
    
    // 实例化实现选择器
    self.datePicker = [[MainPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.datePicker.delegate = self;
}

// 标签按钮点击事件（切换提示内容和显示效果）
- (void)buttonClick:(UIButton *)sender
{
    UIButton * button  = (UIButton *)sender;
    
    // 提醒文字的切换
    if (button.tag == 10) {
        _title.text = _array1[0];
        _alertTitle.text = _array1[1];
        _dateField.text = self.timeStr;
        self.dateType = dueType;
    }
    else
    {
        _title.text = _array2[0];
        _alertTitle.text = _array2[1];
        // 预产期算出末次月经时间
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *dueDate = [dateFormatter dateFromString:self.timeStr];
        NSDate *lastMensDate = [dueDate getMensesDate];
        _dateField.text = [dateFormatter stringFromDate:lastMensDate];
        self.dateType = lastMensType;
    }
    
    if (button.selected == NO) {
        for (int i = 0; i < 2; i++) {
            UIButton * otherButton = (UIButton *)[self.view viewWithTag:10 + i];
            if (otherButton.tag != button.tag) {
                otherButton.selected = NO;
                otherButton.userInteractionEnabled = YES;
            }
        }
        button.selected = !button.selected;
        if (button.selected == YES) {
            button.userInteractionEnabled = NO;
        }
        NSInteger i = button.tag - 10;
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGFloat W = ScreenWidth / 4;
                             CGFloat X = W / 2 + (2 * W) * i;
                             CGFloat Y = 64 + 37;
                             CGFloat H = 2;
                             _scorllLine.frame = CGRectMake(X, Y, W, H);
                             
                         }];
    }
    
}
// 点击输入框的操作
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.dateType == lastMensType) {
        _datePicker.allowSelectLater = NO;
    } else {
        _datePicker.allowSelectLater = YES;
    }
    [_datePicker showPickerView];
    return NO;
}

- (void)dateString:(NSString *)str
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *defaulDate = [NSDate date];
    // 系统时间
    NSString *defauldStr = [dateFormatter stringFromDate:defaulDate];
    if (self.dateType == dueType) { // 输入预产期状态
        if (str.length == 0 || str == nil || str == NULL) {
            self.dueStr = defauldStr;
        }
        else if ([str getTimestamp].integerValue < [defauldStr getTimestamp].integerValue)
        {
            [self.view showToastMessage:@"您选择的时间有误"];
            self.dueStr = defauldStr;
        }
        else
        {
            self.dueStr = str;
        }
        _dateField.text = self.dueStr;
        
        // 预产期算出末次月经时间
        NSDate *dueDate = [dateFormatter dateFromString:self.dueStr];
        NSDate *lastMensDate = [dueDate getMensesDate];
        self.lastMensStr = [dateFormatter stringFromDate:lastMensDate];
    }
    else  // 输入末次月经状态
    {
        // 用户选择的末次月经时间(字符串格式)
        NSString *defaulDateLength = [defauldStr getTimestamp];
        NSString *selectTimeLength = [str getTimestamp];
        NSInteger endMensTime = defaulDateLength.integerValue - 293 * 24 * 60 * 60;
        
        if (str.length == 0 || str == nil || str == NULL) {
            self.lastMensStr = defauldStr;
        }
        else if (selectTimeLength.integerValue < endMensTime || selectTimeLength.integerValue > defaulDateLength.integerValue)
        {
            [self.view showToastMessage:@"您选择的时间有误"];
            self.lastMensStr = defauldStr;
        }
        else
        {
            self.lastMensStr = str;
        }
        _dateField.text = self.lastMensStr;
        // 末次月经时间转预产期
        NSDate *lastMensStrDate = [dateFormatter dateFromString:self.lastMensStr];
        NSDate *dueDate = [lastMensStrDate getDueDate];
        self.dueStr = [dateFormatter stringFromDate:dueDate];
    }

}

// 确定按钮点击事件
- (void)buttonAction
{
    // 获得系统时间
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *defaultDate = [dateFormatter stringFromDate:[NSDate date]];
    // 系统时间转时间戳
    NSString *defaultDateStr = [defaultDate getTimestamp];
    
    if (self.dateType == dueType) // 当选择的是预产期状态输入
    {
//        if (self.dueStr.length == 0) {
//            self.dueStr = self.timeStr;
//        }
        // 最长孕期时间戳
        NSInteger futureDate = defaultDateStr.integerValue + 293 * 24 * 60 * 60;
        // 实际孕期(选择的孕期时间)
        NSString *cuttentDateStr = [_dateField.text getTimestamp];
        // 选择的预产期不能比当前时间小  也不能大于最大的预产期（如果今天是怀孕第一天，那么293天以后就是最后一天预产期）
        if (cuttentDateStr.integerValue < defaultDateStr.integerValue || cuttentDateStr.integerValue > futureDate)
        {
            [self.view showToastMessage:@"您选择的时间有误,请重新选择正确的时间"];
            return;
        }
        else
        {
            [self saveDate];
        }
    }
    else
    {   // 当设置的是末次月经时间的时候
        // 当前选择的末次月经时间
        NSInteger currentMensTime = [_dateField.text getTimestamp].integerValue;
        // 最晚可选择的的末次月经时间
        NSInteger endMensTime = defaultDateStr.integerValue - 293 * 24 * 60 * 60;
        
        // 末次月经时间不能小于最小预产期（当前时间减去293天）也不能大于当天时间
        if (currentMensTime < endMensTime || currentMensTime > defaultDateStr.integerValue) {
            [self.view showToastMessage:@"您选择的时间有误,请重新选择正确的时间"];
            return;
        }
        else
        {
            [self saveDate];
        }
    }
}

// 存储孕期时间
- (void)saveDate
{
    // 0、删除育儿信息
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *documentsFile = [NSHomeDirectory() stringByAppendingString:@"/Documents/"];
    NSString *babyInfoFilePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/babyInfo.data"];
    if ([manager fileExistsAtPath:documentsFile]) {
        [manager removeItemAtPath:babyInfoFilePath error:nil];
    }
    
    // 1、将孕期时间存储
    if (self.dueStr.length == 0) {
        self.dueStr = self.timeStr;
    }
    
    // 隐藏时间选择器
    [UIView animateWithDuration:0.3 animations:^{
        _datePicker.y = ScreenHeight;
    }];
    
    // 2、如果是注册用户才可以上传信息
    if (kUserInfo.isLogined) {
        [self putUserInfo];
    } else {
        // 3、跳到主页面
        [self jumpToMainTabBarVC];
    }
}

#pragma mark 上传信息
- (void)putUserInfo
{
    NSString *dueTime = [self.dueStr getTimestamp];            // 预产期
    NSString *lastMensTime = [self.lastMensStr getTimestamp];  // 末次月经时间

    Input_params *params = [[Input_params alloc] init];
    params.token = kUserInfo.token;
    params.Id = [NSString stringWithFormat:@"%ld",kUserInfo.Id];
    params.status = @(kUserStateMum);
    params.dueDate = dueTime;
    params.lastMenses = lastMensTime;
    [self.view showPopupLoading];
    [[Network_Login new] putUserInfoWith:params responseBlock:^(LLError *error) {
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
    kUserInfo.currentBaby = nil;
    kUserInfo.status = kUserStateMum;
    kUserInfo.dueDateStr = self.dueStr;
    [kUserInfo synchronize];
//    if (kUserInfo.status)
//    {
//        
//        if (kUserInfo.nickname || kUserInfo.residence || kUserInfo.age || kUserInfo.avatar)
//        {
//            [kAppDelegate toMain];
//        }
//        else
//        {
////            SelfViewController *selfVC = [[SelfViewController alloc] init];
////            [self.navigationController pushViewController:selfVC animated:YES];
//        }
//    }
//    else
//    {
//        [kAppDelegate toMain];
//    }
    [kAppDelegate toMain];
}

@end
