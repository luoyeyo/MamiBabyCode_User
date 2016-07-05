//
//  AppDelegate+UMengShare.m
//  AgentForWorld
//
//  Created by 罗野 on 15/10/21.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "AppDelegate+UMeng.h"
#import "UMSocial.h"
#import "UMSocialAccountManager.h"
#import "UMSocialConfig.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

@implementation AppDelegate (UMeng)

#pragma mark - 友盟分享
- (void)_UMShareConfig {
    //所有信息
    [UMSocialData setAppKey:AppKey_UMeng];
    [UMSocialQQHandler setQQWithAppId:AppId_QQ appKey:AppKey_QQ url:kShareUrl];
    [UMSocialWechatHandler setWXAppId:AppKey_WX appSecret:@"" url:kShareUrl];
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToWechatSession, UMShareToWechatTimeline]];
}

@end
