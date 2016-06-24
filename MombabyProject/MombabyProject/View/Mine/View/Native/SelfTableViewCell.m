//
//  SelfTableViewCell.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/19.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "SelfTableViewCell.h"

@implementation SelfTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *pushIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pushImage"]];
        pushIconView.frame = CGRectMake(ScreenWidth - 18, (49 - pushIconView.frame.size.height) * 0.5, 8.5, 15);
        [self.contentView addSubview:pushIconView];
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

-(void)createCellWithTitle:(NSString *)text detail:(NSString *)detailText iconImage:(NSString *)imageName andIndexPtah:(NSIndexPath *)indexPtah
{
    if (indexPtah.row == 0) {
        
        UILabel *titleText = [[UILabel alloc] initWithFrame:CGRectMake(10, (49 - 15) * 0.5, 80, 15)];
        titleText.text = text;
        titleText.font = UIFONT_H4_15;
        titleText.textColor= COLOR_C1;
        titleText.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleText];
        
        CGFloat iconW = 45;
        CGFloat iconX = ScreenWidth - iconW - 30;
        CGFloat iconY = (49 - iconW) * 0.5;
        CGFloat iconH = iconW;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        icon.image = [UIImage imageNamed:imageName];
        [self.contentView addSubview:icon];
        
    }
    else
    {
        UILabel *titleText = [[UILabel alloc] initWithFrame:CGRectMake(10, (49 - 15) * 0.5, 80, 15)];
        titleText.text = text;
        titleText.font = UIFONT_H4_15;
        titleText.textColor= COLOR_C1;
        titleText.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:titleText];
        
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(90, (49 - 15) * 0.5, 80, 15)];
        detail.text = detailText;
        detail.font = UIFONT_H4_15;
        detail.textColor= COLOR_C1;
        detail.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:detail];
    }
}

@end
