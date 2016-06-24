//
//  MainViewController.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () {
    BOOL _animateComplete;
}

@end

@implementation MainViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if (self.navigationController.viewControllers.count == 2) {
            
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        if (self.navigationController.viewControllers.count == 1) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}


-(void)Back
{
    if(self.navigationController.visibleViewController == [self.navigationController.viewControllers firstObject]
       &&self.navigationController.visibleViewController == self)
    {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
        }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    [self createNavBar];
    _animateComplete = YES;
    [self registerNotification];
}

- (void)registerNotification {
    
}

- (void)createNavBar{
    
    self.navigationBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    self.navigationBarView.backgroundColor = kColorTheme;
    [self.view addSubview:self.navigationBarView];
    
    self.navTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, self.view.width, 44)];
    self.navTitle.font = [UIFont systemFontOfSize:20];
    self.navTitle.textColor = [UIColor colorFromHexRGB:@"ffffff"];
    self.navTitle.textAlignment = NSTextAlignmentCenter;
    [self.navigationBarView addSubview:self.navTitle];
    
    self.othersButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.othersButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.othersButton.titleLabel.font = [UIFont systemFontOfSize:15];
    self.othersButton.frame = CGRectMake(self.view.width - 77, 33, 70, 20);
    [self.navigationBarView addSubview:self.othersButton];
    
    // 142 100
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(10, 21, 61, 43);
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"backImageTwo"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(Back) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView addSubview:self.backButton];
}

//- (void)backButtonAction{
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)hiddenNavBar {
    if (!_animateComplete) return;
    [UIView animateWithDuration:0.2 animations:^{
        _animateComplete = NO;
        self.navigationBarView.transform = CGAffineTransformMakeTranslation(0, -self.navigationBarView.height);
    } completion:^(BOOL finished) {
        _animateComplete = YES;
    }];
}

- (void)showNavBar {
    if (!_animateComplete) return;
    [UIView animateWithDuration:0.2 animations:^{
        _animateComplete = NO;
        self.navigationBarView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        _animateComplete = YES;
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
