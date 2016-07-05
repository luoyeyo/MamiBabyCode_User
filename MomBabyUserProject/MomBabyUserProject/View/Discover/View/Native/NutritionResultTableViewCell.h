//
//  NutritionResultTableViewCell.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/24.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NutritionResultTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray * labelArr;

+ (instancetype)cellWithTableView:(UITableView *)tableView dataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath;

@end
