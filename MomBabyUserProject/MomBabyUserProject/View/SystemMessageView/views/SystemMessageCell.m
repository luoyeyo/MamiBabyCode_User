//
//  MessageCell.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "SystemMessageCell.h"
#import "SystemMessage.h"
#import "SystemMessageFrame.h"
#import "MessageTitleCell.h"

@interface SystemMessageCell ()
{
    UIButton     *_timeBtn;
    UILabel    *_contentLabel;
}

@property (nonatomic, strong) UIButton *baseView;
@property (nonatomic, strong) MessageTitleCell *titleView;

@end

@implementation SystemMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 1、创建时间按钮
        _timeBtn = [[UIButton alloc] init];
        [_timeBtn setTitleColor:kColorWhite forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = kTimeFont;
        _timeBtn.enabled = NO;
        _timeBtn.backgroundColor = [UIColor colorFromHexRGB:@"bcb7b7"];
        [self.contentView addSubview:_timeBtn];
        
        [self.contentView addSubview:self.baseView];
        [self.baseView addSubview:self.titleView];
        // 3、创建内容
        _contentLabel = [[UILabel alloc] init];

        _contentLabel.font = UIFONT_H3_14;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = kColorTextGray;
        
        self.contentView.backgroundColor = [UIColor colorFromHexRGB:@"e4dfdf"];
    }
    return self;
}

- (void)setMessageFrame:(SystemMessageFrame *)messageFrame{
    
    _messageFrame = messageFrame;
    SystemMessage *message = _messageFrame.message;
    
    // 1、设置时间
    [_timeBtn setTitle:message.time forState:UIControlStateNormal];

    _timeBtn.frame = _messageFrame.timeF;
    _timeBtn.layer.cornerRadius = _timeBtn.height / 2;
    // 2、设置内容
    self.titleView.type = message.type;

    _contentLabel.text = message.content;
    _contentLabel.frame = CGRectMake(_messageFrame.contentF.origin.x, CGRectGetMaxY(self.titleView.frame) , _messageFrame.contentF.size.width - 12 * 2, _messageFrame.contentF.size.height + kMargin);
    [self.baseView addSubview:_contentLabel];
    // 4. 底层view
    self.baseView.frame = _messageFrame.contentF;
    self.baseView.height = _messageFrame.cellHeight - CGRectGetMaxY(_timeBtn.frame) - 10;
}

- (MessageTitleCell *)titleView {
    if (_titleView == nil) {
        _titleView = [MessageTitleCell defaultClassNameNibViewWithFrame:CGRectMake(0, 0, ScreenWidth - 20, 42)];
        _titleView.userInteractionEnabled = NO;
    }
    return _titleView;
}

-(UIView *)baseView {
    if (_baseView == nil) {
        _baseView = [UIButton buttonWithType:UIButtonTypeSystem];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.cornerRadius = 5;
        _baseView.clipsToBounds = YES;
        [_baseView setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.9451 green:0.9255 blue:0.9255 alpha:0.7]] forState:UIControlStateHighlighted];
    }
    return _baseView;
}

@end
