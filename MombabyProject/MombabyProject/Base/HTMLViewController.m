//
//  HTMLViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HTMLViewController.h"
#import <WebKit/WebKit.h>

@interface HTMLViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (strong, nonatomic) WKWebView *wkWeb;

@end

@implementation HTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.wkWeb];
    [self loadData];
    self.view.backgroundColor = kColorWhite;
    [self customNavgationBar];
    self.navTitle.text = self.title;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)loadData {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    [self.wkWeb loadRequest:request];
    [self.view showPopupLoading];
}

- (WKWebView *)wkWeb {
    if (!_wkWeb) {
        _wkWeb = [[WKWebView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44)];
        _wkWeb.UIDelegate = self;
        _wkWeb.navigationDelegate = self;
    }
    return _wkWeb;
}

#pragma mark - WKNavigationDelegate

//- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
//    NSString *urlstr = [NSString stringWithFormat:@"%@",webView.URL.absoluteString];
//    NSString *defaulturlstr = [NSString stringWithFormat:@"%@",self.webItem.defaultUrl];
//    if ([urlstr containsString:@"action=goback"]) {
//        [self.navigationController popViewControllerAnimated:YES];
//        return;
//    }
//    // 如果默认的相同  不跳转
//    if ([urlstr isEqualToString:defaulturlstr]) {
//        return;
//    }
//    [self pushHtmlWithUrl:urlstr];
//    [webView stopLoading];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
//}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    [self.view hidePopupLoading];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.view hidePopupLoading];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.view hidePopupLoading];
    // 手动终止的错误码是-999
    [self.view showToastMessage:@"数据加载失败"];
    self.wkWeb.hidden = YES;
//    [self.view addSubview:self.noRespon];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    self.wkWeb.hidden = YES;
    [self.view showToastMessage:@"数据加载失败"];
}


@end
