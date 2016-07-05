//
//  TableViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/12.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //默认导航栏左按钮
    [self initializeDataSource];
    [self initializeAppearance];
}

/**
 *  初始化界面
 */
- (void)initializeAppearance {
    
}

/**
 *  初始化数据
 */
- (void)initializeDataSource {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window) {
        self.view = nil;
        [self unregisterNotifications];
    }
}

#pragma mark - 通知相关

- (void)registerNotifications
{
    
}

- (void)unregisterNotifications
{
    
}

#pragma mark - 导航栏

@end
