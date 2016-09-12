//
//  CheckReportCell.m
//  DoctorProject
//
//  Created by 龙源美生 on 16/8/22.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "AssayReportCell.h"
#import <objc/runtime.h>

@implementation AssayReportCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.baseView.layer.borderColor = kColorLineGray.CGColor;
    self.baseView.layer.borderWidth = 1;
}

- (void)setAssayReportData:(AssayReportModel *)assayReportData {
    _assayReportData = assayReportData;
    
    for (UIView *view in self.baseView.subviews) {
        if ([view isKindOfClass:[UIImageView class]] && view.height == 33) {
            [view removeFromSuperview];
        }
    }
    
    self.pregnancyWeek.text = [NSString stringWithFormat:@"孕%ld周",assayReportData.weeks];
    [self.reportTime setTitleForAllStatus:[NSDate dateStringWithTimeInterval:assayReportData.physicalTime]];
    self.typeTitle.text = assayReportData.hint;
    for (int i = 0; i < assayReportData.result.count; i ++) {
        ReportsResultModel *model = assayReportData.result[i];
        UILabel *item = [self.contentView viewWithTag:i + 10];
        item.text = [NSString stringWithFormat:@"%@：%@",model.k,model.v];
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    for (int i = 0; i < _assayReportData.result.count; i ++) {
        UILabel *item = [self.contentView viewWithTag:i + 10];
        [self addCautionArrowsWithType:1 frame:item.frame];
    }
}

- (void)addCautionArrowsWithType:(NSInteger)type frame:(CGRect)frame {
    // 1代表上升 2下降
    NSString *imageName;
    if (type == 1) {
        imageName = @"page11_icon_up";
    } else {
        imageName = @"page11_icon_down";
    }
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imageName"]];
    image.frame = CGRectMake(CGRectGetMaxX(frame), CGRectGetMinY(frame), 12, frame.size.height);
    image.contentMode = UIViewContentModeScaleAspectFit;
    [self.baseView addSubview:image];
}

- (NSAttributedString *)makeAttributeStringWithItem:(NSString *)item value:(NSString *)value {
    AttributeStringAttrs *attri1 = [[AttributeStringAttrs alloc] init];
    attri1.text = [NSString stringWithFormat:@"%@：",item];
    attri1.textColor = [UIColor colorFromHexRGB:@"626262"];
    attri1.font = [UIFont fontWithName:@"PingFangSC-Medium" size:11];
    
    AttributeStringAttrs *attri2 = [[AttributeStringAttrs alloc] init];
    attri2.text = value;
    attri2.textColor = [UIColor colorFromHexRGB:@"626262"];
    attri2.font = [UIFont fontWithName:@"PingFangSC-Light" size:11];
    NSAttributedString *attriString = [NSString makeAttrString:@[attri1,attri2]];
    return attriString;
}

@end
