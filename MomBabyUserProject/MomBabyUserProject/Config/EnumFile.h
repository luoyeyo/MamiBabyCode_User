//
//  EnumFile.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/6.
//  Copyright © 2016年 iMac. All rights reserved.
//
typedef NS_ENUM(NSInteger, kHttpReturnCode)
{
    kHttpReturnCodeSuccess = 0,             // 成功
    kHttpReturnCodeFail = 4001,             // 请求失败
    kHttpReturnCodeTokenFailure = 4002,             // token失效
    kHttpReturnCodeNoData = 4097,             // 数据不存在
    kHttpReturnCodeErrorNotLogin = -5,      // 未登录
    kHttpReturnCodeErrorNet = 404,           // 网络连接失败,
    kHttpReturnCodeErrorNetFailed = -1011,           // 网络连接失败,
};

// 工作台 分组id
typedef NS_ENUM(NSInteger, kGroupType)
{
    kGroupTypePending = 5, // 待处理
    kGroupTypeRisk = 2, // 高危
    kGroupTypeCrisis = 1,  // 危机
    kGroupTypeImportant = 3,  // 重点关注
    kGroupTypeAll = 6,  // 全部
};

/**
 *  危险等级
 */
typedef NS_ENUM(NSInteger, CriticalLevel) {
    /**
     *  高危
     */
    kCriticalLevelHighRish = 1,
    /**
     *  危急
     */
    kCriticalLevelCritical = 2,
};

#define kSolveDetailTypeArray @[@"-",@"未处理",@"处理中",@"其他",@"已恢复",@"已转院"]
/**
 *  处理结果类型
 */
typedef NS_ENUM(NSInteger,kSolveDetailType) {
    /**
     *  进行中
     */
    kSolveTypeProcess = 2,
    /**
     *  恢复
     */
    kSolveTypeRestore = 4,
    /**
     *  转院
     */
    kSolveTypeTransfers = 5,
    /**
     *  其他
     */
    kSolveTypeOthers = 3,
    /**
     *  未处理
     */
    kSolveTypeNot = 1,
};

/**
 *  处理结果类型 (对应2进制)
 */
typedef NS_ENUM(NSInteger,HighRiskLevelColor) {
    /**
     *  无
     */
    kHighRiskLevelNone = 16,
    /**
     *
     */
    kHighRiskLevelColorYellow = 2,
    /**
     *
     */
    kHighRiskLevelColorOrange = 1,
    /**
     *
     */
    kHighRiskLevelColorPurple = 4,
    /**
     *  
     */
    kHighRiskLevelColorRed = 8,
};

/**
 *  接种计划类型  （全部都有优先显示  全部  否则只显示有的）
 */
typedef NS_ENUM(NSInteger,kInoculatePlanType) {
    /**
     *  只有免费类型
     */
    kInoculatePlanTypeFree = 1,
    /**
     *  只有收费类型
     */
    kInoculatePlanTypeCharge = 2,
    /**
     *  全部都有
     */
    kInoculatePlanTypeAll = 3,
    /**
     *  全部都没有
     */
    kInoculatePlanTypeNone = 4,
};

/**
 *  性别
 */
typedef NS_ENUM(NSInteger,kBabySex) {
    /**
     *  女
     */
    kBabySexGirl = 0,
    /**
     *  男
     */
    kBabySexBoy = 1,
};

/**
 *  用户状态
 */
typedef NS_ENUM(NSInteger,kUserState) {
    /**
     *  没有信息
     */
    kUserStateNo = 0,
    /**
     *  孕期（妈妈）
     */
    kUserStateMum = 1,
    /**
     *  已有宝宝（儿童）
     */
    kUserStateChild = 2,
};

/**
 *  预产期类型
 */
typedef NS_ENUM(NSInteger,DueDateType) {
    /**
     *  预产期
     */
    kDueDateTypeDueDate = 1,
    /**
     *  末次月经
     */
    kDueDateTypeLastMens = 2,
};

/**
 *  用户类型
 */
typedef NS_ENUM(NSInteger,kUserType) {
    /**
     *  普通用户
     */
    kUserTypeNormal = 1,
    /**
     *  会员用户
     */
    kUserTypeVIP = 2,
};

