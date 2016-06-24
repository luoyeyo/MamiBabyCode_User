//
//  MainViewController.h
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView * navigationBarView;
@property (nonatomic, strong) UILabel * navTitle;
@property (nonatomic, strong) UIButton * backButton;
@property (nonatomic, strong) UIButton * othersButton;

- (void)registerNotification;

- (void)hiddenNavBar;

- (void)showNavBar;
@end
