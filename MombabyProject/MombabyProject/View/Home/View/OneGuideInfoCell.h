//
//  OneGuideInfoCell.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/15.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  第一类型指导信息cell
 */
@interface OneGuideInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *titleImage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *likeNum;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *categoryTitle;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIImageView *tagImage;
@property (nonatomic, strong) DiscoverModel *model;
// 危急信息
@property (nonatomic, strong) CategoriesModel *categoriesModel;
@end
