//
//  ArticleDetailsModel.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/20.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HttpResponseData.h"
/**
 *  文章详情
 */
@interface ArticleDetailsModel : HttpResponseData
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, strong) PhotoModel *image;
@property (nonatomic, copy) NSString *shareUrl;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger collectCount;
@property (nonatomic, assign) NSInteger likeCount;
/**
 *  1是收藏
 */
@property (nonatomic, assign) NSInteger favorite;
/**
 *  1是喜欢
 */
@property (nonatomic, assign) NSInteger isLike;
@end

@protocol ArticleDetailsModel <NSObject>

@end

// 文章列表
@interface ArticleListModel : HttpResponseData
@property (nonatomic, copy) NSArray <ArticleDetailsModel>*list;
@end


