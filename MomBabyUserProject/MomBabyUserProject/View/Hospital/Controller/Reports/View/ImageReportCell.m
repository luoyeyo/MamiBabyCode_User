//
//  ImageReportCell.m
//  DoctorProject
//
//  Created by 龙源美生 on 16/8/22.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "ImageReportCell.h"

@implementation ImageReportCell

- (void)awakeFromNib {
    self.backgroundColor = kColorClear;
    self.baseView.layer.borderColor = kColorLineGray.CGColor;
    self.baseView.layer.borderWidth = 1;
}

- (void)setImageReportData:(ImageReportModel *)imageReportData {
    _imageReportData = imageReportData;
    self.pregnancyWeek.text = [NSString stringWithFormat:@"孕%ld周",imageReportData.weeks];
    self.typeTitle.text = imageReportData.hint;
    self.prompt.text = [NSString stringWithFormat:@"检查提醒：%@",imageReportData.designation];
    [self.reportTime setTitleForAllStatus:[NSDate dateStringWithTimeInterval:imageReportData.physicalTime]];
    if (imageReportData.images.count > 0) {
        PhotoModel *image = imageReportData.images[0];
        [self.reportImage sd_setImageWithURL:[NSURL URLWithString:image.medium] placeholderImage:kDefalutAvatar];
    }
}

@end
