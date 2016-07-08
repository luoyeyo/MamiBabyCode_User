//
//  WikiViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/13.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "WikiViewController.h"
#import "WikiTabeViewCell.h"

#import "WikiModel.h"
#import "WikiTopScrollBtnSView.h"
#import "WikiBottomScrollBtnView.h"
#import "HomeWebViewController.h"

@interface WikiViewController ()
{
    int _page;
}

@property (nonatomic, strong) WikiBottomScrollBtnView *bottomScrollBtnView;

@property (nonatomic, strong) NSMutableArray *bottomDataSource;
@property (nonatomic, copy) NSString *cacheKey;

@end

@implementation WikiViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"营养百科"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"营养百科"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.title = @"营养百科";
    self.view.backgroundColor = [UIColor whiteColor];
    self.bottomDataSource = [[NSMutableArray alloc] init];
    _page = 1;
    // 请求数据
    [self getCache];
    [self requestInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectRowAction:) name:@"selectRow" object:nil];
}

// 加载缓存数据
- (NSArray *)getCache
{
    // 设置为零 可以避免数据重复
    if (self.bottomDataSource.count != 0) {
        [self.bottomDataSource removeAllObjects];
    }
    self.cacheKey = [NSString stringWithFormat:@"%@", self.parentId];
    
    NSArray *allKeys = [[EGOCache share] allKeys];
    
    if ([allKeys containsObject:self.cacheKey] && [[EGOCache share] hasCacheForKey:self.cacheKey]) {
        
        id cache = [[EGOCache share] plistForKey:self.cacheKey];
        for (NSDictionary *smallDict in cache) {
            WikiModel *model = [[WikiModel alloc] init];
            model.parentId = smallDict[@"id"];
            model.title = smallDict[@"title"];
            model.mediumIconImage = smallDict[@"iconImage"][@"medium"];
            model.realIconImage = smallDict[@"iconImage"][@"real"];
            model.introduction = smallDict[@"introduction"];
            [self.bottomDataSource addObject:model];
        }
    }
    return self.bottomDataSource;
}
// 请求数据
- (void)requestInfo
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    parameters[@"page"] = @(_page);
    parameters[@"limit"] = @(20);
    parameters[@"parentId"] = self.parentId;
    [self.view showPopupLoading];
    [[Network_Discover new] getWikiViewControllerWithParams:parameters ResponseBlock:^(LLError *error, id response) {
        [self.view hidePopupLoading];
        if (self.bottomDataSource.count != 0) {
            [self.bottomDataSource removeAllObjects];
        }
        if (!error) {
            NSArray *arr = response[@"list"];
            // 将数据加入缓存
            [[EGOCache share] setPlist:arr forKey:self.cacheKey];
            for (NSDictionary *smallDict in arr) {
                WikiModel *model = [[WikiModel alloc] init];
                model.parentId = smallDict[@"id"];
                model.title = smallDict[@"title"];
                model.mediumIconImage = smallDict[@"iconImage"][@"medium"];
                model.realIconImage = smallDict[@"iconImage"][@"real"];
                model.introduction = smallDict[@"introduction"];
                [self.bottomDataSource addObject:model];
            }
        } else {
            [self.view showToastMessage:@"请求数据失败"];
        }
        // 添加滑动按钮UI
        [self ScorllBtnView];
    }];
}
// 添加滑动按钮UI
- (void)ScorllBtnView
{
    
    WikiTopScrollBtnSView *topScrollBtnView = [[WikiTopScrollBtnSView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    [self.view addSubview:topScrollBtnView];
    
    self.bottomScrollBtnView = [[WikiBottomScrollBtnView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, ScreenHeight)];
    [self.bottomScrollBtnView viewsWithDataSource:self.bottomDataSource];
    [self.view addSubview:self.bottomScrollBtnView];
}

// 页面详情点击事件
- (void)selectRowAction:(NSNotification *)not
{
    WikiModel *model = not.object;
    HomeWebViewController *homeWeb = [[HomeWebViewController alloc] init];
    homeWeb.title = model.title;
    homeWeb.articleId = model.parentId;
    homeWeb.articleTitle = model.title;
    [self.navigationController pushViewController:homeWeb animated:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
