//
//  DiscoverListModel.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/6.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "DiscoverListModel.h"

@implementation DiscoverListModel
//- (DiscoverModel *)highRiskArticle {
//    if (_highRiskArticle.Id.integerValue == 0) {
//        return nil;
//    }
//    return _highRiskArticle;
//}
- (void)setHighRiskArticle:(DiscoverModel *)highRiskArticle {
    if (highRiskArticle.Id.integerValue == 0) {
        _highRiskArticle = nil;
    } else {
        _highRiskArticle = highRiskArticle;
    }
}
@end

@implementation DiscoverModel

@end
