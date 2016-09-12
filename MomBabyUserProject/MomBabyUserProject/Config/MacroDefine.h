//
//  MacroDefine.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/4.
//  Copyright © 2016年 iMac. All rights reserved.
//

#pragma mark - 网络相关

//当都为0时，表示编译DEBUG模式
#define Builing_Release_AppStore 0  //build appstore version if 1

//配置服务器地址
#if Builing_Release_AppStore

#define kServerBaseUrl @"http://member.api.healthbaby.com.cn"
#define kHighRiskHTMLURL @"http://page.healthbaby.com.cn/v1/risklist?labelTitle=高危等级&hospitalId={{hospitalId}}" // 高危页面
#define kCurrentDoctorHTMLURL @"http://page.healthbaby.com.cn/v1/doctorDetail?labelTitle=专家介绍&id={{doctorId}}&hospitalId={{hospitalId}}" // 当前产检医生
// 获协议
#define kGetProtocol @"http://m.healthbaby.com.cn/protocal/protocal-user.html"

#else

// ---- test18833981263
#define kServerBaseUrl @"http://member.api.stage.healthbaby.com.cn"
#define kHighRiskHTMLURL @"http://page.stage.healthbaby.com.cn/v1/risklist?labelTitle=高危等级&hospitalId={{hospitalId}}" // 高危页面
#define kCurrentDoctorHTMLURL @"http://page.stage.healthbaby.com.cn/v1/doctorDetail?labelTitle=专家介绍&id={{doctorId}}&hospitalId={{hospitalId}}" // 当前产检医生
// 获取协议
#define kGetProtocol @"http://m.stage.healthbaby.com.cn/protocal/protocal-user.html"
#endif

#define kShareUrl @"https://itunes.apple.com/us/app/ma-mi-baby/id1072814144?l=zh&ls=1&mt=8"

// 妈咪类型时间
#define kUserStateMomDays 293
#define kUserStateBabyDays 365 * 6

// 网络超时
#define kNetWorkRequestTimeOut  (10)

// 本地储存的当前版本信息
#define locationVersion 200

//网络内存缓存
#define kNetWorkDataMemoryCache (5 * 1024 * 1024)

//网络DISK缓存
#define kNetWorkDataDiskCache   (5 * 1024 * 1024)
// 请求数据的时候加载条数
#define kRequestDataCount   30

#pragma mark - 界面相关
// 获取屏幕 宽度、高度
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

// 常见颜色
#define kColorWhite [UIColor whiteColor]
#define kColorBlack [UIColor blackColor]
#define kColorClear [UIColor clearColor]
#define kColorBlue  [UIColor blueColor]

#define kColorGreen ColorWithRGBA(54,187,173,1)
#define kColorDarkGray ColorWithRGBA(102,102,102,1)
#define kColorTextGray [UIColor colorFromHexRGB:@"979797"]
#define kColorBorderLine [UIColor colorFromHexRGB:@"f7f7f7"]
#define kColorLineGray [UIColor colorWithRed:231 / 255.0 green:229 / 255.0 blue:223 / 255.0 alpha:1.0]
#define kColorLineDarkGray [UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:208 / 255.0 alpha:1.0]
#define kColorLightGray [UIColor colorFromHexRGB:@"999999"]
#define kColorFontBlack [UIColor colorFromHexRGB:@"333333"]

// 登陆注册光标颜色
#define kColorTint [UIColor colorFromHexRGB:@"00fff0"]
// 页面背景色
#define kColorBackground [UIColor colorFromHexRGB:@"E4E4E4"]
// 主题色
#define kColorTheme [UIColor colorFromHexRGB:@"ff7866"]
#define kColorDefaultWhite [UIColor colorFromHexRGB:@"ffffff"]
// 部分页面的黄色底色
#define kColorYellowBGC [UIColor colorFromHexRGB:@"fffef2"]
// 蒙版的颜色
#define kColorMask ColorWithRGBA(22,30,30,.2f)
// 重点文字的红色
#define kColorKeyRed [UIColor colorFromHexRGB:@"ff717f"]
//Font
#define SystemFont(size) [UIFont systemFontOfSize:size]
#define SystemBoldFont(size) [UIFont boldSystemFontOfSize:size]

