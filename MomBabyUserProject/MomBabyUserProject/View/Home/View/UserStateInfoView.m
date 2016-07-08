//
//  UserStateInfoView.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/15.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "UserStateInfoView.h"

@interface UserStateInfoView ()
@property (nonatomic, strong) IBOutlet UILabel *topOne;
@property (nonatomic, strong) IBOutlet UILabel *bottomOne;
@property (nonatomic, strong) IBOutlet UILabel *topTow;
@property (nonatomic, strong) IBOutlet UILabel *bottomTow;
@property (nonatomic, strong) IBOutlet UILabel *topThree;
@property (nonatomic, strong) IBOutlet UILabel *bottomThree;
@end

@implementation UserStateInfoView

- (void)updateInfo {
    if (kUserInfo.status == kUserStateMum) {
        [self setMomUI];
    } else {
        [self setBabyUI];
    }
}

- (void)setMomUI {
    self.topOne.text = @"预产期";
    self.topTow.text = @"已怀孕";
    self.topThree.text = @"宝宝身高体重";
    if (kUserInfo.isLogined) {
        
        self.bottomOne.text = [NSDate dateStringWithTimeInterval:kUserInfo.dueDate formatterStr:@"yyyy年M月d日"];
        
        // 妈妈怀孕天数 服务器时间减去末次月经
        GestationalWeeks *day = [NSDate calculationIntervalWeeksWithStart:kUserInfo.lastMenses.doubleValue end:kUserInfo.currentTime.doubleValue];
        self.bottomTow.text = [NSString stringWithFormat:@"%@天",day.allDay];
        if (day.allDay.integerValue >= kUserStateMomDays) {
            self.topTow.text = @"已分娩";
            self.bottomTow.text = @"-";
        }
        [self getBabyHeightWithWeek:day.allDay.integerValue / 7];
    } else {
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-dd"];
        NSDate * yuChanQiDate = [dateFormatter dateFromString:kUserInfo.dueDateStr];
        //得到末次月经 怀孕天数
        NSDate * moCiDate = [yuChanQiDate getMensesDate];
        GestationalWeeks *day = [NSDate calculationIntervalWeeksWithStart:moCiDate.timeIntervalSince1970 end:[NSDate date].timeIntervalSince1970];
        [self getBabyHeightWithWeek:day.allDay.integerValue / 7];
        
        self.bottomOne.text = kUserInfo.dueDateStr;
        self.bottomTow.text = [NSString stringWithFormat:@"%@天",day.allDay];
    }
}

- (void)setBabyUI {
    self.topOne.text = @"身高";
    self.topTow.text = @"已出生";
    self.topThree.text = @"体重";
    ReturnIf(kUserInfo.currentBaby.birth.integerValue == 0);
    // 出生天数
    GestationalWeeks *day = [NSDate calculationIntervalWeeksWithStart:kUserInfo.currentBaby.birth.doubleValue end:[NSDate date].timeIntervalSince1970];
    self.bottomTow.text = [NSString stringWithFormat:@"%@天",day.allDay];
    
    NSArray *array;
    
    if (kUserInfo.currentBaby.gender.integerValue == 1) {
        array = [DataManager getBoyHeightAndWeight];
    } else {
        array = [DataManager getGirlHeightAndWeight];
    }
//    UserInfoEntity *user = kUserInfo;
    NSString * babyHeight = @"-cm";
    NSString * babyKg = @"-kg";
    NSInteger month = day.allDay.integerValue / 30;
    HeightAndWeightRange *model = array[month];
    // 36周以内的数据
    if (month <= 36) {
        babyHeight = [NSString stringWithFormat:@"%@ - %@cm",model.heightLow,model.heightHigh];
        babyKg = [NSString stringWithFormat:@"%@ - %@kg",model.weightLow,model.weightHigh];
    }
    self.bottomOne.text = babyHeight;
    self.bottomThree.text = babyKg;
}

/**
 *  传入怀孕天数  计算高度
 */
- (void)getBabyHeightWithWeek:(NSInteger)week {
    // 宝宝身高体重
    NSString * babyHeight = @"-";
    NSString * babyKg = @"-";
    if (week >= 13 && week <= 40) {
        NSArray *arr = [DataManager getBabyHeightAndWeight];
        HeightAndWeightModel *model = arr[week - 13];
        babyHeight = model.height;
        babyKg = model.kg;
        self.bottomThree.text = [NSString stringWithFormat:@"%@mm %@g",babyHeight,babyKg];
    } else {
        self.bottomThree.text = @"-";
    }
}

@end
