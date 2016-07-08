//
//  GuideBottomBar.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "GuideBottomBar.h"

@interface GuideBottomBar ()
@property (strong, nonatomic) IBOutlet UIButton *supportBtn;
@property (strong, nonatomic) IBOutlet UIButton *likeBtn;
@end

@implementation GuideBottomBar

/**
 *  收藏
 *
 *  @param sender
 */
- (IBAction)likeThisArticle:(UIButton *)sender {
    [self.delegate selectBottomBarWithIndex:1 isSelected:!sender.selected];
    if (sender.isSelected == YES) {
        [[Network_Discover new] deleteCollectThisArticlesWithId:kShareManager_Home.currentArticleId.article.Id ResponseBlock:^(LLError *error) {
            if (!error) {
                [kAppDelegate.window showToastMessage:@"成功取消收藏"];
            }
        }];
    } else {
        [[Network_Discover new] postCollectThisArticlesWithId:kShareManager_Home.currentArticleId.article.Id ResponseBlock:^(LLError *error) {
            if (!error) {
                [kAppDelegate.window showToastMessage:@"收藏成功"];
            }
        }];
    }
    sender.selected = !sender.selected;
}
/**
 *  支持 点赞
 *
 *  @param sender
 */
- (IBAction)support:(UIButton *)sender {
    if (sender.isSelected == YES) {
        [[Network_Discover new] deleteLikeThisArticlesWithId:kShareManager_Home.currentArticleId.article.Id ResponseBlock:^(LLError *error) {
            if (!error) {
                // 当前选中的
                NSInteger likeCount = kShareManager_Home.currentArticleId.article.likeCount;
                kShareManager_Home.currentArticleId.article.likeCount = likeCount - 1;
            }
        }];
    } else {
        [[Network_Discover new] postLikeThisArticlesWithId:kShareManager_Home.currentArticleId.article.Id ResponseBlock:^(LLError *error) {
            if (!error) {
                // 当前选中的
                NSInteger likeCount = kShareManager_Home.currentArticleId.article.likeCount;
                kShareManager_Home.currentArticleId.article.likeCount = likeCount + 1;
            }
        }];
    }
    sender.selected = !sender.selected;
    [self.delegate selectBottomBarWithIndex:2 isSelected:sender.isSelected];
}

- (IBAction)shareThisInfo:(UIButton *)sender {
    
    [self.delegate selectBottomBarWithIndex:3 isSelected:sender.isSelected];
}

- (IBAction)backToLast:(UIButton *)sender {
    
    [self.delegate selectBottomBarWithIndex:0 isSelected:sender.isSelected];
}

- (void)setInfo:(ArticleDetailsModel *)info {
    _info = info;
    // 1是收藏
    self.likeBtn.selected = (info.favorite == 1) ? YES : NO;
}
@end
