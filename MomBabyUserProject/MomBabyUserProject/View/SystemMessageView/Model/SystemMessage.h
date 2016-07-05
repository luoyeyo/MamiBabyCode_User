//
//  Message.h
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpResponseData.h"

typedef enum {
    
    MessageTypeSystem = 1, // 系统消息
    MessageTypeCrisis = 2, // 通知消息
    
} MessageType;

@protocol SystemMessage <NSObject>

@end

@interface SystemMessage : HttpResponseData
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSTimeInterval created;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageType type;
@end

@interface SystemMessageList : HttpResponseData
@property (nonatomic, assign) NSArray<SystemMessage> *list;
@end
