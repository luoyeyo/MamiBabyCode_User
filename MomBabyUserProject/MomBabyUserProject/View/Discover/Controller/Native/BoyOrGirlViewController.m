//
//  BoyOrGirlViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/13.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "BoyOrGirlViewController.h"
#import "XMTextField.h"
#import "BoyGirlListModel.h"

@interface BoyOrGirlViewController ()<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    // 选择框变量
    XMTextField *_dateField;
    XMTextField *_ageField;
    
    // 重要控件变量
    UIButton *_testButton;
    UIImageView *_resultView;
    UIView *_coverView;   //遮盖面板
    UIView *_bottomView;
    
    // 时间和年龄选择器控件
    UIView *_dateBackView;
    UIView *_dateBtnView;
    UIPickerView *_datePickView;
    
    UIView *_ageBackView;
    UIView *_ageBtnView;
    UIPickerView *_agePickView;

    // 时间和年龄选择器数据源
    NSArray *_pikMonthSource;
    NSArray *_pikAgeSource;
}

@property (nonatomic, strong) NSDictionary *allDataSource;
@property (nonatomic, weak) UILabel *resultTitle;
@property (nonatomic, copy) NSString *dateText;
@property (nonatomic, copy) NSString *ageText;


@end


@implementation BoyOrGirlViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"生男生女"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"生男生女"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"生男生女";
    // 创建UI
    [self createUI];
    
}

#pragma mark - UI创建
- (void)createUI
{
    self.view.backgroundColor = COLOR_C4;
    
    // 设置title文字
    UILabel *titleLabel = [[UILabel alloc] init];
    
    CGFloat titleLabelX = 16;
    CGFloat titleLabelY = 0 + 21;
    CGFloat titleLabelW = ScreenWidth - 32;
    CGFloat titleBabelH = 15;
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleBabelH);

    titleLabel.textColor = COLOR_C1;
    titleLabel.font = UIFONT_H4_15;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"生男生女预测表";
    [self.view addSubview:titleLabel];
    
    // 设置日期选择框标题
    UILabel *dateLabel = [[UILabel alloc] init];
    
    CGFloat dateLabelX = titleLabelX;
    CGFloat dateLabelY = titleLabelY + 15 + 21;
    CGFloat dateLabelW = titleLabelW;
    CGFloat dateLabelH = 14;
    dateLabel.frame = CGRectMake(dateLabelX, dateLabelY, dateLabelW, dateLabelH);
    
    dateLabel.textColor = COLOR_C2;
    dateLabel.font = UIFONT_H3_14;
    dateLabel.text = @"您怀孕的月份（农历）：";
    [self.view addSubview:dateLabel];
    
    // 设置日期选择框
    _dateField = [[XMTextField alloc] init];
    
    CGFloat dateFieldX = titleLabelX;
    CGFloat dateFieldY = dateLabelY + 14 + 14;
    CGFloat dateFieldW = titleLabelW;
    CGFloat dateFieldH = 39;
    _dateField.frame = CGRectMake(dateFieldX, dateFieldY, dateFieldW, dateFieldH);
    _dateField.leftImageView.image = [UIImage imageNamed:@"dateIcon"];
    _dateField.delegate = self;
    _dateField.textColor = COLOR_C2;
    _dateField.text = @"1月";
    _dateField.placeholder = @"选择您怀孕的月份";
    _dateField.tag = 10;
    [self.view addSubview:_dateField];
    
    // 设置年龄选择框标题
    UILabel *ageLabel = [[UILabel alloc] init];
    
    CGFloat ageLabelX = titleLabelX;
    CGFloat ageLabelY = dateFieldY + dateFieldH + 19;
    CGFloat ageLabelW = titleLabelW;
    CGFloat ageLabelH = 14;
    ageLabel.frame = CGRectMake(ageLabelX, ageLabelY, ageLabelW, ageLabelH);
    
    ageLabel.textColor = COLOR_C2;
    ageLabel.font = UIFONT_H3_14;
    ageLabel.text = @"您的年龄（虚岁）：";
    [self.view addSubview:ageLabel];
    
    // 设置年龄选择框
    _ageField = [[XMTextField alloc] init];
    
    CGFloat ageFieldX = titleLabelX;
    CGFloat ageFieldY = ageLabelY + 14 + 19;
    CGFloat ageFieldW = titleLabelW;
    CGFloat ageFieldH = dateFieldH;
    _ageField.frame = CGRectMake(ageFieldX, ageFieldY, ageFieldW, ageFieldH);
    _ageField.leftImageView.image = [UIImage imageNamed:@"dateIcon"];
    _ageField.delegate = self;
    _ageField.textColor = COLOR_C2;
    _ageField.text = @"18岁";
    _ageField.placeholder = @"选择您怀孕的年龄";
    _ageField.tag = 11;
    [self.view addSubview:_ageField];
    
    // 创建日期选择器
    [self createDatePickerView];
    // 创建年龄选择器
    [self createAgePickerView];
    // 创建计算按钮
    [self createTestButton];
    
    [_dateField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    [_ageField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    
}
// 创建日期选择器
- (void)createDatePickerView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    // 初始化时间和年龄选择器内容
    _pikMonthSource = @[@"1月",@"2月",@"3月",@"4月",@"5月",@"6月",@"7月",@"8月",@"9月",@"10月",@"11月",@"12月"];
    _dateBackView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight - 249)];
    _dateBackView.backgroundColor = [UIColor blackColor];
    _dateBackView.alpha = 0.3;
    _dateBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_dateBackView addGestureRecognizer:tap];
    [window addSubview:_dateBackView];
    
    _dateBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 49)];
    _dateBtnView.backgroundColor = [UIColor whiteColor];
    [window addSubview:_dateBtnView];
    NSArray *btnTextArr = @[@"取消", @"确定"];
    for (int i = 0; i < btnTextArr.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            button.frame = CGRectMake(10, 10, 80, 29);
        }
        else
        {
            button.frame = CGRectMake(ScreenWidth - 10 - 80, 10, 80, 29);
        }
        button.backgroundColor = kColorTheme;
        button.titleLabel.font = UIFONT_H3_14;
        button.tag = 1 + i;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 3;
        [button setTitle:btnTextArr[i] forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_dateBtnView addSubview:button];
    }
    _datePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 200)];
    _datePickView.backgroundColor = [UIColor whiteColor];
    _datePickView.showsSelectionIndicator = YES;
    _datePickView.dataSource = self;
    _datePickView.delegate = self;
    _datePickView.tag = 100;
    [window addSubview:_datePickView];
}

