//
//  ApiFile.h
//  DoctorProject
//
//  Created by shaofenghan on 16/1/18.
//  Copyright © 2016年 iMac. All rights reserved.
//

#pragma mark - login

// 版本查询
static NSString *const kApiVersion = @"v1/iosConfigs";
// login
static NSString *const kApiLogin = @"v2/tokens";
// 获取验证码
static NSString *const kApiGetVerify = @"v2/authCode";
/**
 *  注册
 */
static NSString *const kApiRegister = @"v1/register";
// 用户信息
static NSString *const kApiGetUserInfo = @"v1/users";
#pragma mark - home

// 首页 妈妈
static NSString *const kApiGetHomeMumInfo = @"v1/categories/pregnancy";
// 获取首页 宝宝
static NSString *const kApiGetHomeBabyInfo = @"v1/categories/kid";

#pragma mark - message

// 获取系统消息
static NSString *const kApiGetNotiMessage = @"v1/notifications";

#pragma mark - mine

// 检验验证码
static NSString *const kApiCheckVerifyCode = @"v1/checkCode";

static NSString *const kApiModifyPhone = @"v1/updatePhone";

static NSString *const kApiModifyMyInfo = @"v1/users";

static NSString *const kApiFeedback = @"v1/feedbacks";
// 获取收藏的文章
static NSString *const kGET_GET_ARTICLES = @"v1/articles/favorite";

// 获取7牛token
static NSString *const kApiQiNiuImageToken = @"v1/tokens/qiniu";

// 客户端请求后台获取孕期产检信息
static NSString *const kGET_PREGNANCY_DELIVERY = @"v1/appointments/pregnancy";
// 客户端请求后台获取孕期产检信息
static NSString *const kGET_KID_DELIVERY = @"v1/appointments/kid";
// 查询用户高危信息列表
static NSString *const kGET_HIGHRISHLIST = @"v1/riskGuide";
// 获取医院图片
static NSString *const kGET_hospitalsImages = @"v1/hospitalsImages";
// 获取医院信息
static NSString *const kGET_HospitalsInfo = @"v1/hospitals";
// 获取医院列表
static NSString *const kGET_HospitalsList = @"v1/hospitals/position";



// ----- 发现

// 客户端请求后台获取文章
static NSString *const kGET_ARTICLES = @"v1/articles";

/**
 *  客户端请求后台获取文章详情 URL:/articles/:id
 */
static NSString *const kGET_ARTICLES_DETAILS = @"v1/articles";

/**
 *  客户端请求后台收藏文章 URL:/articles/:id/favorite
 */
static NSString *const kPOST_COLLECT_ARTICLES = @"v1/articles/articlesId/favorite";

/**
 *  客户端请求后台取消收藏文章 URL:/articles/:id
 */
static NSString *const kDELETE_DELETE_ARTICLES = @"v1/articles/favorite";

/**
 *  客户端请求后台点赞 URL:/articles/:id
 */
static NSString *const kPOST_LIKE_ARTICLES = @"v1/articleLike";

/**
 *  客户端请求后台取消点赞 URL:/articles/:id
 */
static NSString *const kDELETE_LIKE_ARTICLES = @"v1/offArticleLike/:id";

/**
 *  客户端请求后台获取子栏目
 */
static NSString *const kGET_DISCOVERY_ITEM = @"v1/categories/item";

/**
 *  客户端请求获取食物信息
 */
static NSString *const kGET_FOODSINFO = @"v1/foods";

/**
 *  客户端请求后台获取营养信息
 */
static NSString *const kGET_NUTRITIONS = @"v1/foods/nutritions";

/**
 *  客户端请求获取食物信息
 */
static NSString *const kGET_FOODLIST = @"v1/foods/categories";


// 客户端请求后台获取孕期发现页栏目
static NSString *const kGET_MOM_DISCOVERY = @"v1/categories/pregnancy/discovery";
// 客户端请求后台获取育儿发现页栏目
static NSString *const kGET_KID_DISCOVERY = @"v1/categories/kid/discovery";



