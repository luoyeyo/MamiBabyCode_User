//
//  ViewController.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/3/7.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQKeyboardReturnKeyHandler.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UIView *navigationBarView;
@property (nonatomic, strong) UILabel *navTitle;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *othersButton;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;

- (void)initializeAppearance;
/**
 *  初始化数据
 */
- (void)initializeDataSource;
- (void)registerNotifications;
- (void)customNavgationBar;
@end