// 创建年龄选择器
- (void)createAgePickerView
{
    _pikAgeSource = @[@"18岁",@"19岁",@"20岁",@"21岁",@"22岁",@"23岁",@"24岁",@"25岁",@"26岁",@"27岁",@"28岁",@"29岁",@"30岁",@"31岁",@"32岁",@"33岁",@"34岁",@"35岁",@"36岁",@"37岁",@"38岁",@"39岁",@"40岁",@"41岁",@"42岁",@"43岁",@"44岁",@"45岁"];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    _ageBackView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight - 249)];
    _ageBackView.backgroundColor = [UIColor blackColor];
    _ageBackView.alpha = 0.3;
    _ageBackView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_ageBackView addGestureRecognizer:tap];
    [window addSubview:_ageBackView];
    
    _ageBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 49)];
    _ageBtnView.backgroundColor = [UIColor whiteColor];
    [window addSubview:_ageBtnView];
    NSArray *btnTextArr = @[@"取消", @"确定"];
    for (int i = 0; i < btnTextArr.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            button.frame = CGRectMake(10, 10, 80, 29);
        }
        else
        {
            button.frame = CGRectMake(ScreenWidth - 10 - 80, 10, 80, 29);
        }
        button.backgroundColor = kColorTheme;
        button.titleLabel.font = UIFONT_H3_14;
        button.tag = 1 + i;
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 3;
        [button setTitle:btnTextArr[i] forState:UIControlStateNormal];
        [button setTintColor:[UIColor whiteColor]];
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [_ageBtnView addSubview:button];
    }
    
    _agePickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 200)];
    _agePickView.backgroundColor = [UIColor whiteColor];
    _agePickView.showsSelectionIndicator = YES;
    _agePickView.dataSource = self;
    _agePickView.delegate = self;
    _agePickView.tag = 101;
    [window addSubview:_agePickView];
  
}

