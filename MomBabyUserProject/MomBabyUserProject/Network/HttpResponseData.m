//
//  HttpData.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/15.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HttpResponseData.h"
#import <objc/runtime.h>

@implementation AppVersion
@end

@implementation PageInfoModel

@end

@implementation HttpResponseData

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        unsigned int count = 0;
        //获取类中所有成员变量名
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            //进行解档取值
            id value = [aDecoder decodeObjectForKey:strName];
            if (value) {
                //利用KVC对属性赋值
                [self setValue:value forKey:strName];
            }
        }
        free(ivar);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

/*这里保证了JSON里的属性是可选择的
 也就是Model中属性多了，少了都无所谓
 当用字典给模型赋值时，JSONModel总能找到一一对应得关系
 例如： JSON中 有键 hell0_word  username password   而 模型中 只有 username password
 那么自动赋值时，就自会把username  password对应的键赋值，而这种情况无法采用KVC。
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

/**
 *  关键字修改
 *
 *  @return 
 */
+ (JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"Id",@"template":@"Template",@"description":@"Description",@"newInoculateTime":@"NewInoculateTime"}];
}

@end

@implementation LLError

+ (LLError *)errorWithErrorCode:(NSInteger)code message:(NSString *)message {
    LLError *error = [[LLError alloc] init];
    error.errorcode = code;
    error.errormsg = message;
    if (code == kHttpReturnCodeErrorNet) {
        error.errormsg = @"服务器连接失败";
    }
    if (code == kHttpReturnCodeErrorNetFailed) {
        error.errormsg = @"服务器连接失败";
    }
    return error;
}

@end

@implementation PhotoModel


@end
