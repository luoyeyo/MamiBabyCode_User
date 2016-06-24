//
//  HP_BWorkItemCell.m
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/17.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "HP_BWorkItemCell.h"

@implementation HP_BWorkItemCell

- (void)setModel:(HospitalItemModel *)model {
    _model = model;
    
    self.titleLabel.text = model.title;
    if (model.iconValid) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconValid.medium] placeholderImage:nil];
    } else if (model.iconInvalid) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconInvalid.medium] placeholderImage:nil];
    }
    
}

- (void)awakeFromNib {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor colorFromHexRGB:@"f1ecec"];
    self.selectedBackgroundView = view;
    self.backgroundColor = [UIColor whiteColor];
}

@end
