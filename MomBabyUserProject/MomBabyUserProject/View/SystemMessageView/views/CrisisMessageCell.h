//
//  CrisisMessageCell.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/29.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMessage.h"

@interface CrisisMessageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UILabel *crisisName;
@property (strong, nonatomic) IBOutlet UILabel *crisisNum;
@property (strong, nonatomic) IBOutlet UILabel *crisisUnti;
@property (strong, nonatomic) IBOutlet UILabel *refNum;
@property (strong, nonatomic) SystemMessage *message;
+ (instancetype )defaultClassNameNibViewWithFrame:(CGRect)frame;
@end
