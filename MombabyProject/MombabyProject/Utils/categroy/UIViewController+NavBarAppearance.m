//
//  UIViewController+NavBarAppearance.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/3/21.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "UIViewController+NavBarAppearance.h"

@implementation UIViewController (NavBarAppearance)

- (void)navbarSetAppThemeAppearance {
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorTheme]
             forBarPosition:UIBarPositionAny
                 barMetrics:UIBarMetricsDefault];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)navbarSetTransparent {
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_background_transparent"]
//             forBarPosition:UIBarPositionAny
//                 barMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"nav_bar_background_transparent"]];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:kColorClear]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:kColorClear]];
    
//    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor],
//                                  NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
//    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"btn_nav_back"]];
//    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"btn_nav_back"]];
}

@end
