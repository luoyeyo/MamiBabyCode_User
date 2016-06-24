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
 *  @param index 
 */
- (void)selectBottomBarWithIndex:(NSInteger)index;

@end
@interface GuideBottomBar : UIView
@property (nonatomic, copy) void(^selectBlock)(NSInteger index);
@property (nonatomic, assign) id<GuideBottomBarSelectDelegate>delegate;
@property (nonatomic, strong) ArticleDetailsModel *info;
@end
