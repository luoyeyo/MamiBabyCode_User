//
//  StringDefine.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/6.
//  Copyright © 2016年 iMac. All rights reserved.
//


// 通知
static NSString *const kNotiCloseBabyList = @"宝宝列表关闭";
static NSString *const kTapSearchBar = @"点击搜索栏";
static NSString *const kNotiLogin = @"登录成功";
static NSString *const kNotiSelectThisBaby = @"选择这个宝宝";

static NSString *const kNotiModifyUserInfo = @"修改个人资料成功";
static NSString *const kNotiNoConnection = @"无网络连接";
static NSString *const kNotiTokenFailure = @"TOKEN失效";
static NSString *const kNotiLogOut = @"退出登录";
static NSString *const kNotiSubmitAvatar = @"头像选择完成";
static NSString *const kNotiDidReceiveRemote = @"收到远程推送";
static NSString *const kNotiDidClickNotiBar = @"点击远程推送栏";
static NSString *const kNotiCollectionSuccess = @"成功收藏";
static NSString *const kNotiCancelCollectionSuccess = @"成功取消收藏";
/**
 *  角标变化
 */
static NSString *const kObserverBadgeNum = @"kBadgeNum";



#define kErrorMessage @"数据加载失败"
#define kNoDataMessage @"您现在还没有待处理的孕妇"
#define kNoConnectionMessage @"抱歉，您的网络好像不给力，请检查您的网络设置"
#define kNoEligibleDataMessage @"没有符合条件的孕妇"

#define kErrorCode @"errorcode"
#define kErrorMsg @"errormsg"

// 请求headerToken的字段
#define ksHeaderToken @"Authorization"
// 默认没有数据字符
#define kNoDataStr @"-"

#define ksContent @"content"
// 倒序排序
#define ksSortReverse @"4"