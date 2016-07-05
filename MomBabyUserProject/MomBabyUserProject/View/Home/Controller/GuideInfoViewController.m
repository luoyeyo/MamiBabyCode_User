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
#import "RelatedReadingTableView.h"
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
@property (strong, nonatomic) RelatedReadingTableView *relatedReading;
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
}

#pragma mark - private

/**
 *  获取文章信息
 */
- (void)getArticlesDetailsInfo {
    [self.view showPopupLoading];
    [kShareManager_Home getArticlesDetailsInfoWithId:kShareManager_Home.currentArticleId.article.Id responseBlock:^(LLError *error,ArticleDetailsModel *data) {
        [self.view hidePopupLoading];
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            _articleInfo = data;
            [self setUIContent];
        }
    }];

}

- (void)setUIContent {
    [self webViewLoadDataWithUrl:_articleInfo.content];
    [self setBottomBarInfo];
}

- (void)setBottomBarInfo {
    self.bottomBar.info = _articleInfo;
}

- (void)setTopBarInfo {
    self.topTitle.text = kShareManager_Home.currentArticleId.article.title;
    self.topIntro.text = kShareManager_Home.currentArticleId.title;
}

#pragma mark - bottomBar

- (void)selectBottomBarWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            [self popViewController];
            break;
           case 3:
            [ShareManager shareTitle:@"妈咪贝比" text:kShareManager_Home.currentArticleId.article.title url:kShareUrl];
            break;
        default:
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
    _likeNumView.likeNum.text = [NSString stringWithFormat:@"%ld",_articleInfo.likeCount];
    self.likeNumView.frame = CGRectMake(0, documentHeight, ScreenWidth, 50);

    self.relatedReading.height = self.relatedReading.tableHeight;
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
    return self.relatedReading.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return [self createNewsCell];
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lightGray"];
        cell.backgroundColor = kColorBackground;
        return cell;
    } else {
        return [self createRelatedReadingCell];
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

- (UITableViewCell *)createRelatedReadingCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RelatedReadingCell"];
    [cell.contentView addSubview:self.relatedReading];
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

- (RelatedReadingTableView *)relatedReading {
    if (!_relatedReading) {
        _relatedReading = [[RelatedReadingTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100) style:UITableViewStylePlain];
    }
    return _relatedReading;
}

- (ArticleLikeNumView *)likeNumView {
    if (!_likeNumView) {
        _likeNumView = [ArticleLikeNumView defaultClassNameNibView];
    }
    return _likeNumView;
}

@end
