//
//  HTMLViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/5/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HTMLViewController.h"
#import <WebKit/WebKit.h>

@interface HTMLViewController ()<WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate>

@property (strong, nonatomic) WKWebView *wkWeb;
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation HTMLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
    if (SystemVersion >= 8.0) {
        [self.view addSubview:self.wkWeb];
        [self.wkWeb loadRequest:request];
    } else {
        [self.view addSubview:self.webView];
        [self.webView loadRequest:request];
    }
    [self.view showPopupLoading];
    self.view.backgroundColor = kColorWhite;
    [self customNavgationBar];
    self.navTitle.text = self.title;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44)];
        _webView.delegate = self;
    }
    return _webView;
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

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.view showPopupLoading];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view hidePopupLoading];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [self.view hidePopupLoading];
    [self.view showToastMessage:@"数据加载失败"];
}

@end
