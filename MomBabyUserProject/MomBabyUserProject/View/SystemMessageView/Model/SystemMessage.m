//
//  Message.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "SystemMessage.h"

@implementation SystemMessage

- (NSString *)time {
    if (!_time) {
        ReturnIf(self.created == 0) nil;
        _time = [NSDate formattedTimeFromTimeInterval:self.created];
    }
    return _time;
}

@end

@implementation SystemMessageList

@end