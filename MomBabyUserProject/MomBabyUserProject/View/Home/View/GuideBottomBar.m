//
//  GuideBottomBar.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "GuideBottomBar.h"

@interface GuideBottomBar ()
// 点赞
@property (strong, nonatomic) IBOutlet UIButton *supportBtn;
// 收藏
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
    sender.selected = !sender.selected;
}
/**
 *  支持 点赞
 *
 *  @param sender
 */
- (IBAction)support:(UIButton *)sender {
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
    // 1是点赞
    self.supportBtn.selected = (info.isLike == 1) ? YES : NO;
}
@end
