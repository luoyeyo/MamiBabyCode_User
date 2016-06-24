//
//  AppDelegate+JPush.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/15.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JPush)

// 注册push
- (void)registerPush_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

- (void)registerPush_DeviceToken:(NSData *)token;
@end
