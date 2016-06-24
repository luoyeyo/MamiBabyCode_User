//
//  InputCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/26.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "InputCell.h"

@implementation InputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = NO;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
