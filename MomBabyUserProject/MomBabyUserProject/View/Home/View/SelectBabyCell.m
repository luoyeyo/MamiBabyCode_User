//
//  SelectBabyCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/21.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "SelectBabyCell.h"

@implementation SelectBabyCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setBabyInfo:(BabyInfoModel *)babyInfo {
    _babyInfo = babyInfo;
    self.nameLabel.text = babyInfo.nickname;
    NSString *genderImageName = (babyInfo.gender.integerValue == 1) ? @"page2_icon_man" : @"page2_icon_woman";
    self.genderIcon.image = ImageNamed(genderImageName);
    if (kUserInfo.status == kUserStateChild && [kUserInfo.currentBaby.Id isEqual:babyInfo.Id]) {
        self.selectedBtn.selected = YES;
    }
}

- (void)isMum {
    self.nameLabel.text = kUserInfo.nickname;
    self.genderIcon.image = ImageNamed(@"page2_icon_mom");
    if (kUserInfo.status == kUserStateMum) {
        self.selectedBtn.selected = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectedBtn.selected = selected;
    }
}

@end