// 创建计算按钮
- (void)createTestButton
{
    _testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat testButtonX = 16;
    CGFloat testButtonY = 324 - 64;
    CGFloat testButtonW = ScreenWidth - 32;
    CGFloat testButtonH = 39;

    _testButton.frame = CGRectMake(testButtonX, testButtonY, testButtonW, testButtonH);
    
    _testButton.layer.masksToBounds = YES;
    _testButton.layer.cornerRadius = 3;
    _testButton.backgroundColor = kColorTheme;
    if (_dateField.text.length == 0 || _ageField.text.length == 0) {
        _testButton.enabled = YES;
        [_testButton setTitle:@"请选择月份和年龄" forState:UIControlStateNormal];
    }
    else
    {
        [_testButton setTitle:@"计算" forState:UIControlStateNormal];
        [_testButton addTarget:self action:@selector(testButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self.view addSubview:_testButton];
}

// 计算按钮点击事件
-(void)testButtonAction
{
    // 移除计算按钮
    [_testButton removeFromSuperview];
    
    // 换成测试结果的View
    _resultView = [[UIImageView alloc] init];
    _resultView.image = [UIImage imageNamed:@"testImage"];
    
    CGFloat resultViewX = _testButton.frame.origin.x;
    CGFloat resultViewY = _testButton.frame.origin.y - 45 + 16;
    CGFloat resultViewW = _testButton.frame.size.width;
    CGFloat resultViewH = _resultView.image.size.height;
    _resultView.frame = CGRectMake(resultViewX, resultViewY, resultViewW, resultViewH);
    [self.view addSubview:_resultView];
    
    
    // 添加测试结果里面的title内容
    UILabel *resultTitle = [[UILabel alloc] init];
    
    CGFloat resultTitleX = 38;
    CGFloat resultTitleY = 56;
    CGFloat resultTitleW = resultViewW - resultTitleX * 2;
    CGFloat resultTitleH = 50;
    resultTitle.frame = CGRectMake(resultTitleX, resultTitleY, resultTitleW, resultTitleH);
    
    resultTitle.numberOfLines = 0;
    resultTitle.textColor = COLOR_C2;
    resultTitle.font = UIFONT_H6_16;
    [_resultView addSubview:resultTitle];
    self.resultTitle = resultTitle;
    // 添加测试结果里面的提醒内容
    UILabel *alertLabel = [[UILabel alloc] init];
    
    CGFloat alertLabelX = resultTitleX;
    CGFloat alertLabelY = resultTitleY + 50 + 34;
    CGFloat alertLabelW = resultViewW - alertLabelX * 2;
    CGFloat alertLabelH = 50;
    alertLabel.frame = CGRectMake(alertLabelX, alertLabelY, alertLabelW, alertLabelH);
    
    alertLabel.numberOfLines = 0;
    alertLabel.textColor = COLOR_C3;
    alertLabel.font = UIFONT_H3_14;
    alertLabel.text = @"特此说明，生男生女预测表为民间所传，并无科学依据，测试结果仅供参考";
    [_resultView addSubview:alertLabel];
    

    // 添加分享和清除按钮
    _bottomView = [[UIView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    
    CGFloat bottomViewX = 0;
    CGFloat bottomViewH = 59;
    CGFloat bottomViewY = ScreenHeight - bottomViewH - 64;
    CGFloat bottomViewW = ScreenWidth;
    _bottomView.frame = CGRectMake(bottomViewX, bottomViewY, bottomViewW, bottomViewH);
    [self.view addSubview:_bottomView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    line.backgroundColor =  COLOR_LINE;
    [_bottomView addSubview:line];
    
//    BOOL weChat = [WXApi isWXAppInstalled];
//    BOOL qq = [QQApiInterface isQQInstalled];
//    /*
//     判断手机上是否安装微信和qq客户端
//     */
//    if (!weChat && !qq) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        
//        CGFloat buttonW = 120;
//        CGFloat buttonH = 39;
////        CGFloat buttonX = (SCREEN_WEIGHT - buttonW * 2) / 4 + ((SCREEN_WEIGHT - buttonW * 2) / 2 + buttonW) * i;
//        CGFloat buttonX = (SCREEN_WEIGHT / 2 - buttonW / 2);
//        CGFloat buttonY = (bottomViewH - buttonH) / 2;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        
//        button.layer.masksToBounds = YES;
//        button.layer.cornerRadius = 3;
//        button.backgroundColor = COLOR_C5;
//        button.tag = 1001;
//        [button setTitle:@"清除" forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView addSubview:button];
//    }
//    else{
        NSArray *array = @[@"分享", @"清除"];
        for (int i = 0; i < 2; i ++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            CGFloat buttonW = 120;
            CGFloat buttonH = 39;
            CGFloat buttonX = (ScreenWidth - buttonW * 2) / 4 + ((ScreenWidth - buttonW * 2) / 2 + buttonW) * i;
            CGFloat buttonY = (bottomViewH - buttonH) / 2;
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            button.layer.masksToBounds = YES;
            button.layer.cornerRadius = 3;
            button.backgroundColor = kColorTheme;
            button.tag = 1000 + i;
            [button setTitle:array[i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [_bottomView addSubview:button];
        }
//    }
    
    
    // 添加遮盖
    _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - bottomViewH)];
    _coverView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_coverView];
    
    [self computeResult];
}

// 计算结果显示
- (void)computeResult
{
    NSString *ageStr = [_ageField.text substringToIndex:_ageField.text.length - 1];
    NSString *dateStr = [_dateField.text substringToIndex:_dateField.text.length - 1];
    NSString *checkStr = [NSString stringWithFormat:@"%@%@", ageStr, dateStr];
    self.allDataSource = [BoyGirlListModel list];
    NSArray *allkeys = [self.allDataSource allKeys];
    for (NSString *key  in  allkeys) {
        if ([checkStr isEqualToString:key]) {
            self.resultTitle.text = [NSString stringWithFormat:@"根据生男生女清宫图，您怀的宝宝性别可能为“%@”孩！", self.allDataSource[key]];
        }
    }
}

// 底部分享和清除按钮点击事件
- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 1000) {
        NSLog(@"分享");
        [ShareManager shareTitle:@"生男生女" text:self.resultTitle.text url:kShareUrl];
    }
    else if (button.tag == 1001)
    {
        [_coverView removeFromSuperview];
        [_resultView removeFromSuperview];
        [_bottomView removeFromSuperview];
        _dateField.text = nil;
        _ageField.text = nil;
        [self createTestButton];
    }
}

// 设置时间和年龄选择器
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 10) {
        [self dataPickerViewHide:NO];
        if (_dateField.text.length == 0 && self.dateText) {
            _dateField.text = self.dateText;
        }
        else if (_dateField.text.length == 0)
        {
            _dateField.text = @"1月";
        }
    }
    else if (textField.tag == 11)
    {
        [self agePickerViewHide:NO];
        if (_ageField.text.length == 0 && self.ageText) {
            _ageField.text = self.ageText;
        }
        else if (_ageField.text.length == 0)
        {
            _ageField.text = @"18岁";
        }
    }
    return NO;
}

