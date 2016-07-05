//
//  AppDelegate.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTabbarController.h"
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HomeTabbarController *homeTab;

/**
 *  退送出登陆页面
 */
- (void)toPresentLogin;
- (void)toLogin;
- (void)toMain;
/**
 *  选择用户状态
 */
- (void)toChooseUserState;

/**
 *  再次登陆
 */
- (void)toLoginAgain;

@end

