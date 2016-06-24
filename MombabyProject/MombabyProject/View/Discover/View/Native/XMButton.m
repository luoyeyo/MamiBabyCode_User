//
//  XMButton.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/25.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "XMButton.h"

@implementation XMButton


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 上面的文字
        CGFloat topLabelX = 0;
        CGFloat topLabelW = frame.size.width;
        CGFloat topLabelH = 15;
        CGFloat topLabelY = (frame.size.height * 0.5 - topLabelH) * 0.5;
        self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(topLabelX, topLabelY, topLabelW, topLabelH)];
        self.topLabel.font = UIFONT_H2_13;
        self.topLabel.textColor = COLOR_C2;
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.topLabel];
        
        
        // 下面的文字
        CGFloat bottomLabelX = topLabelX;
        CGFloat bottomLabelW = topLabelW;
        CGFloat bottomLabelH = topLabelH;
        CGFloat bottomLabelY = frame.size.height * 0.5 + (frame.size.height * 0.5 - bottomLabelH) * 0.5;
        self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(bottomLabelX, bottomLabelY, bottomLabelW, bottomLabelH)];
        self.bottomLabel.font = UIFONT_H2_13;
        self.bottomLabel.textColor = COLOR_C2;
        self.bottomLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.bottomLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if (selected == YES) {
        
        self.topLabel.textColor = [UIColor whiteColor];
        self.bottomLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        self.topLabel.textColor = COLOR_C2;
        self.bottomLabel.textColor = COLOR_C2;
    }
}

@end
