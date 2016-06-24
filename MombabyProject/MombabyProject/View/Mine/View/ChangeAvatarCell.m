//
//  ChangeAvatarCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/27.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "ChangeAvatarCell.h"

@implementation ChangeAvatarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:kUserInfo.avatar.medium] placeholderImage:kDefalutAvatar];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
