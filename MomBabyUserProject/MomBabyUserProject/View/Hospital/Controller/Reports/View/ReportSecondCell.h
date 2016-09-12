//
//  ReportSecondCell.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportSecondCell : UITableViewCell
/**
 *  现病史
 */
@property (strong, nonatomic) IBOutlet UILabel *illness;
/**
 *  腹围
 */
@property (strong, nonatomic) IBOutlet UILabel *height;
/**
 *  体重
 */
@property (strong, nonatomic) IBOutlet UILabel *weight;
/**
 *  时间
 */
@property (strong, nonatomic) IBOutlet UIButton *timeBtn;
/**
 *  孕周
 */
@property (strong, nonatomic) IBOutlet UILabel *week;
/**
 *  血压
 */
@property (strong, nonatomic) IBOutlet UILabel *pressure;
@property (strong, nonatomic) ReportsModel *report;
- (IBAction)lookDetailsOfReport:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *baseView;

@end
