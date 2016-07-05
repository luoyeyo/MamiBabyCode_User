//
//  CrisisMessageCell.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/29.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "CrisisMessageCell.h"

@implementation CrisisMessageCell

+ (instancetype )defaultClassNameNibViewWithFrame:(CGRect)frame
{
    NSArray *views = [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil];
    for (CrisisMessageCell *view in views) {
        if ([view isMemberOfClass:[self class]]) {
            view.frame = frame;
            view.backgroundColor = [UIColor clearColor];
            return view;
        }
    }
    NSAssert(NO, @"Expect file: %@", [NSString stringWithFormat:@"%@.xib", NSStringFromClass([self class])]);
    return nil;
}

- (void)setMessage:(SystemMessage *)message {
    if (_message != message) {
        _message = message;
    }
//    self.userInteractionEnabled = NO;
//    self.name.text = message.patient.username;
//    GestationalWeeks *week = [NSDate calculationGestationalWeeksWith:message.patient.lastMenses];
//    if ([week.day integerValue] == 0) {
//        self.time.text = [NSString stringWithFormat:@"孕%@周",week.week];
//    } else {
//        self.time.text = [NSString stringWithFormat:@"孕%@周 + %@天",week.week,week.day];
//    }
//    self.crisisName.text = [NSString stringWithFormat:@"%@：",message.emergence.type];
//    self.crisisNum.text = message.emergence.ref;
////    self.crisisUnti.text = message.emergence.ref;
//    self.refNum.text = [NSString stringWithFormat:@"参考值：%@",message.emergence.real];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
