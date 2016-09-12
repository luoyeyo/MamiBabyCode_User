//
//  ReportViewController.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/28.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "ReportView.h"
//#define kReportDetailsHTMLUrl @"http://doctor.api.stage.healthbaby.com.cn/v1/reports/"

@interface ReportView ()<UIWebViewDelegate> {
    BOOL _isRefresh;
}

@property (nonatomic, strong) UIButton *cancelBtn;

@end

@implementation ReportView

- (void)viewDidLoad {
    NSString *urlStr = [NSString stringWithFormat:@"%@/v1/reports/%ld",kServerBaseUrl,self.reportId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
}

+ (ReportView *)defaultReportView {
    ReportView *re = [[ReportView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    return re;
}

- (UIWebView *)webView {
    if (_webView == nil) {
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.scrollView.bounces = NO;
        _webView.delegate = self;
        _webView.backgroundColor = kColorBackground;
        [self addSubview:_webView];
    }
    return _webView;
}

- (UIButton *)cancelBtn {
    if (_cancelBtn == nil) {
        _cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49)];
        _cancelBtn.backgroundColor = kColorTheme;
        _cancelBtn.alpha = 0.7;
        [_cancelBtn setTitle:@"关 闭" forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = SystemFont(19);
        [_cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)dismiss {
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeScale(0.1,0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show {
    [kAppDelegate.window addSubview:self];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    self.transform = CGAffineTransformMakeScale(0.2, 0.2);
    [self viewDidLoad];
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.webView showPlaneLoading];
    _isRefresh = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView hidePlaneLoading];
    [self.webView addSubview:self.cancelBtn];
    _isRefresh = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.webView hidePlaneLoading];
    [self.webView showPlaneMessage:@"数据加载失败"];
    _isRefresh = NO;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 获取url
    return YES;
}

@end
