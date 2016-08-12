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
        self.introText.text = @"距下次产检";
    } else {
        type = @"儿童保健";
        self.introText.text = @"距下次儿保";
    }
    self.nextCheckTime.text = [NSString stringWithFormat:@"请于%@前往医院进行%@",[NSDate dateStringWithTimeInterval:kShareManager_Home.homeInfo.nextCheckTime formatterStr:@"M月d日"],type];
    
    GestationalWeeks *week = [NSDate calculationIntervalWeeksWithStart:[NSDate date].timeIntervalSince1970 end:kShareManager_Home.homeInfo.nextCheckTime];
    
    NSInteger surplusDay = labs([week.allDay integerValue]);
    
    
    // 单位
    AttributeStringAttrs *unitAttrs = [AttributeStringAttrs new];
    unitAttrs.textColor = [UIColor colorFromHexRGB:@"858585"];
    unitAttrs.font = SystemFont(27);
    // 显示月
    if (surplusDay > 60 && surplusDay <= 365) {
        surplusDay = surplusDay / 7;
        unitAttrs.text = @"月";
    } else if (surplusDay > 365) {
        surplusDay = 1;
        unitAttrs.text = @"年以上";
    } else {
        unitAttrs.text = @"天";
    }
    AttributeStringAttrs *numAttrs = [AttributeStringAttrs new];
    numAttrs.text = [NSString stringWithFormat:@"%ld",surplusDay];
    numAttrs.font = SystemFont(29);
    numAttrs.textColor = [UIColor colorFromHexRGB:@"858585"];
    
    NSAttributedString *text = [NSString makeAttrString:@[numAttrs,unitAttrs]];
    self.surplusDay.attributedText = text;
    if (week.allDay.integerValue < 0) {
        self.introText.text = @"您已逾期";
    }
    self.title.text = @"母体周变化";
    self.content.text = kShareManager_Home.homeInfo.motherWeekChange.introduction;
}

@end
