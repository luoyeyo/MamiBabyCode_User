//
//  DiscoverListModel.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/6.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HttpResponseData.h"
#import "CategoriesModel.h"

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
// 首页用的高危
@property (nonatomic, strong) CategoriesModel *categories;
// 首页用的id
@property (nonatomic, copy) NSString *hospitalId;
@property (nonatomic, copy) NSArray<DiscoverModel> *list;
@end
