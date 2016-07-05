//
//  TwoGuideInfoCell.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/15.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  第二类型指导信息cell
 */
@interface TwoGuideInfoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *categoryTitle;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *likeNum;
@property (nonatomic, strong) DiscoverModel *model;
@end
