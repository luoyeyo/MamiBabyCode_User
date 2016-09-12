//
//  HospitalViewController.m
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/13.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "HospitalViewController.h"
#import "HP_HWorkItemCell.h"
#import "HP_VWorkItemCell.h"
#import "HP_BWorkItemCell.h"
#import "HospitalNameView.h"
#import "SDCycleScrollView.h"
#import "NetworkManager.h"
#import "HospitalListModel.h"
#import "WKHTMLViewController.h"
#import "HospitalListController.h"
#import "ReportCardViewController.h"
#import "ReportListViewController.h"

@interface HospitalViewController ()<UICollectionViewDelegate,UICollectionViewDataSource> {
    ItemGroupModel *_data;
    kUserState _currentState;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *v_lineWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *h_lineHeight;

@property (strong, nonatomic) IBOutlet UILabel *doctorLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollViewHeight;
// 未建档用户
@property (strong, nonatomic) IBOutlet UILabel *haveFile;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleHeight;
@property (strong, nonatomic) IBOutlet UIView *middleBaseView;
// 标记view上层的蒙版
@property (strong, nonatomic) IBOutlet UIButton *markBtn;

// 医生名字（中间）
@property (strong, nonatomic) IBOutlet UILabel *doctorNameMiddle;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *baseHeight;
@property (strong, nonatomic) IBOutlet UIImageView *rightAccessy;
// 医生view上层的蒙版
@property (strong, nonatomic) IBOutlet UIButton *doctorBtn;
// 重点标记视图
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *markViewHeight;
// 重点标记的视图
@property (strong, nonatomic) IBOutlet UIView *markView;
@property (strong, nonatomic) IBOutlet UIView *doctorLine;
// collection的高度
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *collectionHeight;
// nav的名称
@property (nonatomic,strong) HospitalNameView *titleView;

@property (strong, nonatomic) IBOutlet UIScrollView *baseScroll;
@property (strong, nonatomic) IBOutlet UIView *baseView;
// 顶部的轮播图
@property (strong, nonatomic) IBOutlet SDCycleScrollView *cycleImage;
// 检测次数
@property (strong, nonatomic) IBOutlet UILabel *checkNumLabel;
// 会员等级
@property (strong, nonatomic) IBOutlet UILabel *vipLevelLabel;

@property (strong, nonatomic) IBOutlet UIImageView *doctorAvatar;
@property (strong, nonatomic) IBOutlet UILabel *doctorName;
@property (strong, nonatomic) IBOutlet UILabel *doctorJob;
// 医生特长
@property (strong, nonatomic) IBOutlet UILabel *specialty;

// 下方放图标的
@property (strong, nonatomic) IBOutlet UICollectionView *workCollection;

- (IBAction)lookDoctorInfo:(UIButton *)sender;

@end

@implementation HospitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    // 因为首页能切换状态  所以每次进来看一下状态是否改变 是否需要刷新数据
    if (_currentState != kUserInfo.status) {
        [self initData];
    }
}

/**
 *  初始化数据
 */
- (void)initData {
    //判断是游客登陆还是注册用户登陆 (这里主要为了 区分用户的状态 分辨显示儿童还是妈妈)
    _currentState = kUserInfo.status;
    // 如果已经传入了医院信息  就获取这家医院的信息（只有未建档的医院才会出现这个）
    if (self.hospitalInfo) {
        //        self.navTitle.text = self.hospitalInfo.title;
        [self defaultConfig];
        [self getHospitalDetailsInfoWith:[NSString stringWithFormat:@"%ld",(long)self.hospitalInfo.Id]];
        [self isHaveFiles:self.hospitalInfo.isBookbuilding];
        self.backButton.hidden = NO;
        self.othersButton.hidden = YES;
        return;
    }
    if (kUserInfo.hospitalId && kUserInfo.hospitalId.length > 0) {
        // 用户有医院记录
        [self haveHospitalId];
    } else {
        [self notHaveHospitalId];
    }
}

#pragma mark - data source

// 设置分组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _data ? 1 : 0;
}

// 设置每个分组(section)的元素(cell)个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _data.groupOne.count + _data.groupTwo.count;
}
// 指定每个单元行返回的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // 从可重用队列中获取一个cell
    
    if (indexPath.row > 4) {
        HospitalItemModel *model = _data.groupTwo[indexPath.row - 5];
        HP_VWorkItemCell *cell2 = [collectionView dequeueReusableCellWithReuseIdentifier:@"HP_VWorkItemCell" forIndexPath:indexPath];
        cell2.model = model;
        if (indexPath.row == 7) {
            [self addBottomLine];
        }
        return cell2;
    }
    
    HospitalItemModel *model = _data.groupOne[indexPath.row];
    if (indexPath.row == 0) {
        HP_BWorkItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HP_BWorkItemCell" forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    HP_HWorkItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HP_HWorkItemCell" forIndexPath:indexPath];
    cell.model = model;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    HospitalItemModel *model;
    if (indexPath.row > 4) {
        model = _data.groupTwo[indexPath.row - 5];
    } else {
        model = _data.groupOne[indexPath.row];
    }
    if (model.iconInvalid || !model.iconValid) {
        if (model.reason && model.reason.length > 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:model.reason delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
            [alert show];
        }
        return;
    }
    [self pushHtmlVCWith:model.url];
}

