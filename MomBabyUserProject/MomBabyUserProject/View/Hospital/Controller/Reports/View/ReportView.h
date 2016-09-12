//
//  ReportViewController.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/28.
//  Copyright © 2016年 iMac. All rights reserved.
//

/**
 *  报告详情html
 */
@interface ReportView : UIView
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) NSInteger reportId;

+ (ReportView *)defaultReportView;
- (void)dismiss;
- (void)show;
@end
