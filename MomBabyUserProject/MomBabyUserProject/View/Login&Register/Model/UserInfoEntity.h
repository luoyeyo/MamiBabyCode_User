//
//  UserInfoEntity.h
//  BaseProject
//
//  Created by luoye on 15-1-24.
//  Copyright (c) 2015年 luoye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponseData.h"
#import "BabyInfoModel.h"

#define kUserInfo [UserInfoEntity sharedInstance]

@interface UserInfoEntity : HttpResponseData


/***  用户状态 1:我怀孕了 2:家有宝贝*/
@property (nonatomic, assign) kUserState status;
/***  用户生日*/
@property (nonatomic, copy) NSNumber *age;
/***  头像 */
@property(nonatomic, strong)PhotoModel *avatar;
/***  用户 ID*/
@property (nonatomic, assign) NSInteger Id;
/***  分娩 */
@property (nonatomic, assign) NSInteger delivery;
/***  预产期 */
@property (nonatomic, assign) NSTimeInterval dueDate;
/***  预产期字符串  未登陆用户用 */
@property (nonatomic, copy) NSString *dueDateStr;
/***  用户类型  1:注册用户,2:会员用户*/
@property (nonatomic, assign) kUserType userType;
/***  用户居住地*/
@property (nonatomic, copy) NSString *residence;
/***  医院名称*/
@property (nonatomic, copy) NSString * hospitalName;
/***  用户昵称*/
@property (nonatomic, copy) NSString *nickname;
/***  用户末次月经*/
@property (nonatomic, copy) NSNumber * lastMenses;
/***  服务器当前 currentTime 选填 时间*/
@property (nonatomic, copy) NSNumber * currentTime;

/**
 *  头像（2进制文件）
 */
@property (nonatomic, copy) NSData *avatarData;

/***  高危信号值 */
@property (nonatomic, strong) NSNumber * hasWarn;

@property (nonatomic, copy) NSString *hospitalId;

// --- baby
/***  宝贝*/
@property (nonatomic, strong) BabyInfoModel *currentBaby;

/***  宝贝*/
@property (nonatomic, strong) NSArray <BabyInfoModel>*babys;

@property(nonatomic, copy)NSString *token;   // 用户token
@property(nonatomic, copy)NSString *phone;     // 电话
@property(nonatomic, assign)NSInteger unreadCount;  // 未读消息数目总数

+ (instancetype)sharedInstance;

//同步、存储用户信息
- (void)synchronize;

//是否已登录
- (BOOL)isLogined;

//退出用户
- (void)exitUser;

/**
 *  登陆失效
 */
- (void)userTokenFailure;

// 将用户信息存到单例
+ (void)syncUserInfo:(UserInfoEntity *)data;

- (void)updateUserInfo;

- (void)setUserUnreadCount:(NSInteger)unreadCount;

#pragma mark - 数据

//- (NSString *)getLastgetMensesDate;

/***  存储医院Id */
+ (void)saveHospitalInfo:(id)arr;
+ (id)hospitalInfo;

@end
