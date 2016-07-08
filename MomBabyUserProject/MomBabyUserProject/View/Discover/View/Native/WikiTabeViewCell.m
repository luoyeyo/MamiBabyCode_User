//
//  WikiTabeViewCell.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/25.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "WikiTabeViewCell.h"


@implementation WikiTabeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        CGFloat iconImageX = 10;
        CGFloat iconImageH = 50;
        CGFloat iconImageY = (65 - iconImageH) * 0.5;
        CGFloat iconImageW = 68;
        _iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(iconImageX, iconImageY, iconImageW, iconImageH)];
        _iconImage.layer.masksToBounds = YES;
        _iconImage.layer.cornerRadius = 3;
        _iconImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_iconImage];
        
        CGFloat titleX = iconImageX * 2 + iconImageW;
        CGFloat titleY = iconImageY + 5;
        CGFloat titleW = ScreenWidth - titleX - iconImageX * 2;
        CGFloat titleH = 15;
        _title = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        _title.textColor = COLOR_C1;
        _title.font = UIFONT_H4_15;
        _title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_title];
        
        CGFloat detailX = titleX;
        CGFloat detailY = titleY + titleH + 8;
        CGFloat detailW = titleW;
        CGFloat detailH = 15;
        _detail = [[UILabel alloc] initWithFrame:CGRectMake(detailX, detailY, detailW, detailH)];
        _detail.textColor = COLOR_C3;
        _detail.font = UIFONT_H3_14;
        _detail.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_detail];
        
        UIImageView *pushIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pushImage"]];
        pushIconView.frame = CGRectMake(ScreenWidth - 18, (65 - pushIconView.frame.size.height) * 0.5, 8.5, 15);
        [self.contentView addSubview:pushIconView];
        
    }
    return self;
}

- (void)cellWithModel:(WikiModel *)model
{
    [_iconImage sd_setImageWithURL:[NSURL URLWithString:model.mediumIconImage]];
    _title.text = model.title;
    _detail.text = model.introduction;
}

@end
