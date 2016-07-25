//
//  GuideInfoViewController.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/17.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "ViewController.h"

@interface GuideInfoViewController : ViewController
// 当前阅读的文章 （主要目的是持有首页的文章对象  同时操作点赞数目等）
@property (nonatomic, strong) DiscoverModel *currentArticle;

@end
