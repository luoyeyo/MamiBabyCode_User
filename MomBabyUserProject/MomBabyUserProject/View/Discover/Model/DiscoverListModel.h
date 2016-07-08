//
//  DiscoverListModel.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/6.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HttpResponseData.h"
#import "CategoriesModel.h"
#import "UserInfoChangeModel.h"

@interface DiscoverModel : HttpResponseData
//@property (nonatomic, copy) NSString * article;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * introduction;
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) PhotoModel *iconimage;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, copy) DiscoverModel *article;
@property (nonatomic, assign) NSInteger likeCount;
@end

@protocol DiscoverModel <NSObject>

@end

@interface DiscoverListModel : HttpResponseData

@property (nonatomic, assign) NSTimeInterval nextCheckTime;

//@property (nonatomic, strong) CategoriesModel *categories;
// 首页用的高危文章
@property (nonatomic, strong) DiscoverModel *highRiskArticle;
// 首页用的id
@property (nonatomic, copy) NSString *hospitalId;

@property (nonatomic, copy) NSArray<DiscoverModel> *list;

@property (nonatomic, strong) UserInfoChangeModel *motherWeekChange;

@end
