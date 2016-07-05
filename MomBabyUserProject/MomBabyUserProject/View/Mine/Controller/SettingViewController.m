//
//  SettingViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/8.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "SettingViewController.h"
#import "SelfViewController.h"

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavgationBar];
    self.navTitle.text = @"设置";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [self createSettingCellWithTitle:@"修改绑定手机"];
        return cell;
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [self createSettingCellWithTitle:@"意见反馈"];
            [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
            return cell;
        } else if (indexPath.row == 1) {
            UITableViewCell *cell = [self createSettingCellWithTitle:@"清除缓存"];
            [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.1fMB", [self getCancheSize]];
            return cell;
        } else {
            UITableViewCell *cell = [self createSettingCellWithTitle:@"关于妈咪baby"];
            return cell;
        }
    } else {
        UITableViewCell *cell = [self logoutCell];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self performSegueWithIdentifier:@"ChangePhoneController" sender:nil];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"FeedbackController" sender:nil];
    } else if (indexPath.section == 2) {
        // 退出登录
        [kUserInfo exitUser];
        [kAppDelegate toChooseUserState];
    } else if (indexPath.section == 1 && indexPath.row == 2) {
        [self performSegueWithIdentifier:@"AboutViewController" sender:nil];
    } else if (indexPath.row == 1) {
        RIButtonItem *item = [RIButtonItem itemWithLabel:@"确定" action:^{
            [self cleanCanche];
        }];
        RIButtonItem *cancel = [RIButtonItem itemWithLabel:@"取消" action:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"你确定要清理缓存吗" cancelButtonItem:cancel otherButtonItems:item, nil];
        [alert show];
    }
}

- (UITableViewCell *)createSettingCellWithTitle:(NSString *)title {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = title;
    cell.textLabel.font = SystemFont(15);
    cell.textLabel.textColor = kColorTextGray;
    [cell.contentView addLineTo:kFrameLocationBottom color:kColorLineGray];
    return cell;
}

- (UITableViewCell *)logoutCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
    [cell.contentView addLineTo:kFrameLocationBottom color:kColorLineGray];
    [cell.contentView addLineTo:kFrameLocationTop color:kColorLineGray];
    UILabel *_logout = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    _logout.text = @"退出登录";
    _logout.textAlignment = NSTextAlignmentCenter;
    _logout.textColor = [UIColor colorFromHexRGB:@"ff717f"] ;
    _logout.font = SystemFont(15);
    _logout.backgroundColor = kColorWhite;
    [cell.contentView addSubview:_logout];
    return cell;
}

- (CGFloat)getCancheSize {
    NSArray *allKeys = [[EGOCache share] allKeys];
    NSMutableData *cacheData = [[NSMutableData alloc] init];
    for (NSString *key in allKeys) {
        NSData *data = [[EGOCache share] dataForKey:key];
        [cacheData appendData:data];
    }
    return (CGFloat)cacheData.length / 1024 / 1024;
}

- (void)cleanCanche {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:DocumentsFilepath]) {
        // 清除缓存
        NSArray *allKeys = [[EGOCache share] allKeys];
        for (NSString *key in allKeys) {
            [[EGOCache share] removeCacheForKey:key];
        }
    }
}

@end
