//
//  MessageCell.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell


//  labelHeight 为 label高度    lineHeight 为字体高度   返回行数
- (NSNumber *)giveMeLabelHeight:(CGFloat)labelHeight textLineHeight:(CGFloat)lineHeight {
    NSNumber * count = @((labelHeight) / lineHeight);
    return count;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.backgroundColor = COLOR_C4;
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, ScreenWidth, 20)];
        self.dateLabel.textColor = COLOR_C3;
        self.dateLabel.font = UIFONT_H1_12;
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.dateLabel];
        
        self.whiteColorView = [[UIView alloc] init];
        self.whiteColorView.layer.borderColor = [UIColor colorFromHexRGB:@"e2e2e2"].CGColor;
        self.whiteColorView.layer.borderWidth = 0.5;
        self.whiteColorView.layer.cornerRadius = 3;
        self.whiteColorView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.whiteColorView];
        
        self.detailsLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, self.whiteColorView.width - 10, self.whiteColorView.height - 10)];
        self.detailsLabel.textColor = COLOR_C2;
        self.detailsLabel.font = UIFONT_H2_13;
        self.detailsLabel.numberOfLines = 0;
        self.detailsLabel.backgroundColor = [UIColor whiteColor];
        [self.whiteColorView addSubview:self.detailsLabel];
        
        self.isOpenLabel = [[UILabel alloc] init];
        self.isOpenLabel.font = UIFONT_H2_13;
        self.isOpenLabel.textColor = kColorTheme;
        self.isOpenLabel.textAlignment = NSTextAlignmentCenter;
        [self.whiteColorView addSubview:self.isOpenLabel];
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
