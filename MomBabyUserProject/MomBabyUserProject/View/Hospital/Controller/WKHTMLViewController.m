//
//  WKHTMLViewController.m
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/15.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "WKHTMLViewController.h"
#import <WebKit/WebKit.h>
#import "NoResponseView.h"

@interface WKHTMLViewController ()<WKNavigationDelegate,WKUIDelegate,NoResponseViewDelegate,UIWebViewDelegate>

@property (strong, nonatomic) NoResponseView *noRespon;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong, nonatomic) WKWebView *wkWebView;
@property (strong, nonatomic) UIWebView *webView;
@property (assign, nonatomic) NSUInteger loadCount;

@end

@implementation WKHTMLViewController

- (void)dealloc {
    // 必须移除 否则会崩溃
    [_wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.webItem) {
        self.navTitle.text = self.webItem.labelTitle;
        if ([self.webItem.labelTitle ios7IsContainsString:@"儿童检查报告"]) {
            self.webItem.defaultUrl = [self.webItem.defaultUrl stringByAppendingString:@"userStatus=2"];
        }
        if (self.webItem.labelItemUrl && self.webItem.labelItemTitle) {
            [self.othersButton setTitle:self.webItem.labelItemTitle forState:UIControlStateNormal];
            [self.othersButton addTarget:self action:@selector(clickOtherBtn) forControlEvents:UIControlEventTouchUpInside];
        }
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.webItem.defaultUrl]];
        [self addHeader:request];
        
        if (SystemVersion >= 8.0) {
            [self.view showPopupLoading];
            [self.wkWebView loadRequest:request];
        } else {
            [self.webView loadRequest:request];
        }
        [self.view showPopupLoading];
    }
    //    [_web loadHTMLString:nil baseURL:nil];
    //    [_web loadData:nil MIMEType:nil characterEncodingName:nil baseURL:nil];
}

- (void)clickOtherBtn {
    [self pushHtmlWithUrl:self.webItem.labelItemUrl];
}

- (void)addHeader:(NSMutableURLRequest *)request {
    
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];//这个很关键，一定要设置
    [request setValue:kUserInfo.token forHTTPHeaderField:@"Authorization"];
    [request setValue:@"ios" forHTTPHeaderField:@"Platform"];
    [request setValue:[UIDevice currentDevice].systemVersion forHTTPHeaderField:@"Os-Version"];
    [request setValue:[NSString stringWithFormat:@"%d",locationVersion] forHTTPHeaderField:@"VersionNum"];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSString *urlstr = [NSString stringWithFormat:@"%@",webView.URL.absoluteString];
    NSString *defaulturlstr = [NSString stringWithFormat:@"%@",self.webItem.defaultUrl];
    if ([urlstr ios7IsContainsString:@"action=goback"]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    // 如果默认的相同  不跳转
    if ([urlstr isEqualToString:defaulturlstr]) {
        return;
    }
    [self pushHtmlWithUrl:urlstr];
    [webView stopLoading];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    // 手动终止的错误码是-999
    if (error.code == -999) {
        return;
    }
    [self.view addSubview:self.noRespon];
}

- (void)pushHtmlWithUrl:(NSString *)urlStr {
    WKHTMLViewController *web = [[WKHTMLViewController alloc] init];
    // 替换医院id
    NSString *url = [urlStr stringByReplacingOccurrencesOfString:@"{{hospitalId}}" withString:[NSString stringWithFormat:@"%ld",(long)self.info.hospitalId]];
    // 替换医生Id
    NSString *newUrl = [url stringByReplacingOccurrencesOfString:@"{{doctorId}}" withString:[NSString stringWithFormat:@"%ld",(long)self.info.doctorId]];
    // 因为item的Url可能带参数 需要再次解析
    WebItem *item = [WebItem createWebItemWithUrl:newUrl];
    web.webItem = item;
    [self.navigationController pushViewController:web animated:YES];
}

// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == _wkWebView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.view hidePopupLoading];
        }
    }
}
/**
 *  再次加载
 */
- (void)onceAgain {
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.webItem.defaultUrl]];
    [self addHeader:request];
    [self.noRespon removeFromSuperview];
    if (SystemVersion >= 8.0) {
        [self.wkWebView loadRequest:request];
    } else {
        [self.webView loadRequest:request];
    }
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *urlstr = [request.URL.absoluteString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSString *defaulturlstr = [[NSString stringWithFormat:@"%@",self.webItem.defaultUrl] stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if ([urlstr ios7IsContainsString:@"action=goback"]) {
        [webView stopLoading];
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    // 如果默认的不相同  跳转
    if (![urlstr isEqualToString:defaulturlstr]) {
        [self pushHtmlWithUrl:request.URL.absoluteString];
        [webView stopLoading];
        return NO;
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.view hidePopupLoading];
    webView.scrollView.contentSize = CGSizeMake(ScreenWidth, webView.scrollView.contentSize.height);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    if (SystemVersion >= 8.0) {
        [self.wkWebView removeFromSuperview];
        self.wkWebView = nil;
    } else {
        [self.webView removeFromSuperview];
        self.webView = nil;
    }
    [self.view addSubview:self.noRespon];
    [self.view hidePopupLoading];
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 20)];
        _progressView.tintColor = [UIColor colorFromHexRGB:@"FBAEAF"];
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (NoResponseView *)noRespon {
    if (!_noRespon) {
        _noRespon = [[NoResponseView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.bounds.size.height)];
        _noRespon.delegate = self;
    }
    return _noRespon;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth + 1, ScreenHeight - 64)];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [self.view addSubview:_wkWebView];
    }
    return _wkWebView;
}

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
