//
//  RelateReadCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/17.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "RecommendReadCell.h"

@implementation RecommendReadCell

- (void)setModel:(ArticleDetailsModel *)model {
    _model = model;
    self.title.text = model.title;
    self.content.text = model.introduction;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.image.real]];
    self.likeNum.text = [NSString stringWithFormat:@"%ld",model.likeCount];
}

@end
