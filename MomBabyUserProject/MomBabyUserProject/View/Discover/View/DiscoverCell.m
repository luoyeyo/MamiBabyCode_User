//
//  DiscoverCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/2.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "DiscoverCell.h"

@implementation DiscoverCell

- (void)setData:(DiscoverModel *)data {
    if (_data != data) {
        _data = data;
    }
    self.title.text = data.title;
    self.content.text = data.introduction;
//    if ([self.title.text containsString:@"百科"]) {
//        self.image.image = ImageNamed(@"page1_icon_encyclopedias");
//    } else if ([self.title.text isEqualToString:@"营养查询"]) {
//        self.image.image = ImageNamed(@"page1_icon_nutrition");
//    } else {
//        self.image.image = ImageNamed(@"page1_icon_test");
//    }
    [self.image sd_setImageWithURL:[NSURL URLWithString:data.iconimage.medium] placeholderImage:ImageNamed(@"page2_default-image")];
}

@end
