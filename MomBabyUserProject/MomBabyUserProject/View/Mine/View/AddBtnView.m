//
//  AddBtnView.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "AddBtnView.h"

@implementation AddBtnView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3;
        self.layer.borderColor = [UIColor colorFromHexRGB:@"e2e2e2"].CGColor;
        self.layer.borderWidth = 0.5f;
        
        self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 12, 100, 20)];
        self.leftLabel.font = UIFONT_H3_14;
        self.leftLabel.textAlignment = NSTextAlignmentLeft;
        self.leftLabel.textColor = COLOR_C2;
        [self addSubview:self.leftLabel];
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 150, 12, 135, 20)];
        self.rightLabel.font = UIFONT_H4_15;
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        self.rightLabel.textColor = COLOR_C1;
        [self addSubview:self.rightLabel];
        
        self.AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.AddButton.frame = CGRectMake(0, 0, self.width, self.height);
        [self addSubview:self.AddButton];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
