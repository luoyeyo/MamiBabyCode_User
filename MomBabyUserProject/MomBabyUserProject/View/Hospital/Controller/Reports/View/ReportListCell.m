//
//  ReportListCell.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/14.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "ReportListCell.h"

@implementation ReportListCell

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
    self.girth.text = kNoDataStr;
    self.weightIndex.text = kNoDataStr;
    self.beforeWeight.text = kNoDataStr;
    
    for (ReportsResultModel *model in self.report.result) {
        if ([model.k isEqualToString:@"体重"]) {
            self.weight.text = model.v;
        } else if ([model.k isEqualToString:@"高压"]) {
            high = model.v;
        } else if ([model.k isEqualToString:@"血压(低压)"]) {
            hypotensive = model.v;
        } else if ([model.k isEqualToString:@"腹围"]) {
            self.girth.text = model.v;
        } else if ([model.k isEqualToString:@"体重指数"]) {
            self.weightIndex.text = model.v;
        } else if ([model.k isEqualToString:@"孕前体重"]) {
            self.beforeWeight.text = model.v;
        }
    }
    self.week.text = [NSString stringWithFormat:@"孕%ld周",self.report.weeks];
    self.pressure.text = [NSString stringWithFormat:@"%ld/%ld mmHg",[high integerValue],[hypotensive integerValue]];
    [self.timeBtn setTitleForAllStatus:[NSDate dateStringWithTimeInterval:self.report.physicalTime]];
}

@end
