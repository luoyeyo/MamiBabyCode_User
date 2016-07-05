//
//  HospitalInfoCell.m
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/15.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "HospitalInfoCell.h"

@implementation HospitalInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.starView.hasAnimation = NO;
    self.starView.allowIncompleteStar = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HospitalEntryModel *)model {
    _model = model;
    self.hospitalName.text = model.title;
    [self.hospitalImage sd_setImageWithURL:[NSURL URLWithString:model.logo.medium] placeholderImage:nil];
    if (model.introduction) {
        // 设置行距
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineHeightMultiple = 18.f;
        paragraphStyle.maximumLineHeight = 18.f;
        paragraphStyle.minimumLineHeight = 18.f;
        NSDictionary *ats = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName:paragraphStyle};
        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:model.introduction attributes:ats];
        self.content.attributedText = attrStr;
    } else {
        self.content.attributedText = nil;
    }
    
    self.hospitalSpace.text = [NSString stringWithFormat:@"距离%ldkm",(long)model.distance];
    
    NSString *score = [NSString stringWithFormat:@"%.1f",model.starLevel / 5.0];
    self.starView.scorePercent = [score floatValue];
    self.hospitalType.text = model.gradeLevelName;
    self.isHaveFiles.hidden = !model.isBookbuilding;
    if (self.hospitalType.text.length == 0) {
        self.padding.constant = 0;
    } else {
        self.padding.constant = 9;
    }
}

@end
