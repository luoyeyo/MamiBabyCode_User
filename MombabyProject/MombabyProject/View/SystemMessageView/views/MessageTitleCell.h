//
//  SystemsMCell.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SystemMessage.h"

@interface MessageTitleCell : UITableViewCell

+ (instancetype )defaultClassNameNibViewWithFrame:(CGRect)frame;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (nonatomic, assign) MessageType type;
@end
