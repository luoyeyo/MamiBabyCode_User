//
//  GuideInfoViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/17.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "GuideInfoViewController.h"
#import "GuideBottomBar.h"
#import <WebKit/WebKit.h>
#import "RecommendReadingTableView.h"
#import "ArticleLikeNumView.h"

@interface GuideInfoViewController ()<GuideBottomBarSelectDelegate,UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    ArticleDetailsModel *_articleInfo;
}

// 顶部导航栏
@property (strong, nonatomic) IBOutlet UIView *topBar;
// 顶部的表头
@property (strong, nonatomic) IBOutlet UILabel *topTitle;
// 底层scroll
@property (strong, nonatomic) IBOutlet UITableView *baseScrollView;
// 顶部的简介
@property (strong, nonatomic) IBOutlet UILabel *topIntro;
// 底部工具栏
@property (strong, nonatomic) GuideBottomBar *bottomBar;
// 推荐阅读
@property (strong, nonatomic) RecommendReadingTableView *recommendTableView;

@property (strong, nonatomic) UIWebView *webView;
// 顶部的遮挡状态栏的 bar
@property (strong, nonatomic) UIView *topLineBar;

@property (strong, nonatomic) ArticleLikeNumView *likeNumView;
@end

@implementation GuideInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topLineBar];
    [self.view addSubview:self.bottomBar];

    self.baseScrollView.delegate = self;
    [self setTopBarInfo];
    [self getArticlesDetailsInfo];
    [self getRecommendList];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if ([[self.navigationController.viewControllers objectAtIndex:0] isEqual:self]) {
        // 是主文章（第一篇 和主页的数据是绑定的 之后的页面没有关联）告诉首页 去刷新各个数据的点赞
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotiUpdateLikeCountData object:nil];
    }
}

#pragma mark - private

/**
 *  获取文章信息
 */
- (void)getArticlesDetailsInfo {
    [self.view showPopupLoading];
    [kShareManager_Home getArticlesDetailsInfoWithId:self.currentArticle.article.Id responseBlock:^(LLError *error,ArticleDetailsModel *data) {
        [self.view hidePopupLoading];
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            _articleInfo = data;
            [self setUIContent];
        }
    }];
}

// 获取推荐列表
- (void)getRecommendList {
    [kShareManager_Home getRecommendArticlesListWithId:self.currentArticle.article.Id responseBlock:^(LLError *error, ArticleListModel *data) {
        if (!error && data.list.count > 0) {
            self.recommendTableView.list = [data.list mutableCopy];
            [self.recommendTableView reloadData];
            [self.baseScrollView reloadData];
        }
    }];
}

// 收藏
- (void)colloct {
    [[Network_Discover new] postCollectThisArticlesWithId:self.currentArticle.article.Id ResponseBlock:^(LLError *error) {
        if (!error) {
            [kAppDelegate.window showToastMessage:@"收藏成功"];
        }
    }];
    _articleInfo.collectCount ++;
}
// 取消收藏
- (void)deleteColletcion {
    [[Network_Discover new] deleteCollectThisArticlesWithId:self.currentArticle.article.Id ResponseBlock:^(LLError *error) {
        if (!error) {
            [kAppDelegate.window showToastMessage:@"成功取消收藏"];
        }
    }];
    _articleInfo.collectCount --;
}
// 点赞
- (void)like {
    [[Network_Discover new] postLikeThisArticlesWithId:self.currentArticle.article.Id ResponseBlock:^(LLError *error) {
        if (!error) {
            // 当前选中的
            NSInteger likeCount = self.currentArticle.article.likeCount;
            self.currentArticle.article.likeCount = likeCount + 1;
        }
    }];
    _articleInfo.likeCount ++;
}
// 取消点赞
- (void)stopLike {
    [[Network_Discover new] deleteLikeThisArticlesWithId:self.currentArticle.article.Id ResponseBlock:^(LLError *error) {
        if (!error) {
            // 当前选中的
            NSInteger likeCount = self.currentArticle.article.likeCount;
            self.currentArticle.article.likeCount = likeCount - 1;
        }
    }];
    _articleInfo.likeCount --;
}

#pragma mark - private

- (void)setUIContent {
    [self webViewLoadDataWithUrl:_articleInfo.content];
    [self setBottomBarInfo];
}

- (void)setBottomBarInfo {
    self.bottomBar.info = _articleInfo;
}

