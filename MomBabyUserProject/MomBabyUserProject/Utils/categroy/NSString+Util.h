//
//  NSString+Util.h
//  BaseProject
//
//  Created by wangzhi on 15-1-24.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface AttributeStringAttrs : NSObject
@property(nonatomic, strong)NSString *text;
@property(nonatomic, strong)UIFont *font;
@property(nonatomic, strong)UIColor *textColor;
@end

//常用日期格式
static NSString *const WZDateStringFormat1 = @"EEE, dd MM yyyy HH:mm:ss zzz";
static NSString *const WZDateStringFormat2 = @"yyyy年MM月dd日";
static NSString *const WZDateStringFormat3 = @"MM月dd日";
static NSString *const WZDateStringFormat4 = @"MM月dd日 ahh:mm";
static NSString *const WZDateStringFormat5 = @"yyyy-MM-dd";
static NSString *const WZDateStringFormat6 = @"yyyy-MM";

@interface NSString (Util)

/**
 *  从本地化文件（Localizable.strings）中读取字符串
 *
 *  @param key 本地化文件中的Key值
 *
 *  @return 本地化的字符串,如果值为空，则返回Key，如果Key为空，则返回空串
 */
+ (NSString*)localStringForKey:(NSString *)key;


/**
 *  从本地化文件（Localizable.strings）中读取字符串
 *
 *  @param key 本地化文件中的Key值
 *  @param comment 注释
 *
 *  @return 本地化的字符串
 */
+ (NSString*)localStringForKey:(NSString *)key comment:(NSString *)comment;

/**
 *  从本地化文件（table）中读取字符串
 *
 *  @param key 本地化文件中的Key值
 *  @param comment 注释
 *  @param table 本地化文件名
 *
 *  @return 本地化的字符串
 */
+ (NSString*)localStringForKey:(NSString *)key comment:(NSString *)comment table:(NSString *)table;

//不分大小写比较
- (BOOL)insensitiveCompare:(NSString*)str;

// 判断是空字符串 返回yes  否则no
+ (BOOL)isEmptyString:(NSString *)str;

// 获取Documents路径 Documents
+ (NSString *)documentPath;

// 获取缓存路径 Library/Caches
+ (NSString *)cachePath;

// 已定义好的图片路径， Library/Caches/Images
+ (NSString *)imageCachePath;

// 是否是合法邮箱
- (BOOL)isValidEmail;

// 是否是合法手机号码 YES 是合法的  NO  不是
- (BOOL)isValidPhoneNumber;

// 是否是合法的18位身份证号码
- (BOOL)isValidPersonID;

//是否合法的密码字符，如果合法则返回空，否则返回错误原因信息
- (NSString*)isValidPassword;

//是否合法的备注名
- (BOOL)isValidNickname;

//是否是有效的数字
- (BOOL)isValidNumber;

- (BOOL)isPureFloat;

- (BOOL)isPureInt;

- (BOOL)ios7IsContainsString:(NSString *)str;

- (BOOL)isPureNumber;

// 根据文件名返回路径
+ (NSString *)pathWithFileName:(NSString *)fileName;

//返回整形串
+ (NSString *)intStr:(NSInteger)intValue;

/**
 *  配置属性文字
 *
 *  @param attrArray 数组中存放AttributeStringAttrs对象
 *
 *  @return 
 */
+ (NSAttributedString *)makeAttrString:(NSArray*)attrArray;

#if 0
- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

-(CGSize)sizeWithFont:(UIFont *)font;

- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment;

- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font;

#endif

#pragma mark - MD5

- (NSString *)md5Encrypt;

@end

#pragma mark - APP相关信息

@interface NSString (AppInfo)
+ (NSString*)appVersion;
+ (NSString*)appBundleVersion;
+ (NSString*)appBundleId;
@end

#pragma mark - Date显示相关

@interface NSString (DateFormat)
/**
 * 将NSDate转为时间戳（毫秒）
 * @param date 时间对象
 * @return 时间戳字符串
 ***/
+ (NSString*)timeInterval:(NSDate*)date;

/**
 * 将时间戳（毫秒）解析成formater指定的时间格式
 * @param timeVal 时间戳（毫秒）
 * @param formater 格式对象
 * @return 格式化后的字符串
 ***/
+ (NSString *)dateStringWithInterval:(NSTimeInterval)timeVal format:(NSDateFormatter *)formater;

/**
 * 将时间戳（毫秒）解析成formater指定的时间格式
 * @param timeVal 时间戳（毫秒）
 * @param formatStr 格式字符串
 * @return 格式化后的字符串
 * @note 已定义的格式串有:
 *      WZDateStringFormat1 @"EEE, dd MM yyyy HH:mm:ss zzz"
 *      WZDateStringFormat2 @"yy年MM月dd日"
 *      WZDateStringFormat3 @"MM月dd日"
 *      WZDateStringFormat4 @"MM月dd日ahh:mm"
 *      WZDateStringFormat5 @"yyyy-MM-dd"
 *      WZDateStringFormat6 @"yyyy-MM"
 ***/
+ (NSString *)dateStringWithInterval:(NSTimeInterval)timeVal formatStr:(NSString *)formatStr;

/**
 *  通过标示截取字符串
 *
 *  @param c   标示
 *  @param str 字符串
 *
 *  @return 返回截取后组成的数组
 */
+ (NSArray *)checkChar:(NSString *)c oneString:(NSString *)str;
@end


