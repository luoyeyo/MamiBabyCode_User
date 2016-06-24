//
//  SystemsMCell.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "MessageTitleCell.h"

@implementation MessageTitleCell

+ (instancetype )defaultClassNameNibViewWithFrame:(CGRect)frame
{
    NSArray *views = [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil];
    for (MessageTitleCell *view in views) {
        if ([view isMemberOfClass:[self class]]) {
            view.frame = frame;
            view.backgroundColor = [UIColor clearColor];
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kTabLeftMargin, 41, ScreenWidth - kTabLeftMargin * 4, 0.5)];
            line.backgroundColor = kColorLineGray;
            [view.contentView addSubview:line];
            return view;
        }
    }
    NSAssert(NO, @"Expect file: %@", [NSString stringWithFormat:@"%@.xib", NSStringFromClass([self class])]);
    return nil;
}

- (void)drawRect:(CGRect)rect {
    
}

- (void)setType:(MessageType)type {
    _type = type;
    if (_type == MessageTypeSystem) {
        self.titleLabel.text = @"系统消息";
        self.icon.image = ImageNamed(@"page11_icon_news");
    } else {
        self.titleLabel.text = @"接种通知";
        self.icon.image = ImageNamed(@"page11_icon_vaccine");
    }
}

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
