//
//  ChooseStateViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/30.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "ChooseStateViewController.h"
#import "LogInViewController.h"

#import "SetDueDateViewController.h" // 我怀孕了
#import "HaveBabyViewController.h"   // 家有宝贝



@interface ChooseStateViewController ()
{
    UITableView *_tableView;
    NSArray *_dataSource;
}

@property (nonatomic, strong) UIButton *loginBtn;
@end

@implementation ChooseStateViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (kUserInfo.isLogined) {
        self.loginBtn.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
}

- (void)createUI
{
    self.title = @"我的状态";
    self.view.backgroundColor = COLOR_C4;
    [self navbarSetAppThemeAppearance];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, backView.height * 0.5, ScreenWidth - 40, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [backView addSubview:line];
    
    NSArray *imageArr = @[@"怀孕", @"宝贝"];
    NSArray *titleArr = @[@"我怀孕了", @"家有宝贝"];
    
    for (int i = 0; i < imageArr.count; i ++) {
        
        CGFloat chooseBtnW = 74;
        CGFloat chooseBtnX = (ScreenWidth - chooseBtnW) * 0.5;
        CGFloat chooseBtnY = 10 + (125) * i;
        CGFloat chooseBtnH = chooseBtnW;
        
        UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        chooseBtn.frame = CGRectMake(chooseBtnX, chooseBtnY, chooseBtnW, chooseBtnH);
        chooseBtn.tag = 10 + i;
        [chooseBtn setBackgroundImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [chooseBtn addTarget:self action:@selector(chooseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [backView addSubview:chooseBtn];
        
        CGFloat titleX = 40;
        CGFloat titleY = 10 + chooseBtnH + 13 + (125) * i;
        CGFloat titleW = ScreenWidth - titleX * 2;
        CGFloat titleH = 15;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        title.text = titleArr[i];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = UIFONT_H4_15;
        title.textColor = kColorTheme;
        [backView addSubview:title];
    }
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGFloat loginBtnW = 165;
    CGFloat loginBtnX = (ScreenWidth - loginBtnW) * 0.5;
    CGFloat loginBtnY = 250 + 25;
    CGFloat loginBtnH = 14;
    _loginBtn.frame = CGRectMake(loginBtnX, loginBtnY, loginBtnW, loginBtnH);
    [_loginBtn setTitle:@"已有账号,请直接登录 >>>" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:COLOR_C1 forState:UIControlStateNormal];
    _loginBtn.titleLabel.font = UIFONT_H3_14;
    [_loginBtn addTarget:self action:@selector(jumpToLoginViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
}

- (void)chooseBtnAction:(UIButton *) sender
{
    UIButton *button = (UIButton *)sender;
    if (button.tag == 10) {
        
        SetDueDateViewController *setDueDateVC = [[SetDueDateViewController alloc] init];
        [self pushViewController:setDueDateVC];
    } else {
        HaveBabyViewController *haveBabyVC = [[HaveBabyViewController alloc] init];
        [self pushViewController:haveBabyVC];
    }
}

- (void)jumpToLoginViewController
{
    [kAppDelegate toLogin];
}


@end
