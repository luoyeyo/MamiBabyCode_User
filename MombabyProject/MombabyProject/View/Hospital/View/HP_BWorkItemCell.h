//
//  HP_BWorkItemCell.h
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/17.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalItemModel.h"

@interface HP_BWorkItemCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) HospitalItemModel *model;
@end
