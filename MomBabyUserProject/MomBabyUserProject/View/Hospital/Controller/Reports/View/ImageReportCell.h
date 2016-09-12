//
//  ImageReportCell.h
//  DoctorProject
//
//  Created by 龙源美生 on 16/8/22.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  影音报告
 */
@interface ImageReportCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *reportTime;
@property (strong, nonatomic) IBOutlet UILabel *prompt;
@property (strong, nonatomic) IBOutlet UILabel *pregnancyWeek;
@property (strong, nonatomic) IBOutlet UIImageView *reportImage;
@property (strong, nonatomic) IBOutlet UILabel *typeTitle;
@property (strong, nonatomic) IBOutlet UIView *baseView;
@property (strong, nonatomic) ImageReportModel *imageReportData;
@end
