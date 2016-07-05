//
//  MessageFrame.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "SystemMessageFrame.h"
#import "SystemMessage.h"
//  部的cell高度
#define bottomRowHeight 25

@implementation SystemMessageFrame

- (void)setMessage:(SystemMessage *)message {
    
    _message = message;
    
    // 0、获取屏幕宽度
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    // 1、计算时间的位置
    if (_showTime){
        
        CGFloat timeY = 23;
        CGSize timeSize = [_message.time sizeWithAttributes:@{NSFontAttributeName:SystemFont(13)}];
        CGFloat timeX = (screenW - timeSize.width) / 2;
        _timeF = CGRectMake(timeX, timeY, timeSize.width + kTimeMarginW, 20);
    }
    
    // 3、计算内容位置
    CGFloat contentX = kTabLeftMargin;
    CGFloat contentY = CGRectGetMaxY(_timeF) + kMargin;
    CGSize contentSize = [message.content boundingRectWithSize:CGSizeMake(screenW - kTabLeftMargin * 4, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:kContentFont} context:nil].size;
    
    
    _contentF = CGRectMake(contentX, contentY, screenW - kTabLeftMargin * 2, contentSize.height + kMargin);

    // 4、计算高度
    _cellHeight = _contentF.size.height + contentY + 44 + kMargin ;
}

@end
