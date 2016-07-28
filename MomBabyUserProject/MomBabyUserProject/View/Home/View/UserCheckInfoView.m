//
//  UserCheckInfoView.m
//  MomBabyUserProject
//
//  Created by 罗野 on 16/7/6.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "UserCheckInfoView.h"

@implementation UserCheckInfoView

- (void)updateCheckInfo {
    NSString *type;
    if (kUserInfo.status == kUserStateMum) {
        type = @"产检";
    } else {
        type = @"儿童保健";
    }
    self.nextCheckTime.text = [NSString stringWithFormat:@"请于%@前往医院进行%@",[NSDate dateStringWithTimeInterval:kShareManager_Home.homeInfo.nextCheckTime formatterStr:@"M月d日"],type];
    
    GestationalWeeks *week = [NSDate calculationIntervalWeeksWithStart:[NSDate date].timeIntervalSince1970 end:kShareManager_Home.homeInfo.nextCheckTime];
    
    NSInteger surplusDay = labs([week.allDay integerValue]);
    // 显示月
    if (surplusDay > 60 && surplusDay <= 365) {
        surplusDay = surplusDay / 7;
        self.unit.text = @"月";
    } else if (surplusDay > 365) {
        surplusDay = 1;
        self.unit.text = @"年以上";
    } else {
        self.unit.text = @"天";
    }
    self.surplusDay.text = [NSString stringWithFormat:@"%ld",surplusDay];
    if (week.allDay.integerValue < 0) {
        self.introText.text = @"您已逾期";
    }
    self.title.text = @"母体周变化";
    self.content.text = kShareManager_Home.homeInfo.motherWeekChange.introduction;
}

@end