//#define kFontH1 SystemFont(12)
//#define kFontH2 SystemFont(13)
//#define kFontH3 SystemFont(14)
//#define kFontH4 SystemFont(15)
//#define kFontH5 SystemFont(20)
//#define kFontH6 SystemFont(16)
//#define kFontH7 SystemFont(17)
//#define kFontH8 SystemFont(10)

// ------------ 北京那边的标注  ---------------

#define UIFONT_H7_10 [UIFont systemFontOfSize:10]
#define UIFONT_H1_12 [UIFont systemFontOfSize:12]
#define UIFONT_H2_13 [UIFont systemFontOfSize:13]
#define UIFONT_H3_14 [UIFont systemFontOfSize:14]
#define UIFONT_H4_15 [UIFont systemFontOfSize:15]
#define UIFONT_H5_20 [UIFont systemFontOfSize:20]
#define UIFONT_H6_16 [UIFont systemFontOfSize:16]
#define UIFONT_H7_17 [UIFont systemFontOfSize:17]
#define UIFONT_H8_18 [UIFont systemFontOfSize:18]

#define COLOR_C1 [UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1.0]
#define COLOR_C2 [UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0]
#define COLOR_C3 [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1.0]
#define COLOR_C4 [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0]
#define COLOR_C5 [UIColor colorWithRed:245 / 255.0 green:114 / 255.0 blue:139 / 255.0 alpha:1.0]
#define COLOR_LINE [UIColor colorWithRed:231 / 255.0 green:229 / 255.0 blue:223 / 255.0 alpha:1.0]
#define COLOR_LINE_DARK [UIColor colorWithRed:210 / 255.0 green:210 / 255.0 blue:208 / 255.0 alpha:1.0]

// ------------ 北京那边的标注  ---------------


#define kAnmaitionDuration .4f // 间隔
#define kTabLeftMargin 15 // 间隔
#define kMargin 10 //间隔
#define kBtnWidth 30 //按钮宽


//定义UIImage对象
#define ImageNamed(imageName) [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]

#define kDefalutAvatar ImageNamed(@"defaultIcon")

//读取本地图片
#define LoadImage(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:nil]]

#define DocumentsFilepath [NSHomeDirectory() stringByAppendingString:@"/Documents/"]
// 获取RGB颜色
#define ColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define ColorWithRGB(r,g,b) ColorWithRGBA(r,g,b,1.0f)
#define ClearBackgroundColor(view) (view.backgroundColor = [UIColor clearColor])
//
#define HexColor(x)             [UIColor colorWithRed:((float)(((x) & 0xFF0000) >> 16))/255.0f \
green:((float)(((x) & 0xFF00) >> 8))/255.0f \
blue:((float)((x) & 0xFF))/255.0f \
alpha:1.0f]


#pragma mark - 工具


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//IOS系统版本(doubel)
#define SystemVersion ([[UIDevice currentDevice].systemVersion floatValue])

#define kAppDelegate ((AppDelegate*)[[UIApplication sharedApplication]delegate])

//主线程
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//后台线程
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

//Break,Return
#define BreakIf(x)  if(x)break
#define ContinueIf(x)   if(x)continue
#define ReturnIf(x) if(x)return

//weakSelf
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//DEBUG模式下打印日志
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DLog(...)
#endif

// appkey

#define AppKey_UMeng @"56d020a467e58efe9a000f68"
#define AppKey_JPush @"7f6970713b9ec5e379a54578"
#define AppKey_AppStore @""
#define AppKey_WX @"wxf722f07869b50708"
#define AppKey_QQ @"61PRDDl4puWeNoPb"
#define AppId_QQ @"1105017471"
#define AppSecret_WX @"6e8e0a56d4f9fbea14e0ce6f6f5eec7b"


//Block
typedef void(^VoidBlock)();
typedef BOOL(^BoolBlock)();
typedef int (^IntBlock) ();
typedef id  (^IDBlock)  ();

typedef void(^VoidBlock_int)(int);
typedef BOOL(^BoolBlock_int)(int);
typedef int (^IntBlock_int) (int);
typedef id  (^IDBlock_int)  (int);

typedef void(^VoidBlock_string)(NSString*);
typedef BOOL(^BoolBlock_string)(NSString*);
typedef int (^IntBlock_string) (NSString*);
typedef id  (^IDBlock_string)  (NSString*);

typedef void(^VoidBlock_id)(id);
typedef BOOL(^BoolBlock_id)(id);
typedef int (^IntBlock_id) (id);
typedef id  (^IDBlock_id)  (id);