- (void)lookHospitalLsit {
    [self performSegueWithIdentifier:@"HospitalListController" sender:nil];
}

- (IBAction)lookDoctorInfo:(UIButton *)sender {
    if (self.doctorName.text.length == 0) {
        return;
    }
    [self pushHtmlVCWith:kCurrentDoctorHTMLURL];
}

// 重点关注用户 (高危)
- (IBAction)focusOnUser:(UIButton *)sender {
    [self pushHtmlVCWith:kHighRiskHTMLURL];
}

- (void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHospital:) name:@"changeHospital" object:nil];
}

- (void)pushHtmlVCWith:(NSString *)urlStr {
    
    HospitalDetailsModel *details = [_data.list lastObject];
    
    // 如果有action=chanjian 就是去产检程序
    if ([urlStr ios7IsContainsString:@"action=chanjian"]) {
        ReportCardViewController *report = [[ReportCardViewController alloc] init];
        report.hospitalId = [NSString stringWithFormat:@"%ld",(long)details.hospitalId];
        report.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:report animated:YES];
        return;
    } else if ([urlStr ios7IsContainsString:@"action=erbao"]) {
        ReportCardViewController *report = [[ReportCardViewController alloc] init];
        report.hospitalId = [NSString stringWithFormat:@"%ld",(long)details.hospitalId];
        report.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:report animated:YES];
        return;
    } else if ([urlStr ios7IsContainsString:@"action=reports"]) {
        ReportListViewController *report = [[ReportListViewController alloc] init];
        report.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:report animated:YES];
        return;
    }
    
    WKHTMLViewController *html = [[WKHTMLViewController alloc] init];
    // 替换医院id
    NSString *url = [urlStr stringByReplacingOccurrencesOfString:@"{{hospitalId}}" withString:[NSString stringWithFormat:@"%ld",(long)details.hospitalId]];
    // 替换医生Id
    NSString *newUrl = [url stringByReplacingOccurrencesOfString:@"{{doctorId}}" withString:[NSString stringWithFormat:@"%ld",(long)details.doctorId]];
    WebItem *item = [WebItem createWebItemWithUrl:newUrl];
    html.hidesBottomBarWhenPushed = YES;
    html.webItem = item;
    html.info = details;
    [self.navigationController pushViewController:html animated:YES];
}

// 设置轮播图
- (void)setCycleImageWithArr:(NSArray *)arr urlArr:(NSArray *)urlArr {
    if (arr) {
        self.cycleImage.localizationImageNamesGroup = arr;
        self.cycleImage.infiniteLoop = NO;
    } else {
        self.cycleImage.imageURLStringsGroup = urlArr;
        self.cycleImage.infiniteLoop = urlArr.count == 1 ? NO : YES;
    }
    self.cycleImage.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.cycleImage.autoScrollTimeInterval = 4;
    self.cycleImage.currentPageDotColor = [UIColor colorFromHexRGB:@"f5728b"]; // 自定义分页控件小圆标颜色
    self.cycleImage.pageDotColor = [UIColor colorFromHexRGB:@"A6A6A6"]; // 自定义分页控件小圆标颜色
}

// 注册用户获取医院信息
- (void)getHospitalDetailsInfoWith:(NSString *)Id {
    self.baseView.hidden = YES;
    [self.view showPopupLoading];
    [[[Network_Hospital alloc] init] getHospitalDetailsInfoHospitalId:Id ResponseBlock:^(LLError *error, ItemGroupModel *info) {
        self.baseView.hidden = NO;
        [self.view hidePopupLoading];
        if (!error) {
            _data = info;
            [self setUserInfoInHospital];
            [self saveHospitalInfo];
        } else {
            // 如果本地有 先加载本地的
            if ([UserInfoEntity hospitalInfo]) {
                _data = [UserInfoEntity hospitalInfo];
                [self setUserInfoInHospital];
            } else {
                // 无数据页面
                self.baseView.hidden = YES;
            }
        }
    }];
}

