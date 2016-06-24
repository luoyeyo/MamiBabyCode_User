//
//  AppDelegate+JPush.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/15.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "AppDelegate+JPush.h"
#import "JPUSHService.h"

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

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
    [DataManager didReceiveRemoteNotification];
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

@end
