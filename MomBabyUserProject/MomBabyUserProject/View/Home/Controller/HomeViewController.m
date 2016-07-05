//
//  HomeViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/2.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "HomeViewController.h"
#import "GuideInfoTableView.h"
#import "UserStateInfoView.h"
#import "SelectBabyView.h"
#import "MessageViewController.h"
#import "TimeLineCollectionView.h"
#import "SelfViewController.h"
#import "BillboardView.h"

@interface HomeViewController ()<UIScrollViewDelegate,TimeLineDidChangeDelegate> {
    Input_params *_params;
}
// 顶部背景图的高度约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageHight;
// 顶部背景图距离top约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageTopLayout;
// 今天按钮
@property (strong, nonatomic) IBOutlet UIButton *todayBtn;
// 头像背后的动画图层
@property (strong, nonatomic) IBOutlet UIImageView *animateView;
// 选择宝宝的箭头
@property (strong, nonatomic) IBOutlet UIButton *selectBabyBtn;
// 指导信息列表
@property (strong, nonatomic) GuideInfoTableView *guideInfoTab;
// 头像
@property (strong, nonatomic) IBOutlet UIImageView *avatarView;
// 底层view
@property (strong, nonatomic) IBOutlet UIView *baseView;
// scrollview
@property (strong, nonatomic) IBOutlet UIScrollView *baseScrollView;
// 姓名
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
// 中间的view
@property (strong, nonatomic) IBOutlet UIView *middleBaseView;
// 整个底层view的高度约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *baseViewHeight;
// 显示用户的3条数据
@property (strong, nonatomic) IBOutlet UserStateInfoView *userInfoView;
// 中间的时间显示
@property (strong, nonatomic) IBOutlet UILabel *currentDate;
// 时间轴
@property (strong, nonatomic) IBOutlet TimeLineCollectionView *timeLine;

- (IBAction)showSelectBabyView:(UIButton *)sender;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.baseView addSubview:self.guideInfoTab];
    [self addAnimation];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self removeAnimation];
}

- (void)initializeAppearance {
    [self customNavgationBar];
    self.backButton.hidden = YES;
    self.navTitle.text = @"妈咪Baby";
    self.navigationBarView.backgroundColor = kColorClear;
    self.othersButton.hidden = NO;
    // 登陆后显示消息btn
    if (kUserInfo.isLogined) {
        [self.othersButton setImage:ImageNamed(@"page1-topbar-icon-news_n") forState:UIControlStateNormal];
    }
    [self.othersButton addTarget:self action:@selector(showMessagePage) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToChangeUserInfoVC)];
    [self.avatarView addGestureRecognizer:tag];
    self.avatarView.userInteractionEnabled = YES;
}

- (void)initializeDataSource {
        
    _params = [Input_params new];
    _params.page = @1;
    _params.limit = @100;
    self.timeLine.timeLineDidChangeDelegate = self;
    
    [self setUserInfo];
    // 判断是游客登陆还是注册用户登陆
    if (kUserInfo.isLogined) [kUserInfo updateUserInfo];
    // 获取数据
//    [self requestUserHomeData];
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUserInfo) name:kNotiModifyUserInfo object:nil];
}

/**
 *  获取首页数据
 */