- (void)defaultConfig {
    [self.workCollection registerNib:[UINib nibWithNibName:@"HP_HWorkItemCell" bundle:nil] forCellWithReuseIdentifier:@"HP_HWorkItemCell"];
    [self.workCollection registerNib:[UINib nibWithNibName:@"HP_VWorkItemCell" bundle:nil] forCellWithReuseIdentifier:@"HP_VWorkItemCell"];
    [self.workCollection registerNib:[UINib nibWithNibName:@"HP_BWorkItemCell" bundle:nil] forCellWithReuseIdentifier:@"HP_BWorkItemCell"];
    [self.navigationBarView addSubview:self.titleView];
    self.baseView.backgroundColor = [UIColor colorFromHexRGB:@"E4DFDF"];
    self.backButton.hidden = YES;
    self.othersButton.frame = CGRectMake(self.view.width - 75, 26, 75, 32);    
    self.othersButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -20);
    [self.othersButton setImage:[UIImage imageNamed:@"page1-topbar-icon-list"] forState:UIControlStateNormal];
    [self.othersButton addTarget:self action:@selector(lookHospitalLsit) forControlEvents:UIControlEventTouchUpInside];
    [self.view bringSubviewToFront:self.navigationBarView];
    [self addline];
}

- (void)saveHospitalInfo {
    // 当是已建档类型的时候  才储存
    if (self.hospitalInfo) {
        return;
    }
    [UserInfoEntity saveHospitalInfo:_data];
}

// 设置用户在医院的信息
- (void)setUserInfoInHospital {
    HospitalDetailsModel *details = [_data.list lastObject];
    NSString *title;
    NSString *logUrl;
    self.navTitle.text = @"";
    if (self.hospitalInfo) {
        title = self.hospitalInfo.title;
        logUrl = self.hospitalInfo.logo.medium;
    } else {
        title = details.hospitalName;
        logUrl = details.logo.medium;
    }
    [self.titleView.hospitalImage sd_setImageWithURL:[NSURL URLWithString:logUrl]];
    self.titleView.hospitalName.text = title;
    self.titleView.width = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}].width + 35;
    _titleView.center = CGPointMake(ScreenWidth / 2, _titleView.center.y);
    
    [self needToFocusOnUser:details.isRisk];
    self.checkNumLabel.text = [NSString stringWithFormat:@"已在本院产检%ld次",(long)details.count];
    self.vipLevelLabel.text = [NSString stringWithFormat:@"会员等级：%@",details.memberLevel];
    
    // 当医生没有职称   只显示中间的部分
    if (details.doctorTitle.length == 0) {
        self.doctorName.text = @"";
        self.doctorNameMiddle.text = details.doctorName;
        self.specialty.text = @"";
        self.doctorBtn.hidden = YES;
        self.doctorLine.hidden = YES;
        self.rightAccessy.hidden = YES;
        self.doctorJob.text = @"";
    } else {
        self.doctorName.text = details.doctorName;
        self.doctorJob.text = details.doctorTitle;
        self.doctorNameMiddle.text = @"";
        self.specialty.text = details.goodAt;
        self.doctorBtn.hidden = NO;
        self.doctorLine.hidden = NO;
        self.rightAccessy.hidden = NO;
        if (details.goodAt.length == 0) {
            self.doctorLine.hidden = YES;
        } else {
            self.doctorLine.hidden = NO;
        }
    }
    
    [self.doctorAvatar sd_setImageWithURL:[NSURL URLWithString:details.doctorImage.medium]];

    [self.workCollection reloadData];
    
    [[[Network_Hospital alloc] init] gethospitalsImagesWithHospitalsId:details.hospitalId ResponseBlock:^(LLError *error, NSArray *responseData) {
        if (!error) {
            NSMutableArray *arr = [NSMutableArray array];
            for (PhotoModel *model in responseData) {
                [arr addObject:model.real];
            }
            [self setCycleImageWithArr:nil urlArr:arr];
        } else {
        }
    }];
    [self changeUIWithUserStatus];
}

// 是否需要重点关注
- (void)needToFocusOnUser:(BOOL)isNeed {
    
    self.markViewHeight.constant = isNeed ? 40 : 0;
    self.markBtn.hidden = !isNeed;
    self.markView.hidden = !isNeed;
    self.middleHeight.constant = isNeed ? 151 : 111;
    if (self.hospitalInfo && self.hospitalInfo.isBookbuilding == NO) {
        self.middleHeight.constant = 30;
    }
}

// 普通用户 是否建档
- (void)isHaveFiles:(BOOL)isHave {
    self.middleBaseView.hidden = !isHave;
    self.middleHeight.constant = isHave ? 151 : 30;
    self.haveFile.hidden = isHave;
}

/**
 *  通过用户状态修改UI （宝宝、妈妈）
 */
