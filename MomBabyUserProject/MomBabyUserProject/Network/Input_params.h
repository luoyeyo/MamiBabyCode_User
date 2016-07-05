//
//  Input_params.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/1.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  传参对象
 */
@interface Input_params : JSONModel

// id
@property (nonatomic, copy) NSString *Id;
// 
@property (nonatomic, copy) NSString *token;
// 验证码
@property (nonatomic, copy) NSString *code;

// 手机号
@property (nonatomic, copy) NSString *phone;

// --- 上传用户信息

// 预产期
@property (nonatomic, copy) NSString *dueDate;
// 末次月经
@property (nonatomic, copy) NSString *lastMenses;
// 用户状态 kuserstatus
@property (nonatomic, copy) NSNumber *status;

// 怀孕天数 或者是 出生多少天
@property (nonatomic, copy) NSString *days;

// --- baby info

// 宝宝昵称
@property (nonatomic, copy) NSString *babyNickname;
// 性别
@property (nonatomic, copy) NSString *babyGender;
// 性别
@property (nonatomic, copy) NSString *babyBirth;

// ----- 发现

@property (nonatomic, copy) NSString *categoryId;
@property (nonatomic, copy) NSString *type;

// 密码
@property (nonatomic, copy) NSString *password;

// 生日
@property (nonatomic, copy) NSString *birthday;

// 条形码
@property (nonatomic, copy) NSString *barCode;

// 月龄
@property (nonatomic, copy) NSNumber *mouthAge;

#pragma mark - mine

// 头像地址
@property (nonatomic, copy) NSString *avatar;

// 昵称
@property (nonatomic, copy) NSString *nickname;

// 栏目id
@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSNumber *page;
@property (nonatomic, copy) NSNumber *limit;
@property (nonatomic, copy) NSString *hospitalId;


@property (nonatomic, copy) NSNumber *lng;
@property (nonatomic, copy) NSNumber *lat;

@end
