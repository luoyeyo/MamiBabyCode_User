//
//  RightInputCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/27.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "RightInputCell.h"

@implementation RightInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textfiled.text = kUserInfo.nickname;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
