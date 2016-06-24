//
//  RecoverTableViewCell.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/12/25.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "RecoverTableViewCell.h"

@implementation RecoverTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor colorFromHexRGB:@"ffffff"];
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        self.showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
        [self.contentView addSubview:self.showImageView];
        
        self.headlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 14, ScreenWidth - 120, 20)];
        self.headlineLabel.font = UIFONT_H4_15;
        self.headlineLabel.textColor = COLOR_C1;
        [self.contentView addSubview:self.headlineLabel];
        
        self.abstractLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 42, ScreenWidth - 120, 20)];
        self.abstractLabel.font = UIFONT_H2_13;
        self.abstractLabel.textColor = COLOR_C3;
        [self.contentView addSubview:self.abstractLabel];
        
        self.pushImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth - 18, 26, 8.5, 15)];
        self.pushImageView.image = [UIImage imageNamed:@"pushImage"];
        [self.contentView addSubview:self.pushImageView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 79.5, ScreenWidth, 0.5)];
        self.lineView.backgroundColor = [UIColor colorFromHexRGB:@"e2e2e2"];
        [self.contentView addSubview:self.lineView];
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
