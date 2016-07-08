//
//  HomeWebViewController.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "HomeWebViewController.h"


@interface HomeWebViewController ()<UIWebViewDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSDictionary * dict;
@property (nonatomic, strong) UIButton * collectBtn;
@end

@implementation HomeWebViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dict = [NSDictionary dictionary];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = COLOR_C4;
    
    self.title = self.articleTitle;
    if (self.navigationController.navigationBar.hidden == YES) {
//        self.navigationController.navigationBar.hidden = NO;
        [self customNavgationBar];
        self.navTitle.text = self.articleTitle;
    }
    [self connectInternert];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"web文章详情"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"web文章详情"];
}

- (void)createTitleView {
    CGFloat yOrigin = (self.navigationController.navigationBar.hidden == YES) ? 64 : 0;
    
    UILabel * titLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 80 - 64 + yOrigin, self.view.width - 20, 25)];
    titLabel.text = [self.dict objectForKey:@"title"];
    titLabel.textColor = COLOR_C1;
    titLabel.font = UIFONT_H6_16;
    [self.view addSubview:titLabel];
    
    NSDate * detaildate = [NSDate dateWithTimeIntervalSince1970:[[self.dict objectForKey:@"modified"] intValue]];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    UILabel * dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 110 - 64 + yOrigin, 120, 20)];
    dateLabel.text = currentDateStr;
    dateLabel.textColor = COLOR_C3;
    dateLabel.font = UIFONT_H1_12;
    [self.view addSubview:dateLabel];
    
    
    UILabel * browseLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 110 - 64 + yOrigin, 120, 20)];
    browseLabel.text = [NSString stringWithFormat:@"浏览次数:%@",[self.dict objectForKey:@"viewCount"]];
    browseLabel.textColor = COLOR_C3;
    browseLabel.font = UIFONT_H1_12;
    [self.view addSubview:browseLabel];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 131 - 64 + yOrigin, self.view.bounds.size.width,self.view.height - 111 - yOrigin)];
    _webView.delegate = self;
    _webView.opaque = NO;
    _webView.scrollView.delegate = self;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.scrollView.showsHorizontalScrollIndicator = NO;
    _webView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_webView];
    [_webView loadHTMLString:[self.dict objectForKey:@"content"] baseURL:nil];
}

- (void)connectInternert {
    
    [[Network_Discover new] getArticlesDetailsWithParams:self.articleId ResponseBlock:^(LLError *error, id response) {
        if (!error) {
            self.dict = [NSDictionary dictionaryWithDictionary:response];
            [self createTitleView];
            [self createBottomView];
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

#pragma mark - webView delegate
- (void )webViewDidStartLoad:(UIWebView  *)webView{
}

- (void )webViewDidFinishLoad:(UIWebView  *)webView{
//    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
//    int height = [height_str intValue];
}

- (void)webView:(UIWebView *)webView  didFailLoadWithError:(NSError *)error{
    NSLog(@"%@",error);
}

#pragma mark - 下方收藏 分享 UI
- (void)createBottomView {
    UIView * bottmV = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - 44, self.view.width, 44)];
    bottmV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottmV];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 0.5)];
    lineView.backgroundColor = [UIColor colorFromHexRGB:@"e2e2e2"];
    [bottmV addSubview:lineView];
    
    self.collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectBtn.frame = CGRectMake(40, 11, 25, 22);
    if ([[self.dict objectForKey:@"favorite"] intValue] != 2) {
        //该状态为已收藏状态,按钮置为点击状态.
        self.collectBtn.selected = YES;
    }
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"noLike"] forState:UIControlStateNormal];
    [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"like"] forState:UIControlStateSelected];
    [self.collectBtn addTarget:self action:@selector(collectBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottmV addSubview:self.collectBtn];
    
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(self.view.width - 64, 10, 24, 24);
    [shareBtn setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottmV addSubview:shareBtn];
}

#pragma mark - bottom View  收藏 和 分享 点击方法
- (void)collectBtnAction {
    
    if (kUserInfo.isLogined) {
        if (self.collectBtn.selected == YES) {
            //取消收藏
            [self deleteArticles];
        }
        else{
            //收藏
            [self collectArticles];
        }
    } else {
        [kAppDelegate toPresentLogin];
    }
    self.collectBtn.selected = !self.collectBtn.selected;
}

- (void)shareBtnAction {
    
    [ShareManager shareTitle:@"妈咪贝比" text:[self.dict objectForKey:@"title"] url:[self.dict objectForKey:@"shareUrl"]];
}

- (void)collectArticles {

    [[Network_Discover new] postCollectThisArticlesWithId:self.articleId ResponseBlock:^(LLError *error) {
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            [self.view showToastMessage:@"收藏成功"];
        }
    }];
}

- (void)deleteArticles {

    [[Network_Discover new] deleteCollectThisArticlesWithId:self.articleId ResponseBlock:^(LLError *error) {
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            [self.view showToastMessage:@"取消收藏"];
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
