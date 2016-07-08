//
//  RelateReadCell.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/17.
//  Copyright © 2016年 luo. All rights reserved.
//

@interface RecommendReadCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *titleImage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *likeNum;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (nonatomic, strong) ArticleDetailsModel *model;
@end
