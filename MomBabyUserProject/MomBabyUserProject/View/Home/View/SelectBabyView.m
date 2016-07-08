//
//  SelectBabyView.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/21.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "SelectBabyView.h"
#import "SelectBabyCell.h"

@interface SelectBabyView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SelectBabyView

- (void)awakeFromNib {
    self.alpha = 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return kUserInfo.babys.count + 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 第一个是家长 最后一个是取消
    if (indexPath.row == kUserInfo.babys.count + 1) {
        UITableViewCell *cell = [self createCancelCell];
        return cell;
    } else if (indexPath.row == 0) {
        SelectBabyCell *cell = [SelectBabyCell defaultClassNameNibView];
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        cell.row = indexPath.row;
        [cell isMum];
        return cell;
    } else {
        SelectBabyCell *cell = [SelectBabyCell defaultClassNameNibView];
        [cell addLineTo:kFrameLocationBottom color:kColorLineGray];
        // 因为第一个是妈妈
        cell.row = indexPath.row - 1;
        cell.babyInfo = kUserInfo.babys[indexPath.row - 1];
        return cell;
    }
}

- (UITableViewCell *)createCancelCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    UILabel *cancel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * .8f, 55)];
    cancel.font = [UIFont fontWithName:@"PingFangSC-Light" size:18];
    cancel.textColor = [UIColor colorFromHexRGB:@"979797"];
    cancel.text = @"取   消";
    cancel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:cancel];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotiSelectThisBaby object:@(indexPath.row)];
    // 点取消 不传
    if (kUserInfo.babys.count + 1 != indexPath.row) {
        self.selectBabyBlock(indexPath.row);
    }
    [self dismis];
}

- (void)show {
    [kAppDelegate.window addSubview:self];
    self.tableView.bounds = CGRectMake(0, 0, ScreenWidth * .8f, (kUserInfo.babys.count + 2) * 55);
    self.tableView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
    [UIView animateWithDuration:kAnmaitionDuration animations:^{
        self.alpha = 1;
    }];
}

- (void)dismis {
    [UIView animateWithDuration:kAnmaitionDuration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 5;
        _tableView.clipsToBounds = YES;
        _tableView.separatorStyle = NO;
        [self addSubview:_tableView];
    }
    return _tableView;
}

@end
