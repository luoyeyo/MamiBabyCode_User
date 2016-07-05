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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectThisBaby:) name:kNotiSelectThisBaby object:nil];
}

- (void)selectThisBaby:(NSNotification *)noti {
    NSNumber *index = noti.object;
    
    self.selectedBtn.selected = (index.integerValue == self.row) ? YES : NO;
}

- (void)setBabyInfo:(BabyInfoModel *)babyInfo {
    _babyInfo = babyInfo;
    self.nameLabel.text = babyInfo.nickname;
    NSString *genderImageName = (babyInfo.gender.integerValue == 1) ? @"page2_icon_man" : @"page2_icon_woman";
    self.genderIcon.image = ImageNamed(genderImageName);
}

@end