- (void)requestUserHomeData {
    [self.view showPopupLoading];
    [kShareManager_Home getHomeInfoWithParams:_params responseBlock:^(LLError *error) {
        [self.view hidePopupLoading];
        if (!error) {
            [self setUIContent];
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

- (void)setUserInfo {
    [self.userInfoView updateInfo];
    
    if (kUserInfo.isLogined) {
        // 头像
        NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userIcon"];
        if (imageData != nil) {
            self.avatarView.image = [UIImage imageWithData:imageData];
        } else {
            [self.avatarView sd_setImageWithURL:[NSURL URLWithString:kUserInfo.avatar.real] placeholderImage:kDefalutAvatar];
        }
        self.selectBabyBtn.hidden = NO;
        if (kUserInfo.status == kUserStateMum) {
            self.nameLabel.text = kUserInfo.nickname;
        } else {
            self.nameLabel.text = kUserInfo.currentBaby.nickname;
        }
    } else {
        if (kUserInfo.status == kUserStateMum) {
            self.nameLabel.text = @"游客用户";
            
        } else {
            self.nameLabel.text = kUserInfo.currentBaby.nickname;
        }
    }
}

- (void)setUIContent {
    // 数据源在单例中直接取
    [self.guideInfoTab reloadData];
    // 计算高度
    self.guideInfoTab.height = self.guideInfoTab.tableHeight;
    self.baseViewHeight.constant = CGRectGetMaxY(self.guideInfoTab.frame);;
}

- (IBAction)showSelectBabyView:(UIButton *)sender {
    SelectBabyView *view = [SelectBabyView defaultClassNameNibViewWithFrame:kAppDelegate.window.bounds];
    WS(weakSelf);
    [view setSelectBabyBlock:^(NSInteger index) {
        kUserInfo.currentBaby = kUserInfo.babys[index];
        [kUserInfo synchronize];
        [weakSelf setUserInfo];
    }];
    [view show];
}

- (IBAction)backToToday:(UIButton *)sender {
//    [self.timeLine today];
    [BillboardView billboardViewWithImage:nil imageUrl:@"http://pic16.nipic.com/20110827/2127531_105629251000_2.jpg" clickBlock:nil];
    
}

- (void)showMessagePage {
    MessageViewController *message = [[MessageViewController alloc] init];
    message.hidesBottomBarWhenPushed = YES;
    [self pushViewController:message];
}

- (void)jumpToChangeUserInfoVC {
    if (kUserInfo.isLogined) {
        SelfViewController *mySelfTableVC = [[SelfViewController alloc] init];
        mySelfTableVC.hidesBottomBarWhenPushed = YES;
        [self pushViewController:mySelfTableVC];
    }
}

- (void)addAnimation {
    CABasicAnimation *animate = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animate.toValue = @(M_PI * 2);
    animate.duration = 4;
    animate.repeatCount = MAXFLOAT;
    [self.animateView.layer addAnimation:animate forKey:@"transform.rotation"];
}

- (void)removeAnimation {
    [self.animateView.layer removeAnimationForKey:@"transform.rotation"];
}

#pragma mark - delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.y > 10) {
        self.navigationBarView.hidden = YES;
    } else {
        self.navigationBarView.hidden = NO;
    }
    if (offset.y < 0) {
        // 350 是顶部背景图的固定高度
        CGFloat height = 350 - offset.y;
        self.imageHight.constant = height;
        self.imageTopLayout.constant = offset.y;
    }
}
// timeLineDidChangedelegate
- (void)timeLineDidChangeToDay:(CalendarDayModel *)currentDay {
    self.currentDate.text = [NSString stringWithFormat:@"%ld月%ld日",currentDay.month,currentDay.day];
    NSString *currentTimeStr = [NSString stringWithFormat:@"%@",@([currentDay date].timeIntervalSince1970)];
    if (kUserInfo.status == kUserStateMum) {
        // 传入妈妈怀孕天数
        if (kUserInfo.isLogined) {
            // 妈妈怀孕天数
            _params.days = [NSString stringWithFormat:@"%d",[currentTimeStr getVipNumberDay:[NSString stringWithFormat:@"%@",kUserInfo.lastMenses]]];
        } else {
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSDate * yuChanQiDate = [dateFormatter dateFromString:kUserInfo.dueDateStr];
            //得到末次月经
            NSDate * moCiDate = [yuChanQiDate getMensesDate];
            //游客  手机时间减去末次月经 得到 怀孕天数
            _params.days = [NSString stringWithFormat:@"%d",[moCiDate getHuaiYunNumberDay]];
        }
    } else {
        // 传入出生了多少天
        GestationalWeeks *day = [NSDate calculationIntervalWeeksWithStart:kUserInfo.currentBaby.birth.doubleValue end:[currentDay date].timeIntervalSince1970];
        _params.days = [NSString stringWithFormat:@"%@",day.allDay];
    }
    [self requestUserHomeData];
}

- (GuideInfoTableView *)guideInfoTab {
    if (!_guideInfoTab) {
        _guideInfoTab = [[GuideInfoTableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.middleBaseView.frame) + 5, ScreenWidth, 300)];
        _guideInfoTab.scrollEnabled = NO;
        WS(weakself);
        [_guideInfoTab setSelectCellBlock:^(NSInteger index){
            kShareManager_Home.currentArticleId = kShareManager_Home.homeInfo.list[index];
            [weakself performSegueWithIdentifier:@"GuideInfoViewController" sender:weakself];
        }];
    }
    return _guideInfoTab;
}
@end
