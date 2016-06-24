//
//  HomeTabbarController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/3/17.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HomeTabbarController.h"

@implementation HomeTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 配置tabbar图片
    NSArray *itemImages = @[@"首页默认", @"医院默认", @"发现默认",@"我的默认"];
    NSArray *itemSelectImages = @[@"首页选择", @"医院选择", @"发现选择",@"我的选择"];
    for (int i = 0; i < self.tabBar.items.count; i ++) {
        UITabBarItem *item = self.tabBar.items[i];
        [item setImage:[[UIImage imageNamed:itemImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[[UIImage imageNamed:itemSelectImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:@"Helvetica" size:8], NSFontAttributeName, nil]
                            forState:UIControlStateNormal];
    }
    // 配置tabbar 文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorTheme,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"nav_bar_background_transparent"]];
    [self.tabBar setShadowImage:[UIImage imageWithColor:kColorLineGray]];
    self.tabBar.backgroundColor = [UIColor clearColor];
}

@end
