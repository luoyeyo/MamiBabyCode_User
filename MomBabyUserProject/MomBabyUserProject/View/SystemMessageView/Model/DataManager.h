//
//  APNSModel.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/28.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "SystemMessage.h"
#import "YZKDBTool.h"
#import "HeightAndWeightModel.h"
#import "HeightAndWeightRange.h"


#pragma mark - 数据库相关字段

// 存放一些用户信息的表
static NSString *const SQLTableUserInfo = @"userInfo";
// 默认用户message主表   同时作为查询相关信息 的用户id
#define SQLTableName [NSString stringWithFormat:@"t_userId%ld",(long)kUserInfo.Id]
// 存放消息的时间  没实际作用
static NSString *const SQLTableKeyMessageTime = @"messagetime";
// 存放消息实例的二进制文件
static NSString *const SQLTableKeyMessage = @"message";
// 登陆时间
static NSString *const SQLTableKeyLoginTime = @"loginTime";
// userid
static NSString *const SQLTableKeyUid = @"uid";
// 主键 用来标记消息的row
static NSString *const SQLTablePrimaryKey = @"m_id";
// 最后一次收到消息的时间
static NSString *const SQLTableKeyNotiTime = @"lastTime";

/**
 *  推送  数据库管理
 */
@interface DataManager : JSONModel

//@property (nonatomic, strong) NSDictionary *aps;
//@property (nonatomic, assign) NSInteger type;
//@property (nonatomic, strong) NSDictionary *xg;

/**
 *  创建默认sql表
 */
+ (void)createDefaultTable;

/**
 *  收到推送时计算角标
 */
+ (void)didReceiveRemoteNotification;

/**
 *  更新数据库中的最后收到通知时间
 */
+ (void)updateLastReceiveMessageTime;

/**
 *  获取最后收到消息的时间
 *
 *  @return
 */
+ (long long int)getLastNotiTime;

/**
 *  保存信息列表
 *
 *  @param list
 *
 *  @return
 */
+ (void)saveMessage:(NSArray *)list;
/**
 *  通过下标获取数据
 *
 *  @param index 下标
 *
 *  @return
 */
+ (NSArray *)getMessageWithLastId:(NSInteger)index;

/**
 *  刷新数据
 *
 *  @param index
 *  @param message
 */
+ (void)updateStateWithRow:(NSInteger)index message:(SystemMessage *)message;

/**
 *  倒序消息列表
 *
 *  @return
 */
+ (NSArray *)descSelect;
/**
 *  更新危机消息count
 *
 *  @param count
 */
//+ (void)updateUnreadCountWithCount:(NSInteger)count;
/**
 *  获取危机消息count
 *
 *  @return
 */
//+ (NSInteger)getUnreadCountWithCount;
/**
 *  更新系统消息count
 *
 *  @param count
 */
//+ (void)updateUnreadSystemMessageCountWithCount:(NSInteger)count;
/**
 *  获取系统消息count
 *
 *  @return
 */
//+ (NSInteger)getUnreadSystemCountWithCount;


#pragma mark - plist数据处理
/**
 *  获取孕妇怀孕宝宝的身高..
 *
 *  @return HeightAndWeightModel.array
 */
+ (NSArray *)getBabyHeightAndWeight;

+ (NSArray *)getBoyHeightAndWeight;

+ (NSArray *)getGirlHeightAndWeight;

@end
