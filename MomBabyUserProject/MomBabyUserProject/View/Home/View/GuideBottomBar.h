//
//  GuideBottomBar.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideBottomBarSelectDelegate <NSObject>

/**
 *  4个按钮从左到右 0 1 2 3
 *
 *  @param index 标示点的是哪一个 isSelected yes代表是选中 no取消选中
 */
- (void)selectBottomBarWithIndex:(NSInteger)index isSelected:(BOOL)isSelected;

@end
@interface GuideBottomBar : UIView
@property (nonatomic, copy) void(^selectBlock)(NSInteger index);
@property (nonatomic, assign) id<GuideBottomBarSelectDelegate>delegate;
@property (nonatomic, strong) ArticleDetailsModel *info;
// 当前阅读的文章
@property (nonatomic, strong) DiscoverModel *currentArticleId;
@end
