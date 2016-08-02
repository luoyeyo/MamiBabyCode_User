//
//  NSString+Util.m
//  BaseProject
//
//  Created by wangzhi on 15-1-24.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import "NSString+Util.h"

@implementation AttributeStringAttrs
@end


@implementation NSString (Util)

#pragma mark - Util

- (BOOL)insensitiveCompare:(NSString*)str
{
    return (NSOrderedSame == [self caseInsensitiveCompare:str]);
}

+ (BOOL)isEmptyString:(NSString *)str {
    
    return  str == nil || [str isKindOfClass:[NSNull class]] || ![str isKindOfClass:[NSString class]] || str.length == 0 || [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0 || [str stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0 || [str isEqualToString:@"null"]|| [str isEqualToString:@"(null)"] || [str isEqualToString:@"<null>"];
}

+ (NSString *)localStringForKey:(NSString *)key
{
    return NSLocalizedString(key, nil);
}

+ (NSString *)localStringForKey:(NSString *)key comment:(NSString *)comment
{
    return NSLocalizedString(key, comment);
}

+ (NSString *)localStringForKey:(NSString *)key comment:(NSString *)comment table:(NSString *)table
{
    return NSLocalizedStringFromTable(key, table, comment);
}

+ (NSString *)documentPath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

+ (NSString *)cachePath {
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
}

+ (NSString *)imageCachePath {
    NSString *path = [[self cachePath] stringByAppendingPathComponent:@"Images"];
    BOOL isDir = NO;
    BOOL isDirExist = [[NSFileManager defaultManager] fileExistsAtPath:path
                                                           isDirectory:&isDir];
    if (!isDir && !isDirExist) {
        BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:path
      withIntermediateDirectories:YES
                       attributes:nil
                            error:nil];
        DLog(@"Create ImageCachePath:%@",isSuccess?@"Success":@"Failure");
    }
    return path;
}

+ (NSString *)localShoppingCartPath {
    return [[self cachePath] stringByAppendingPathComponent:@"/cart.plist"];
}

//验证邮箱格式
- (BOOL)isValidEmail {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber {
    ReturnIf(self.length > 11) NO;

    NSString *mobile = @"^1[0-9]+\\d{9}$";
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    return [mobilePredicate evaluateWithObject:self];
}

- (BOOL)ios7IsContainsString:(NSString *)str {
    NSRange range = [self rangeOfString:str];
    return !(range.length == 0);
}

//是否合法的中国公民身份证号
- (BOOL)isValidPersonID {
    // 判断位数
    if (self.length != 15 && self.length != 18) {
        return NO;
    }

    NSString *carid = self;
    long lSumQT = 0;
    // 加权因子
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };
    // 校验码
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};

    //将15位身份证号转换成18位
    NSMutableString *mString = [NSMutableString stringWithString:self];
    if (self.length == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];

        for (int i = 0; i<= 16; i++) {
            p += (pid[i] - 48) * R[i];
        }

        int o = p % 11;
        NSString *string_content = [NSString stringWithFormat:@"%c", sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }

    // 判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }

    // 判断年月日是否有效
    // 年份
    int strYear = [[self substringWithString:carid begin:6 end:4] intValue];
    // 月份
    int strMonth = [[self substringWithString:carid begin:10 end:2] intValue];
    // 日
    int strDay = [[self substringWithString:carid begin:12 end:2] intValue];

    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",
                                                strYear, strMonth, strDay]];
    if (date == nil) {
        return NO;
    }

    const char *PaperId  = [carid UTF8String];
    // 检验长度
    if(18 != strlen(PaperId)) return NO;
    // 校验数字
    for (int i = 0; i < 18; i++) {
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) ) {
            return NO;
        }
    }

    // 验证最末的校验码
    for (int i=0; i<=16; i++) {
        lSumQT += (PaperId[i]-48) * R[i];
    }

    if (sChecker[lSumQT%11] != PaperId[17] ) {
        return NO;
    }
    return YES;
}

/**
 * 功能:判断是否在地区码内
 * 参数:地区码
 */
- (BOOL)areaCode:(NSString *)code {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];

    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
}

//根据文件名返回路径
+ (NSString *)pathWithFileName:(NSString *)fileName {
    return [self pathWithFileName:fileName ofType:nil];
}

+ (NSString *)pathWithFileName:(NSString *)fileName ofType:(NSString *)type {
    return [[NSBundle mainBundle] pathForResource:fileName ofType:type];
}

- (NSString*)isValidPassword{

    NSString *inValidInfo;

    do {
        //密码太短
        if (self.length < 6) {
            inValidInfo = @"请输入6~9位字符";
            break;
        }

        //密码太长
        if (self.length > 9) {
            inValidInfo = @"请输入6~9位字符";
            break;
        }

        // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
        // 必须包含数字和字母，可以包含上述特殊字符。
        // 依次为（如果包含特殊字符）
        // 数字 字母 特殊
        // 字母 数字 特殊
        // 数字 特殊 字母
        // 字母 特殊 数字
        // 特殊 数字 字母
        // 特殊 字母 数字

#if 0   //暂时不做格式检查
        NSString *passWordRegex = @"(\\d+[a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*)|([a-zA-Z]+\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*)|(\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+)|([a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+[a-zA-Z]+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+\\d+)";
        NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
        BOOL formatOk = [passWordPredicate evaluateWithObject:self];
        if (!formatOk) {
            inValidInfo = @"包含了非法字符";
        }
#endif
    } while (0);
    return inValidInfo;
}

- (BOOL)isValidNickname{
    // 不包含特殊字符
    // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
    NSString *nicknameRegex = @".*[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+.*";
    NSPredicate *nicknamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
    return ![nicknamePredicate evaluateWithObject:self];
}

