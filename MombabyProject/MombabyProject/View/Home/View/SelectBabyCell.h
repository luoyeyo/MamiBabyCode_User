//
//  SelectBabyCell.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/21.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBabyCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *selectedBtn;
@property (nonatomic, assign) NSInteger row;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *genderIcon;
@property (nonatomic, strong) BabyInfoModel *babyInfo;
@end
