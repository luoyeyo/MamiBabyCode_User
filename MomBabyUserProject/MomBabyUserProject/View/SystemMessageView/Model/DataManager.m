//
//  APNSModel.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/28.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "DataManager.h"
//#import "Home_Manager.h"

@implementation DataManager

/**
 *  创建数据表
 */
+ (void)createDefaultTable {
    // 创建系统消息表 SQLTableKeyMessage 聊天 一个主键id 一个message的二进制文件  一个 消息时间
    [kBaseSQL executeUpdate:[NSString stringWithFormat:@"CREATE TABLE %@ (%@ integer NOT NULL PRIMARY KEY AUTOINCREMENT,%@ blob,%@ text);",SQLTableName,SQLTablePrimaryKey,SQLTableKeyMessage,SQLTableKeyMessageTime]];
    // 创建存放未读数目的角标 ( 未读数目  和   当前用户名)
    // 存放一些用户数据的表  SQLTableKeyUid 用户的id   SQLTableKeyNotiTime 最后一次推送时间
    [kSQLTool DataBase:kBaseSQL createTable:SQLTableUserInfo keyTypes:@{SQLTableKeyUid:@"text",SQLTableKeyNotiTime:@"integer"}];
    
    // 第一次登陆的时候  插入当前时间作为推送时间
    NSNumber *current = @((long long int)[[NSDate date] timeIntervalSince1970]);
    // 查询当前用户id的表在不在  不在就创建此id的表
    NSArray *arr = [kSQLTool DataBase:kBaseSQL selectKeyTypes:@{SQLTableKeyNotiTime:@"text"} fromTable:SQLTableUserInfo whereCondition:@{SQLTableKeyUid:SQLTableName}];
    if (arr.count == 0) {
        [kSQLTool DataBase:kBaseSQL insertKeyValues:@{SQLTableKeyUid:SQLTableName,SQLTableKeyNotiTime:current} intoTable:SQLTableUserInfo];
    }
}

+ (void)didReceiveRemoteNotification {
    Input_params *params = [[Input_params alloc] init];
    params.time = [NSString stringWithFormat:@"%@",@([DataManager getLastNotiTime])];
    // 收到消息  直接刷新列表
//    [kShareManager_Vaccinate getNotiMessageWith:params responseBlock:^(LLError *error) {
//        
//    }];
}

+ (void)updateLastReceiveMessageTime {
    // 收到推送时 更新数据库中的最后收到通知时间
    NSNumber *current = @((long long int)[[NSDate date] timeIntervalSince1970]);
    // 更新当前医生id对应lasttime
    NSString *dqlStr = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE %@ = ?",SQLTableUserInfo,SQLTableKeyNotiTime,SQLTableKeyUid];
    [kBaseSQL executeUpdate:dqlStr,current,SQLTableName];
}

+ (long long int)getLastNotiTime {
    NSArray *arr = [kSQLTool DataBase:kBaseSQL selectKeyTypes:@{SQLTableKeyNotiTime:@"integer"} fromTable:SQLTableUserInfo whereCondition:@{SQLTableKeyUid:SQLTableName}];
    if (arr.count == 0) {
        // 如果没有 就查看一个小时前的
        NSTimeInterval time = (long long int)[[NSDate date] timeIntervalSince1970];
        return time - 3600;
    }
    return [[[[arr lastObject] allObjects] lastObject] longLongValue];
}

+ (void)saveMessage:(NSArray *)list {
    
    for (NSDictionary *dic in [[list reverseObjectEnumerator] allObjects]) {
//        SystemMessage *mess = [[SystemMessage alloc] initWithDictionary:dic error:nil];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
//        NSString *date = [NSDate dateStringWithTimeInterval:mess.created formatterStr:@"YYYY-MM-dd HH:mm:ss"];
        [kSQLTool DataBase:kBaseSQL insertKeyValues:@{SQLTableKeyMessage:data} intoTable:SQLTableName];
    }
    // 保存count
//    [self updateUnreadSystemMessageCountWithCount:sysCount];
    [kUserInfo setUserUnreadCount:1];
}

+ (NSArray *)getMessageWithLastId:(NSInteger)index {
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT %@,%@ FROM %@ WHERE %@ < ? AND %@ > ? LIMIT 10",SQLTableKeyMessage,SQLTablePrimaryKey,SQLTableName,SQLTablePrimaryKey,SQLTablePrimaryKey];
    FMResultSet *result = [kBaseSQL executeQuery:sqlStr,@(index),@(index - 11)];
    return [kSQLTool getArrWithFMResultSet:result keyTypes:@{SQLTableKeyMessage:@"blob",SQLTablePrimaryKey:@"integer"}];
}

+ (NSArray *)descSelect {
    NSString *sqlStr = [NSString stringWithFormat:@"SELECT %@,%@ FROM %@ ORDER BY %@ DESC LIMIT 10",SQLTablePrimaryKey,SQLTableKeyMessage,SQLTableName,SQLTablePrimaryKey];
    FMResultSet *result = [kBaseSQL executeQuery:sqlStr];
    return [kSQLTool getArrWithFMResultSet:result keyTypes:@{SQLTableKeyMessage:@"blob",SQLTablePrimaryKey:@"integer"}];
}

+ (void)updateStateWithRow:(NSInteger)index message:(SystemMessage *)message {
    NSDictionary *dic = [NSDictionary dictionaryFromPropertyObject:message];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    // 更新主键对应的数据
    NSString *dqlStr = [NSString stringWithFormat:@"UPDATE %@ SET %@ = ? WHERE %@ = ?",SQLTableName,SQLTableKeyMessage,SQLTablePrimaryKey];
    [kBaseSQL executeUpdate:dqlStr,data,@(index)];
}

#pragma mark - plist数据处理

+ (NSArray *)getBabyHeightAndWeight {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"babyHeightAndKg" ofType:@"plist"];
    NSArray * babyInfo = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in babyInfo) {
        HeightAndWeightModel *model = [[HeightAndWeightModel alloc] initWithDictionary:dic error:nil];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getBoyHeightAndWeight {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"BoyWeightAndHeight" ofType:@"plist"];
    NSArray * babyInfo = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in babyInfo) {
        HeightAndWeightRange *model = [[HeightAndWeightRange alloc] initWithDictionary:dic error:nil];
        [array addObject:model];
    }
    return array;
}

+ (NSArray *)getGirlHeightAndWeight {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GirlWeightAndHeight" ofType:@"plist"];
    NSArray * babyInfo = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in babyInfo) {
        HeightAndWeightRange *model = [[HeightAndWeightRange alloc] initWithDictionary:dic error:nil];
        [array addObject:model];
    }
    return array;
}

@end