- (void)changeUIWithUserStatus {
    
    switch (_currentState) {
        case kUserStateMum:
            self.checkNumLabel.text = [self.checkNumLabel.text stringByReplacingOccurrencesOfString:@"儿保" withString:@"产检"];
            //            self.importantLabel.text = @"您被标记为重点关注孕妇，请点击查看";
            self.doctorLabel.text = @"我的医生";
            break;
        default:
            self.checkNumLabel.text = [self.checkNumLabel.text stringByReplacingOccurrencesOfString:@"产检" withString:@"儿保"];
            self.doctorLabel.text = @"儿保医生";
            //            self.importantLabel.text = @"您的孩子被标记为重点关注高危儿童，请点击查看";
            // 儿童不需要显示高危
            [self needToFocusOnUser:NO];
            break;
    }
}

- (void)haveHospitalId {
    [self defaultConfig];
    // 如果本地有 先加载本地的
    if ([UserInfoEntity hospitalInfo]) {
        _data = [UserInfoEntity hospitalInfo];
        [self setUserInfoInHospital];
    }
    [self getHospitalDetailsInfoWith:kUserInfo.hospitalId];
}

- (void)notHaveHospitalId {
    self.navTitle.text = @"医院列表";
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HospitalListController *list = [story instantiateViewControllerWithIdentifier:@"HospitalListController"];
    [self addChildViewController:list];
    [self.view insertSubview:list.view belowSubview:self.navigationBarView];
    
    list.view.frame = CGRectMake(0, 40, ScreenWidth, ScreenHeight - 40 - 44);
    list.navigationBarView.hidden = YES;
    self.backButton.hidden = YES;
}

- (void)changeHospital:(NSNotification *)noti {
    HospitalEntryModel *model = noti.object;
    HospitalDetailsModel *currentHospital = [_data.list lastObject];
    if (model.Id == currentHospital.hospitalId) {
        return;
    }
    [self defaultConfig];
    [self getHospitalDetailsInfoWith:[NSString stringWithFormat:@"%ld",(long)model.Id]];
    [self isHaveFiles:model.isBookbuilding];
}

- (void)addline {
    // 第一根竖线
    [self.workCollection addLineWithColor:kColorLineDarkGray frame:CGRectMake(ScreenWidth / 2, 6, .5, ScreenWidth / 5 * 2 - 12)];
    //     第二个竖线
    [self.workCollection addLineWithColor:kColorLineDarkGray frame:CGRectMake(ScreenWidth / 4 * 3, 6, .5, ScreenWidth / 5 * 2 - 12)];
    //     横线
    [self.workCollection addLineWithColor:kColorLineDarkGray frame:CGRectMake(ScreenWidth / 2, ScreenWidth / 5, ScreenWidth / 2, .5)];
    self.v_lineWidth.constant = .5f;
    self.h_lineHeight.constant = .5f;
}

- (void)addBottomLine {
    // 根据 5 6 7.. 以上的每个行的规律 计算在那些高度加线  第一行开始加  所以 + 1
    NSInteger index = (10 - 4) / 2 - 1;
    // 设置控件高度
    self.collectionHeight.constant = ScreenWidth / 5 * 2 + 6 + index * 65;
    
    // 获取layout后的frame
    [self.workCollection setNeedsLayout];
    [self.workCollection layoutIfNeeded];
    
    if (CGRectGetMaxY(self.workCollection.frame) <= ScreenHeight - 64) {
        self.baseHeight.constant = ScreenHeight - 55;
    } else {
        self.baseHeight.constant = CGRectGetMaxY(self.workCollection.frame) + 20;
    }
    
    [self.workCollection addLineWithColor:kColorLineGray frame:CGRectMake(ScreenWidth / 2, ScreenWidth / 5 * 2 + 6 + 6, .5,65 * index - 12)];
    
    for (int i = 0; i < index; i ++) {
        [self.workCollection addLineWithColor:kColorLineGray frame:CGRectMake(0, ScreenWidth / 5 * 2 + 6 + 65 * i, ScreenWidth,.5)];
    }
}

- (HospitalNameView *)titleView {
    if (!_titleView) {
        CGFloat width = [self.hospitalInfo.title sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}].width + 35;
        _titleView = [HospitalNameView defaultClassNameNibViewWithFrame:CGRectMake(0, CGRectGetMinY(self.navTitle.frame), width, 44)];
        [_titleView.hospitalImage sd_setImageWithURL:[NSURL URLWithString:self.hospitalInfo.logo.medium]];
        _titleView.center = CGPointMake(ScreenWidth / 2, _titleView.center.y);
        _titleView.hospitalName.text = self.hospitalInfo.title;
    }
    return _titleView;
}

@end
