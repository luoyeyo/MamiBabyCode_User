//
//  AppDelegate.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+UMeng.h"
#import <UMengAnalytics-NO-IDFA/MobClick.h>
#import "UserDefaults.h"
#import "NewSpecialityController.h"
#import "AppDelegate+JPush.h"
#import "UMSocial.h"
#import "ChooseStateViewController.h"
#import "BaseNavController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 是否显示新特性
    [self isShowNewSpecialityView];
    [self.window makeKeyAndVisible];
    
    [self defaultConfig];
    // 注册推送
    [self registerPush_application:application didFinishLaunchingWithOptions:launchOptions];
    // 注册友盟统计
    [MobClick startWithAppkey:AppKey_UMeng reportPolicy:BATCH channelId:nil];
    [MobClick setEncryptEnabled:YES];
    // 友盟分享
    [self _UMShareConfig];
    // 如果收到了推送 就刷新
//    NSDictionary *notiInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
//    if (notiInfo) {
//        
//    }
    return YES;
}

- (void)defaultConfig {
    // 注册键盘管理
    [self registerKeyboardManager];
    // 每次启动应用都是刷新 只有点图标启动才回这样
    [DataManager didReceiveRemoteNotification];
    [self checkAppVersion];
}

/**
 *  注册键盘管理
 */
- (void)registerKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

- (void)setTransitionAnimation {
    // 配置切换动画
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.3];
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromTop;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
}

- (void)toLogin {
    [self setTransitionAnimation];
    UIStoryboard *loginS = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UINavigationController *login = [loginS instantiateViewControllerWithIdentifier:@"LoginNav"];
    self.window.rootViewController = login;
}

- (void)toPresentLogin {
    UIStoryboard *loginS = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    UINavigationController *login = [loginS instantiateViewControllerWithIdentifier:@"LoginNav"];
    [self.homeTab presentViewController:login animated:YES completion:nil];
}

- (void)toMain {
    [self setTransitionAnimation];
    self.homeTab = nil;
    self.window.rootViewController = self.homeTab;
}

- (void)toChooseUserState {
    [self setTransitionAnimation];
    ChooseStateViewController *choose = [[ChooseStateViewController alloc] init];
    BaseNavController *nav = [[BaseNavController alloc] initWithRootViewController:choose];
    self.window.rootViewController = nav;
}

/**
 *  检测是否显示新特性
 */
- (void)isShowNewSpecialityView {
    
    if ([[UserDefaults getCurrentVersion] isEqualToString:[UserDefaults lastVersion]]) { // 版本号相同：这次打开和上次打开的是同一个版本
        [self checkIsLogin];
    } else { // 这次打开的版本和上一次不一样，显示新特性
        NewSpecialityController *nsVC = [[NewSpecialityController alloc] init];
        __weak AppDelegate *weakSelf = self;
        nsVC.block = ^() {
            [weakSelf checkIsLogin];
        };
        self.window.rootViewController = nsVC;
        [UserDefaults saveCurrentVersion];
    }
}

- (void)checkIsLogin {
//    // 如果已登录 或者   用户已经选择过类型
//    if (kUserInfo.isLogined == YES || (![NSString isEmptyString:kUserInfo.babyBirth] && ![NSString isEmptyString:kUserInfo.dueDateStr])) {
//        [kAppDelegate toMain];
//        return;
//    }
    // 验证是否登陆
//    if  {
    // 只要选着了状态 就进入主页 否则就去选
    if (kUserInfo.status == kUserStateNo) {
        [kAppDelegate toChooseUserState];
    } else {
        [kAppDelegate toMain];
    }
//    } else {
//        [self toChooseUserState];
//    }
    DLog(@"token : %@",kUserInfo.token);
}

/**
 *  检查更新
 */
- (void)checkAppVersion {
    
//    [kShareManager_Vaccinate getNewVersionResponseBlock:^(AppVersion *info) {
//        if (info) {
//            if (locationVersion < info.versionCode) {
//                RIButtonItem *cancelBtn = [RIButtonItem itemWithLabel:@"取消" action:nil];
//                RIButtonItem *update = [RIButtonItem itemWithLabel:@"前往更新" action:^{
//                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:info.downloadUrl]];
//                }];
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"更新提示" message:info.Description cancelButtonItem:cancelBtn otherButtonItems:update, nil];
//                [alert show];
//            }
//        }
//    }];
}

- (void)toLoginAgain {
    RIButtonItem *item = [RIButtonItem itemWithLabel:@"确定" action:^{
        [self toChooseUserState];
    }];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您的登录信息已经过期" cancelButtonItem:item otherButtonItems: nil];
    [alert show];
}

#pragma mark - push

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo {
    [self didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    [self didReceiveRemoteNotification:userInfo];
    // 如果是点击进来的
    if (application.applicationState == UIApplicationStateInactive) {
        // 选中主页  主页推送消息栏目
        [kAppDelegate.homeTab setSelectedIndex:0];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotiDidClickNotiBar object:nil];
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSString *deviceTokenStr = [[[[deviceToken description]
                          stringByReplacingOccurrencesOfString:@"<" withString:@""]
                         stringByReplacingOccurrencesOfString:@">" withString:@""]
                        stringByReplacingOccurrencesOfString:@" " withString:@""];
    [self registerPush_DeviceToken:deviceToken];
    //注册设备
    [UserDefaults setPushDeviceToken:deviceTokenStr];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 如果角标>0
    if ([UIApplication sharedApplication].applicationIconBadgeNumber > 0) {
//        [[[APNSDataManager alloc] init] didReceiveRemoteNotification];
        [DataManager didReceiveRemoteNotification];
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

#pragma mark - 懒加载

- (HomeTabbarController *)homeTab {
    if (_homeTab == nil) {
        UIStoryboard *storyb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        _homeTab = [storyb instantiateViewControllerWithIdentifier:@"HomeTabbarController"];
    }
    return _homeTab;
}

@end
