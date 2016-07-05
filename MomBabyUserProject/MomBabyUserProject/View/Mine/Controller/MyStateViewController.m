//
//  MyStateViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/20.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "MyStateViewController.h"
#import "AddBtnView.h"

// 我怀孕了
#import "SetDueDateViewController.h"
// 家有宝贝
#import "HaveBabyViewController.h"



@interface MyStateViewController () <UIActionSheetDelegate>
{
    AddBtnView * _dueDateView;
    AddBtnView * _withChild;
    
    UITextField * _statureTextF;
    UITextField * _kgTextF;
}

@property (nonatomic, copy) NSString * dueDate;
@property (nonatomic, copy) NSString * babyNickname;


@property (nonatomic, copy) NSString * defaultDate;

@end

@implementation MyStateViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"修改个人状态"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"修改个人状态"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavgationBar];
    self.navTitle.text = @"修改个人状态";
    [self createUI];
}

- (void)createUI
{
    self.view.backgroundColor = COLOR_C4;
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.defaultDate = [dateFormatter stringFromDate:[NSDate date]];
    
    CGFloat dueDateX = 0;
    CGFloat dueDateY = 64;
    CGFloat dueDateW = ScreenWidth;
    CGFloat dueDateH = 44;
    
    _dueDateView = [[AddBtnView alloc] initWithFrame:CGRectMake(dueDateX, dueDateY, dueDateW, dueDateH)];
    _dueDateView.leftLabel.text = @"我怀孕了";
    [_dueDateView.AddButton addTarget:self action:@selector(dueDateAciton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dueDateView];
    
//    UserInfoEntity *user = kUserInfo;
    CGFloat withChildX = 0;
    CGFloat withChildY = 64 + dueDateH;
    CGFloat withChildW = ScreenWidth;
    CGFloat withChildH = dueDateH;
    _withChild = [[AddBtnView alloc] initWithFrame:CGRectMake(withChildX, withChildY, withChildW, withChildH)];
    _withChild.leftLabel.text = @"家有宝贝";
    [_withChild.AddButton addTarget:self action:@selector(withChildAciton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_withChild];
    
    // 会员用户和注册用户
    if (kUserInfo.isLogined) {
        if (kUserInfo.status == kUserStateMum) {
            if (kUserInfo.dueDate != 0) {
                NSString *userDueDate = [NSDate dateStringWithTimeInterval:kUserInfo.dueDate formatterStr:@"yyyy-MM-dd"];
                self.dueDate = userDueDate;
                _dueDateView.rightLabel.text = [NSString stringWithFormat:@"预产期:%@", self.dueDate];
            }
            else
            {
                _dueDateView.rightLabel.text = [NSString stringWithFormat:@"预产期:%@",self.defaultDate];
            }
            _withChild.rightLabel.text = @"";
        }
        else
        {
            _dueDateView.rightLabel.text = @"";
            
            if (kUserInfo.currentBaby.nickname.length != 0) {
                _withChild.rightLabel.text = [NSString stringWithFormat:@"%@", kUserInfo.currentBaby.nickname];
            }
            else
            {
                _withChild.rightLabel.text = @"";
            }
        }
    }
    else  // 游客状态
    {
        if (kUserInfo.dueDateStr && kUserInfo.dueDateStr.length != 0) {
            _dueDateView.rightLabel.text = [NSString stringWithFormat:@"预产期:%@", kUserInfo.dueDateStr];
            _withChild.rightLabel.text = @"";
        }
        else
        {
            BabyInfoModel *babyInfo = kUserInfo.currentBaby;
            _dueDateView.rightLabel.text = @"";
            _withChild.rightLabel.text = babyInfo.nickname;
        }
        
    }
    
}
// 孕产期点击事件
- (void)dueDateAciton
{
    if (kUserInfo.isLogined) {
        
        if (kUserInfo.userType == kUserTypeNormal) {
            SetDueDateViewController *setDueDate = [[SetDueDateViewController alloc] init];
            if (kUserInfo.dueDate != 0) {
                setDueDate.timeStr = self.dueDate;
            }
            else
            {
                setDueDate.timeStr = self.defaultDate;
            }
            [self.navigationController pushViewController:setDueDate animated:YES];
        }
        else
        {
            _dueDateView.userInteractionEnabled = NO;
           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                               message:@"会员用户请到注册医院修改资料"
                                                              delegate:self
                                                     cancelButtonTitle:@"确定"
                                                     otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else
    {
        SetDueDateViewController *setDueDate = [[SetDueDateViewController alloc] init];
        if (kUserInfo.dueDateStr) {
            setDueDate.timeStr = kUserInfo.dueDateStr;
        } else {
            setDueDate.timeStr = self.defaultDate;
        }
        [self.navigationController pushViewController:setDueDate animated:YES];
    }
}

// 家有宝贝点击事件
- (void)withChildAciton
{
    if (kUserInfo.isLogined) {
        
        if (kUserInfo.userType == kUserTypeNormal) {
            HaveBabyViewController *haveBaby = [[HaveBabyViewController alloc] init];
            [self.navigationController pushViewController:haveBaby animated:YES];
        }
        else
        {
            _withChild.userInteractionEnabled = NO;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"会员用户请到注册医院修改资料"
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
    else
    {
        HaveBabyViewController *haveBaby = [[HaveBabyViewController alloc] init];
        [self.navigationController pushViewController:haveBaby animated:YES];
    }

}



@end
