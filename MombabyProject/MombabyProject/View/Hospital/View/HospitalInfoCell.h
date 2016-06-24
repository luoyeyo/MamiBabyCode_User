//
//  HospitalInfoCell.h
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/15.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
#import "HospitalListModel.h"

@interface HospitalInfoCell : UITableViewCell

@property (nonatomic, strong) HospitalEntryModel *model;
@property (strong, nonatomic) IBOutlet CWStarRateView *starView;
@property (strong, nonatomic) IBOutlet UILabel *hospitalType;
@property (strong, nonatomic) IBOutlet UIImageView *hospitalImage;
@property (strong, nonatomic) IBOutlet UILabel *hospitalName;
@property (strong, nonatomic) IBOutlet UILabel *hospitalSpace;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *padding;
@property (strong, nonatomic) IBOutlet UILabel *isHaveFiles;
@end
