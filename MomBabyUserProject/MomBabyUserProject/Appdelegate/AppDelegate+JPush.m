//
//  AppDelegate+JPush.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/15.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import "JPUSHService.h"
#import "XGPush.h"
#import "MessageViewController.h"
#import "RIButtonItem.h"

@implementation AppDelegate (JPush)

- (void)registerPush_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (SystemVersion >= 8.0) {
        //       categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    } else {
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert) categories:nil];
    }
    [JPUSHService setupWithOption:launchOptions appKey:AppKey_JPush channel:@"App Store" apsForProduction:NO];
    [self registerThePushStateObserver];
}

- (void)registerThePushStateObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushState:) name:kJPFNetworkDidSetupNotification object:@"建立连接"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushState:) name:kJPFNetworkDidCloseNotification object:@"关闭连接"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushState:) name:kJPFNetworkDidRegisterNotification object:@"注册成功"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushState:) name:kJPFNetworkDidLoginNotification object:@"登录成功"];
}

- (void)registerPush_DeviceToken:(NSData *)token {
    [JPUSHService registerDeviceToken:token];
}

- (void)pushState:(NSNotification *)noti {
    NSLog(@"%@",noti.object);
}

#pragma mark - XGPush

//- (void)registerPush_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    //推送
//    [XGPush startApp:2200175595 appKey:@"IC43BB553IXP"];
//    //注销之后需要再次注册前的准备
//    void (^successCallback)(void) = ^(void){
//        //如果变成需要注册状态
//        if(![XGPush isUnRegisterStatus])
//        {
//            //Types
//            UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
//            
//            //Actions
//            UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
//            
//            acceptAction.identifier = @"ACCEPT_IDENTIFIER";
//            acceptAction.title = @"Accept";
//            
//            acceptAction.activationMode = UIUserNotificationActivationModeForeground;
//            acceptAction.destructive = NO;
//            acceptAction.authenticationRequired = NO;
//            
//            //Categories
//            UIMutableUserNotificationCategory *inviteCategory = [[UIMutableUserNotificationCategory alloc] init];
//            
//            inviteCategory.identifier = @"INVITE_CATEGORY";
//            
//            [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextDefault];
//            
//            [inviteCategory setActions:@[acceptAction] forContext:UIUserNotificationActionContextMinimal];
//            
//            NSSet *categories = [NSSet setWithObjects:inviteCategory, nil];
//            
//            UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
//            
//            [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
//            
//            [[UIApplication sharedApplication] registerForRemoteNotifications];
//        }
//    };
//    [XGPush initForReregister:successCallback];
//}

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    [XGPush handleReceiveNotification:userInfo];
    [JPUSHService handleRemoteNotification:userInfo];
    [DataManager didReceiveRemoteNotification];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        RIButtonItem *item = [RIButtonItem itemWithLabel:@"查看" action:^{
            [self pushViewContollerWithDict:userInfo];
        }];
        RIButtonItem *cancel = [RIButtonItem itemWithLabel:@"取消" action:nil];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"取消" message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"] cancelButtonItem:cancel otherButtonItems:item, nil];
        [alertView show];
    } else {
        [self pushViewContollerWithDict:userInfo];
    }
}

//- (void)registerPush_DeviceToken:(NSData *)token {

//    [XGPush registerDevice:token];
//}


- (void)pushViewContollerWithDict:(NSDictionary *)dict {
    int type = [[dict objectForKey:@"type"] intValue];
    if (type == 1 || type == 2 || type == 3) {
        MessageViewController * mesVC = [[MessageViewController alloc] init];
        mesVC.pushType = @"推送";
        [self.window.rootViewController presentViewController:mesVC animated:NO completion:^{
            
        }];
    }
//    else if (type == 5){
//        HighRiskViewController * highRiskVC = [[HighRiskViewController alloc] init];
//        highRiskVC.pushType = @"推送";
//        [self.window.rootViewController presentViewController:highRiskVC animated:NO completion:^{
//            
//        }];
//    }
}

@end
