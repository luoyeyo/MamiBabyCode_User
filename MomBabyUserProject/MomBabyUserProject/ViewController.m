//
//  ViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    DLog(@"释放页面------%@",NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认导航栏左按钮
    [self initializeDataSource];
    [self initializeAppearance];
    [self defaultTabbar];
    [self setIQkeyboard];
    [self registerNotifications];
}

/**
 *  初始化界面
 */
- (void)initializeAppearance {
    
}

/**
 *  初始化数据
 */
- (void)initializeDataSource {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window) {
        self.view = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}
/**
 *  设置键盘管理
 */
- (void)setIQkeyboard {
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
    self.returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyDone;
    self.returnKeyHandler.toolbarManageBehaviour = IQAutoToolbarBySubviews;
}
#pragma mark - 通知相关
- (void)registerNotifications
{
    
}

#pragma mark - 导航栏
- (void)defaultTabbar {
    self.tabBarController.tabBar.backgroundColor = kColorDefaultWhite;
}
- (void)defaultNavbar {
    [self setNavBarBackgroundColor:kColorTheme];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorTheme]
//                                                 forBarPosition:UIBarPositionAny
//                                                     barMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    [self.navigationController.navigationBar setBackIndicatorImage:ImageNamed(@"page5-icon-button-arrow")];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:ImageNamed(@"page5-icon-button-arrow")];
}

- (void)customNavgationBar {
    
    self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    self.navigationBarView.backgroundColor = kColorTheme;
    [self.view addSubview:self.navigationBarView];
    
    self.navTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 44)];
    
    
    self.navTitle.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
    self.navTitle.textColor = [UIColor colorFromHexRGB:@"ffffff"];
    self.navTitle.textAlignment = NSTextAlignmentCenter;
    [self.navigationBarView addSubview:self.navTitle];
    
    self.othersButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.othersButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.othersButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.othersButton.frame = CGRectMake(0, 0, 100, 44);
    self.othersButton.center = CGPointMake(ScreenWidth - 30, self.navTitle.center.y);
    [self.navigationBarView addSubview:self.othersButton];
    self.othersButton.hidden = YES;
    
    self.navigationController.navigationBar.hidden = YES;
    
    // 142 100
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(10, 21, 22, 22);
    self.backButton.center = CGPointMake(self.backButton.center.x, self.navTitle.center.y);
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView addSubview:self.backButton];
}


@end
