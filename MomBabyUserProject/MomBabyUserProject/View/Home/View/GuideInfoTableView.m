//
//  GuideInfoTableView.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "GuideInfoTableView.h"
#import "OneGuideInfoCell.h"
#import "TwoGuideInfoCell.h"


@implementation GuideInfoTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)defaultConfig {
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = kColorBackground;
    self.separatorStyle = NO;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (kShareManager_Home.homeInfo.highRiskArticle != nil) {
        return kShareManager_Home.homeInfo.list.count + 1;
    }
    return kShareManager_Home.homeInfo.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 3)];
    view.backgroundColor = kColorBackground;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // AA BB AA交错布局   当有高危时候  高危第一个  其他依次往后排
    if (indexPath.section % 4 == 1 || indexPath.section % 4 == 0) {
        OneGuideInfoCell *cell = [OneGuideInfoCell defaultClassNameNibView];
        if (kShareManager_Home.homeInfo.highRiskArticle != nil && indexPath.section == 0) {
            cell.model = kShareManager_Home.homeInfo.highRiskArticle;
        } else {
            cell.model = kShareManager_Home.homeInfo.list[indexPath.section - 1];
        }
        return cell;
    }
    NSInteger index = indexPath.section;
    TwoGuideInfoCell *cell = [TwoGuideInfoCell defaultClassNameNibView];
    if (kShareManager_Home.homeInfo.highRiskArticle != nil) {
        index -= 1;
    }
    cell.model = kShareManager_Home.homeInfo.list[index];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger index = indexPath.section;
//    if (kShareManager_Home.homeInfo.highRiskArticle != nil) {
//        index -= 1;
//    }
    if (self.selectCellBlock) {
        self.selectCellBlock(indexPath.section);
    }
}

- (CGFloat)tableHeight {
    NSInteger index = kShareManager_Home.homeInfo.list.count - 1;
    if (kShareManager_Home.homeInfo.highRiskArticle != nil) {
        index += 1;
    }
    return index * 130 + 120 + kShareManager_Home.homeInfo.list.count * 3;
}

@end
