//
//  ReportListCell.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/14.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  产检报告列表
 */
@interface ReportListCell : UITableViewCell
/**
 *  体重
 */
@property (strong, nonatomic) IBOutlet UILabel *weight;
/**
 *  腹围
 */
@property (strong, nonatomic) IBOutlet UILabel *girth;
/**
 *  孕前体重
 */
@property (strong, nonatomic) IBOutlet UILabel *beforeWeight;
/**
 *  体重指标
 */
@property (strong, nonatomic) IBOutlet UILabel *weightIndex;
/**
 *  孕周
 */
@property (strong, nonatomic) IBOutlet UIButton *timeBtn;
/**
 *  时间
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
