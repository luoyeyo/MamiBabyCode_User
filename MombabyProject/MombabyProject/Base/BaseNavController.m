//
//  BaseNavController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/28.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                      NSFontAttributeName: [UIFont boldSystemFontOfSize:18]}];
    [self.navigationBar setBackIndicatorImage:ImageNamed(@"backItem")];
    [self.navigationBar setBackIndicatorTransitionMaskImage:ImageNamed(@"backItem")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && !self.view.window) {
        self.view = nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
//    view.backgroundColor = [UIColor redColor];
//    backItem.customView = view;
    backItem.imageInsets = UIEdgeInsetsMake(20, 20, 20, 20);
    [viewController.navigationItem setBackBarButtonItem:backItem];
}

@end
