//
//  MineViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/3/14.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "MineViewController.h"
#import "MineInfoCell.h"
#import "UserDefaults.h"
#import "SettingListCell.h"
#import "MyFavouriteViewController.h"
#import "MyStateViewController.h"
#import "SelfViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *_titleArr;
    UIImageView *_header;
    MineInfoCell *mineInfocell;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UILabel *logout;
- (void)editMyInfo:(UIButton *)sender;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArr = @[@"更换绑定手机",@"信息反馈",@"关于我们"];
    _header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    _header.image = ImageNamed(@"page1_BG_line");
    _header.contentMode = UIViewContentModeScaleToFill;
    [self.tableView addSubview:_header];
    [self NavRightButton];
}

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setUserInfo) name:kNotiModifyUserInfo object:nil];
}

/**
 *  设置导航栏左按钮  并放大热点区域
 */
- (void)NavRightButton {
    [self customNavgationBar];
    
    self.navigationBarView.backgroundColor = kColorClear;
    
    self.othersButton.hidden = !kUserInfo.isLogined;
    [self.othersButton setImage:ImageNamed(@"mine_page1_icon_edit") forState:UIControlStateNormal];
    self.backButton.hidden = YES;
    [self.othersButton addTarget:self action:@selector(editMyInfo:) forControlEvents:UIControlEventTouchUpInside];
//    CGRect frame = CGRectMake(0, 0, 100, 44);
//    UIButton *defaultRightButton = [[UIButton alloc]initWithFrame:frame];
//    ClearBackgroundColor(defaultRightButton);
//    defaultRightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [defaultRightButton setImage:ImageNamed(@"mine_page1_icon_edit") forState:UIControlStateNormal];
//    [defaultRightButton addTarget:self action:@selector(editMyInfo:) forControlEvents:UIControlEventTouchUpInside];
//    [self setNavBarRightView:defaultRightButton];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 2;
    } else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 250;
    }
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section > 0) {
        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        mineInfocell = [tableView dequeueReusableCellWithIdentifier:@"MineInfoCell"];
        [mineInfocell.contentView addLineTo:kFrameLocationBottom color:kColorLineGray];
        [self setUserInfo];
        return mineInfocell;
    } else if (indexPath.section == 0) {
        SettingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingListCell"];
        cell.title.text = @"修改我的状态";
        cell.icon.image = ImageNamed(@"page1_icon_revise");
        cell.pregnancyLabel.text = kUserInfo.status == kUserStateMum ? @"孕期" : @"家有宝贝";
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        return cell;
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        SettingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingListCell"];
        cell.title.text = @"我的收藏";
        cell.icon.image = ImageNamed(@"page1_icon_collection");
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        return cell;
    } else if (indexPath.row == 1) {
        SettingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingListCell"];
        cell.title.text = @"邀请好友";
        cell.icon.image = ImageNamed(@"page1_icon_invitation");
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        return cell;
    } else {
        SettingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingListCell"];
        cell.title.text = @"设置";
        cell.icon.image = ImageNamed(@"page1_icon_set_up");
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        return cell;
    }
}

- (UITableViewCell *)makeDefaultCellWithIdentifier:(NSString *)identitifer {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identitifer];
    cell.textLabel.textColor = [UIColor colorFromHexRGB:@"979797"];
    cell.textLabel.font = SystemFont(14);
    cell.detailTextLabel.textColor = [UIColor colorFromHexRGB:@"BABABA"];
    cell.detailTextLabel.font = SystemFont(12);
    [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageNamed(@"small_arrow-n")];
    imageView.frame = CGRectMake(0, 0, 16, 16);
    cell.accessoryView = imageView;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 1) {
        MyStateViewController *state = [[MyStateViewController alloc] init];
        [self pushViewController:state];
    } else if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"SettingViewController" sender:nil];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        if (kUserInfo.isLogined) {
            MyFavouriteViewController *vc = [[MyFavouriteViewController alloc] init];
            [self pushViewController:vc];
        } else {
            [kAppDelegate toPresentLogin];
        }
    } else if (indexPath.row == 1) {
        // 要请好友
        [ShareManager shareTitle:@"点击下载妈咪-Baby" text:@"点击下载妈咪-Baby" url:kShareUrl];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = _header.frame;
        rect.origin.y = offset.y;
        rect.size.height = 0 - offset.y;
        _header.frame = rect;
    }
//    if (offset.y > 10) {
//        self.navigationController.navigationBar.hidden = YES;
//    } else {
//        self.navigationController.navigationBar.hidden = NO;
//    }
}

- (void)editMyInfo:(UIButton *)sender {
    SelfViewController *vc = [[SelfViewController alloc] init];
    [self pushViewController:vc];
}

- (void)setUserInfo {
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userIcon"];
    if (imageData) {
        mineInfocell.avatar.image = [UIImage imageWithData:imageData];
    } else {
        [mineInfocell.avatar sd_setImageWithURL:[NSURL URLWithString:kUserInfo.avatar.medium] placeholderImage:kDefalutAvatar];
    }
    mineInfocell.name.text = kUserInfo.nickname;
}

- (UILabel *)logout {
    if (!_logout) {
        _logout = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _logout.text = @"退出登录";
        _logout.textAlignment = NSTextAlignmentCenter;
        _logout.textColor = [UIColor colorFromHexRGB:@"ff717f"] ;
        _logout.font = SystemFont(15);
        _logout.backgroundColor = kColorWhite;
    }
    return _logout;
}
@end
