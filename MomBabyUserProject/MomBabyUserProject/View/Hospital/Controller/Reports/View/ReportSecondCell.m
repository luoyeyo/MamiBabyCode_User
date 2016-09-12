//
//  ReportSecondCell.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "ReportSecondCell.h"

@implementation ReportSecondCell

- (IBAction)lookDetailsOfReport:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotiClickReport object:self.report];
}

- (void)awakeFromNib {
    self.baseView.layer.borderColor = kColorLineGray.CGColor;
    self.baseView.layer.borderWidth = 1;
    self.backgroundColor = kColorClear;
}

- (void)setReport:(ReportsModel *)report {
    if (_report != report) {
        _report = report;
    }
    [self setUIContent];
}

- (void)setUIContent {
    NSString *high = @"";
    NSString *hypotensive = @"";
    self.weight.text = kNoDataStr;
    self.height.text = kNoDataStr;
    self.illness.text = kNoDataStr;
    
    for (ReportsResultModel *model in self.report.result) {
        if ([model.k isEqualToString:@"体重"]) {
            self.weight.text = model.v;
        } else if ([model.k isEqualToString:@"血压（高）"]) {
            high = model.v;
        } else if ([model.k isEqualToString:@"血压低压"]) {
            hypotensive = model.v;
        } else if ([model.k isEqualToString:@"腹围"]) {
            self.height.text = model.v;
        } else if ([model.k isEqualToString:@"现病史"]) {
            self.illness.text = model.v;
        }
    }
    self.week.text = [NSString stringWithFormat:@"孕%ld周",self.report.weeks];
    self.pressure.text = [NSString stringWithFormat:@"%ld/%ld mmHg",[high integerValue],[hypotensive integerValue]];
    [self.timeBtn setTitleForAllStatus:[NSDate dateStringWithTimeInterval:self.report.physicalTime]];
}

@end
