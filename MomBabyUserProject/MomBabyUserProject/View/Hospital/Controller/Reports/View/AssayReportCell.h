//
//  CheckReportCell.h
//  DoctorProject
//
//  Created by 龙源美生 on 16/8/22.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  化验报告
 */
@interface AssayReportCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *pregnancyWeek;
@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (strong, nonatomic) IBOutlet UILabel *typeTitle;
@property (strong, nonatomic) IBOutlet UILabel *item1;
@property (strong, nonatomic) IBOutlet UILabel *item2;
@property (strong, nonatomic) IBOutlet UILabel *item3;
@property (strong, nonatomic) IBOutlet UILabel *item4;
@property (strong, nonatomic) IBOutlet UILabel *item5;
@property (strong, nonatomic) IBOutlet UILabel *item6;
@property (strong, nonatomic) IBOutlet UIButton *reportTime;
@property (strong, nonatomic) AssayReportModel *assayReportData;

@end
