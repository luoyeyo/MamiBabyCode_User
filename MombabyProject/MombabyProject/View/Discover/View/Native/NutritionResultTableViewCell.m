//
//  NutritionResultTableViewCell.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/24.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "NutritionResultTableViewCell.h"
#import "ResuletFoodListModel.h"

@implementation NutritionResultTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)cellWithTableView:(UITableView *)tableView dataSource:(NSArray *)dataSource indexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"iden";
    NutritionResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
        cell = [[NutritionResultTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
        
        ResuletFoodListModel *foodModel = dataSource[indexPath.row];
        
        for (int i = 0; i < 3; i ++) {
            
            CGFloat labelX = ScreenWidth / 3 * i + 5;
            CGFloat labelH = 40;
            CGFloat labelY = (49 - labelH) * 0.5;
            CGFloat labelW = ScreenWidth / 3;
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
            label.font = UIFONT_H2_13;
            label.textColor = COLOR_C2;
            switch (i) {
                case 0:
                    label.text = foodModel.name;
                    break;
                case 1:
                    label.text = [NSString stringWithFormat:@"%.2f", foodModel.protein.floatValue];
                    break;
                case 2:
                    if ([NSString isEmptyString:foodModel.unit]) {
                        label.text = @"无";
                    }
                    else
                    {
                        label.text = [NSString stringWithFormat:@"%@", foodModel.unit];
                    }
                    break;
            }
            label.numberOfLines = 0;
            label.textAlignment = NSTextAlignmentCenter;
            [cell.contentView addSubview:label];
        }

    }
    return cell;
}


@end
