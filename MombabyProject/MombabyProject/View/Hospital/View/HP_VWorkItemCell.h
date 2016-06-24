//
//  HP_VWorkItemCell.h
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/14.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HospitalItemModel.h"
// 医院工作事项item 横向的
@interface HP_VWorkItemCell : UICollectionViewCell
+ (instancetype )defaultClassNameNibView;
@property (strong, nonatomic) IBOutlet UIImageView *iconImage;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) HospitalItemModel *model;
@end
