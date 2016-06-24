//
//  ShareManager.m
//  MombabyProject
//
//  Created by 罗野 on 16/6/22.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "ShareManager.h"
#import "UMSocial.h"

@implementation ShareManager

+ (void)shareTitle:(NSString *)title text:(NSString *)text url:(NSString *)url {
    if (url.length > 0) {
        [UMSocialData defaultData].extConfig.qqData.url = url;
        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    }
    [UMSocialData defaultData].extConfig.title = title;
    [UMSocialSnsService presentSnsIconSheetView:kAppDelegate.homeTab
                                         appKey:AppKey_UMeng
                                      shareText:text
                                     shareImage:ImageNamed(@"shareImage")
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,nil]
                                       delegate:nil];
}

@end