- (void)setTopBarInfo {
    self.topTitle.text = self.currentArticle.article.title;
    self.topIntro.text = self.currentArticle.title;
}

// 设置收藏数目和点赞数目
- (void)setLikeCountData {
    _likeNumView.likeNum.text = [NSString stringWithFormat:@"%ld",_articleInfo.likeCount];
    _likeNumView.collectionNum.text = [NSString stringWithFormat:@"%ld",_articleInfo.collectCount];
}

#pragma mark - bottomBar

- (void)selectBottomBarWithIndex:(NSInteger)index isSelected:(BOOL)isSelected {
    switch (index) {
        case 0:
            [self popViewController];
            break;
        case 3:
            [ShareManager shareTitle:@"妈咪贝比" text:self.currentArticle.article.title url:_articleInfo.shareUrl];
            break;
        case 2:
            // 点赞
            if (isSelected == YES) {
                [self like];
            } else {
                [self stopLike];
            }
            [self setLikeCountData];
            break;
        default:
            // 收藏
            if (isSelected == YES) {
                [self colloct];
            } else {
                [self deleteColletcion];
            }
            [self setLikeCountData];
            break;
    }
}

#pragma mark - webview

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view hidePopupLoading];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self getWebViewHeight];
    });
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.view showToastMessage:@"加载失败"];
    [self.view hidePopupLoading];
}

- (void)getWebViewHeight {
    
    //获取页面高度，并重置webview的frame + 60预留likeview
    CGFloat documentHeight = self.webView.scrollView.contentSize.height;
    self.webView.height = documentHeight + 50;
    
    // 喜欢数目
    [self.webView addSubview:self.likeNumView];
    self.likeNumView.frame = CGRectMake(0, documentHeight, ScreenWidth, 50);
    [self setLikeCountData];

    self.recommendTableView.height = self.recommendTableView.tableHeight;
    [self.baseScrollView reloadData];
}

- (void)webViewLoadDataWithUrl:(NSString *)url {
    
    [self.webView loadHTMLString:url baseURL:nil];
    [self.view showPopupLoading];
}

#pragma mark - tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return self.webView.height;
    } else if (indexPath.row == 1) {
        // 中间的黑色间隔
        return 5;
    }
    return self.recommendTableView.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self createNewsCell];
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lightGray"];
        cell.backgroundColor = kColorBackground;
        return cell;
    } else {
        return [self createRecommendReadingCell];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 80) {
        self.topLineBar.hidden = YES;
    } else {
        self.topLineBar.hidden = NO;
    }
}

- (UITableViewCell *)createNewsCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NewsCell"];
    [cell.contentView addSubview:self.webView];
    return cell;
}

- (UITableViewCell *)createRecommendReadingCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RelatedReadingCell"];
    [cell.contentView addSubview:self.recommendTableView];
    return cell;
}

#pragma mark - Lazy load

- (GuideBottomBar *)bottomBar {
    if (!_bottomBar) {
        _bottomBar = [GuideBottomBar defaultClassNameNibViewWithFrame:CGRectMake(0, ScreenHeight - 40, ScreenWidth, 40)];
        _bottomBar.delegate = self;
    }
    return _bottomBar;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth - 20, ScreenHeight - 80 - 40)];
        _webView.delegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

- (UIView *)topLineBar {
    if (!_topLineBar) {
        _topLineBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        _topLineBar.backgroundColor = [UIColor colorFromHexRGB:@"ff7866"];
    }
    return _topLineBar;
}

- (RecommendReadingTableView *)recommendTableView {
    if (!_recommendTableView) {
        _recommendTableView = [[RecommendReadingTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100) style:UITableViewStylePlain];
        WS(weakSelf);
        [_recommendTableView setSelectCellBlock:^(NSInteger index) {
            DiscoverModel *model = [DiscoverModel new];
            model.article = [DiscoverModel new];
            ArticleDetailsModel *article = weakSelf.recommendTableView.list[index];
            model.article.Id = article.Id;
            model.article.title = article.title;
            model.title = @"相关阅读";
            GuideInfoViewController *vc = [weakSelf.storyboard instantiateViewControllerWithIdentifier:@"GuideInfoViewController"];
            vc.currentArticle = model;
            [weakSelf pushViewController:vc];
        }];
    }
    return _recommendTableView;
}

- (ArticleLikeNumView *)likeNumView {
    if (!_likeNumView) {
        _likeNumView = [ArticleLikeNumView defaultClassNameNibView];
    }
    return _likeNumView;
}

@end
