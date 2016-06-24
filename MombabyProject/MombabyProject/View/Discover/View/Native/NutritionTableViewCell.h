//
//  NutritionTableViewCell.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/24.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NutritionModel.h"
#import "FoodModel.h"

@class NutritionModel;
@class FoodModel;

@interface NutritionTableViewCell : UITableViewCell

@property (nonatomic, strong) NSMutableArray *nutritionNames;

@property (nonatomic, strong) NSMutableArray *foodNames;


+ (instancetype)cellWithTable:(UITableView *)tableView indexPtah:(NSIndexPath*)indexPath nutritionData:(NSArray *)nutritionData foodData:(NSArray *)foodData;

@end