#pragma mark - pickerView协议方法
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 100) {
        return [_pikMonthSource count];
    }
    else
    {
        return [_pikAgeSource count];
    }
    
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    
    return 100;
}

// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView.tag == 100) {
        _dateField.text = _pikMonthSource[row];
        self.dateText = _pikMonthSource[row];
    }
    else {
        _ageField.text = _pikAgeSource[row];
        self.ageText = _pikAgeSource[row];
    }
    
}


// 返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView.tag == 100) {
        return [_pikMonthSource objectAtIndex:row];
    } else {
        return [_pikAgeSource objectAtIndex:row];
    }
}

// 监听textFile属性值的变化
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"]) {
        if (_dateField.text.length == 0 || _ageField.text.length == 0) {
            [_testButton setTitle:@"请选择月份和年龄" forState:UIControlStateNormal];
        }
        else
        {
            [_testButton setTitle:@"计算" forState:UIControlStateNormal];
            [_testButton addTarget:self action:@selector(testButtonAction) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
#pragma mark - 移除页面方法

// 选择器取消和确定按钮点击事件
- (void)btnAction:(UIButton *)btn
{
    [self dataPickerViewHide:YES];
    [self agePickerViewHide:YES];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self dataPickerViewHide:YES];
    [self agePickerViewHide:YES];
}
// 点击空白处隐藏时间和年龄选择器
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dataPickerViewHide:YES];
    [self agePickerViewHide:YES];
}

// 是否显示时间选择器
- (void)dataPickerViewHide:(BOOL)hide
{
    if (hide == YES) {
        [UIView animateWithDuration:0.3 animations:^{
            _dateBackView.y = ScreenHeight;
            _datePickView.y = ScreenHeight;
            _dateBtnView.y = ScreenHeight;
        }];

    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _dateBackView.y = 0;
            _datePickView.y = ScreenHeight - 200;
            _dateBtnView.y = ScreenHeight - 249;
        }];

    }
}

// 是否显示年龄选择器
- (void)agePickerViewHide:(BOOL)hide
{
    if (hide == YES) {
        
        [UIView animateWithDuration:0.3 animations:^{
            _ageBackView.y = ScreenHeight;
            _agePickView.y = ScreenHeight;
            _ageBtnView.y = ScreenHeight;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            _ageBackView.y = 0;
            _agePickView.y = ScreenHeight - 200;
            _ageBtnView.y = ScreenHeight - 249;
        }];
    }
}

- (void)dealloc
{
    [_dateField removeObserver:self forKeyPath:@"text"];
    [_ageField removeObserver:self forKeyPath:@"text"];

}

@end