+ (NSString *)countNumAndChangeFormat:(NSString *)num
{
    int count = 0;
    NSRange decimalsRange = [num rangeOfString:@"."];
    NSString *decimals;
    if (decimalsRange.length > 0)
    {
        decimals = [num substringFromIndex:decimalsRange.location];
    }

    long long int a = num.longLongValue;
    NSMutableString *string = [NSMutableString stringWithFormat:@"%lld",a];
    if (a == 0)
    {
        if (decimals)
        {
            return [NSString stringWithFormat:@"%@%@",@"0",decimals];
        }
        else
        {
            return @"0";
        }
    }

    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    if (nil != decimals)
    {
        [newstring appendString:decimals];
    }
    return newstring;
}
/**
 *  int转string
 */
+ (NSString *)intStr:(NSInteger)intValue
{
    return [NSString stringWithFormat:@"%@", @(intValue)];
}

//判断是否为整形
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (BOOL)isValidNumber
{
    NSString *regex = @"^((0)|(0[.][0-9]*)|([1-9]{1}[0-9]*[.]?[0-9]*))$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

- (NSString *)trimming
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isPureNumber
{
    BOOL isPureNum ;
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] trimming].length  > 0)
    {
        isPureNum = NO;
    }
    else
    {
        isPureNum = YES;
    }
    return isPureNum;
}

+ (NSAttributedString *)makeAttrString:(NSArray*)attrArray
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]init];
    NSMutableAttributedString *subAttrStr;
    NSRange attrRange;

    for (AttributeStringAttrs *attrs in attrArray) {
        subAttrStr = [[NSMutableAttributedString alloc]initWithString:attrs.text];
        attrRange = NSMakeRange(0, subAttrStr.length);
        [subAttrStr addAttribute:NSForegroundColorAttributeName value:attrs.textColor range:attrRange];
        [subAttrStr addAttribute:NSFontAttributeName value:attrs.font range:attrRange];

        [attrStr appendAttributedString:subAttrStr];
    }
    return attrStr;
}

/**
 * 功能:获取指定范围的字符串
 * 参数:字符串的开始下标
 * 参数:字符串的结束下标
 */
- (NSString *)substringWithString:(NSString *)str begin:(NSInteger)begin end:(NSInteger )end {
    return [str substringWithRange:NSMakeRange(begin, end)];
}

- (NSString *)md5Encrypt {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];

    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);

    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];

    return [hash lowercaseString];
}

#if 0

-(CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize fitSize = [self boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return fitSize;
}

- (CGSize)sizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineBreakMode = lineBreakMode;
    NSDictionary *attribute = @{NSFontAttributeName:font, NSParagraphStyleAttributeName: paragraph};

    CGSize fitSize = [self boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return fitSize;
}

-(CGSize)sizeWithFont:(UIFont *)font
{
    if (font == nil) {
        font = [UIFont systemFontOfSize:14];
    }
    NSDictionary *attribute = @{NSFontAttributeName:font};
    return [self sizeWithAttributes:attribute];
}

- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode alignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineBreakMode = lineBreakMode;
    paragraph.alignment = alignment;
    NSDictionary *attribute = @{NSFontAttributeName:font, NSParagraphStyleAttributeName: paragraph};

    [self drawInRect:rect withAttributes:attribute];

    return rect.size;
}

- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.lineBreakMode = lineBreakMode;
    NSDictionary *attribute = @{NSFontAttributeName:font, NSParagraphStyleAttributeName: paragraph};

    [self drawInRect:rect withAttributes:attribute];

    return rect.size;
}

- (CGSize)drawInRect:(CGRect)rect withFont:(UIFont *)font
{
    NSDictionary *attribute = @{NSFontAttributeName:font};

    [self drawInRect:rect withAttributes:attribute];

    return rect.size;
}

#endif

@end

#pragma mark - APP相关信息

@implementation NSString (AppInfo)

+ (NSString*)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*)appBundleVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString*)appBundleId
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

@end

#pragma mark - Date显示相关

@implementation NSString (DateFormat)

+ (NSString *)dateStringWithInterval:(NSTimeInterval)timeVal formatStr:(NSString *)formatStr
{
    if (timeVal == 0)
    {
        return nil;
    }
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:formatStr];

    return [[self class]dateStringWithInterval:timeVal format:formater];
}

+ (NSString *)dateStringWithInterval:(NSTimeInterval)timeVal format:(NSDateFormatter *)formater
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeVal/1000];
    NSMutableString *dateStr = [[NSMutableString alloc]init];
    [dateStr setString:[formater stringFromDate:date]];

    NSRange range = NSMakeRange(0, dateStr.length);
    [dateStr replaceOccurrencesOfString:@"PM" withString:@"下午" options:NSCaseInsensitiveSearch range:range];
    [dateStr replaceOccurrencesOfString:@"AM" withString:@"上午" options:NSCaseInsensitiveSearch range:range];

    return dateStr;
}

+ (NSString*)timeInterval:(NSDate*)date
{
    NSTimeInterval timeInterVal = [date timeIntervalSince1970];
    timeInterVal = timeInterVal * 1000;
    return [NSString stringWithFormat:@"%f", timeInterVal];
}

+ (NSArray *)checkChar:(NSString *)c oneString:(NSString *)str {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i ++) {
        NSRange range = [str rangeOfString:c];
        if (range.length == 0) {
            if (str.length != 0) {
                [tempArray addObject:str];
            }
            break;
        }
        NSString *new = [str substringToIndex:range.location];
        str = [str substringFromIndex:range.location + 1];
        [tempArray addObject:new];
    }
    return tempArray;
}


@end
