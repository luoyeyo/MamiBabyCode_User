//
//  OneGuideInfoCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/15.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "OneGuideInfoCell.h"

@implementation OneGuideInfoCell

- (void)setModel:(DiscoverModel *)model {
    _model = model;
    self.title.text = model.title;
    self.categoryTitle.text = model.article.title;
    self.content.text = model.article.introduction;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.iconimage.real]];
    self.likeNum.text = [NSString stringWithFormat:@"%ld",model.article.likeCount];
}

- (void)setRecommendModel:(ArticleDetailsModel *)recommendModel {
    _recommendModel = recommendModel;
    self.categoryTitle.text = recommendModel.title;
    self.content.text = recommendModel.introduction;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:recommendModel.image.real]];
    self.likeNum.text = [NSString stringWithFormat:@"%ld",recommendModel.likeCount];
}


@end
