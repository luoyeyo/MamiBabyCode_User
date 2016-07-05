//
//  DiscoverViewController.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/3/14.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverCell.h"
// 怀孕
#import "WikiViewController.h"            // 百科
#import "BoyOrGirlViewController.h"       // 生男生女
#import "NutritionViewController.h"       // 营养查询

// 育儿
#import "RecoverViewController.h"         // 产后恢复


@interface DiscoverViewController ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *_list;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    [self navbarSetAppThemeAppearance];
    [self requesrDefaultData];
}

- (void)requesrDefaultData {
    
    BOOL isMum = YES;
    // 孕期状态
    if (kUserInfo.isLogined) {
        if (kUserInfo.status != kUserStateMum) {
            isMum = NO;
        }
    } else {
        // 没有孕期的话就是宝宝
        if (![NSString isEmptyString:kUserInfo.dueDateStr]) {
            isMum = NO;
        }
    }
    
    Input_params *params = [[Input_params alloc] init];
    params.page = @1;
    params.limit = @10;
    // 妈咪个宝宝是不一样的
    [self.view showPopupLoading];
    [[[Network_Discover alloc] init] getDiscoverListCellWithStatus:isMum params:params ResponseBlock:^(LLError *error, NSArray *list) {
        [self.view hidePopupLoading];
        if (!error) {
            _list = list;
            [self.tableView reloadData];
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    footer.backgroundColor = kColorBackground;
    return footer;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DiscoverCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscoverCell"];
    cell.data = _list[indexPath.section];
//    [cell addLineTo:kFrameLocationTop color:kColorLineGray];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DiscoverModel *model = _list[indexPath.section];
    
    if ([model.title isEqualToString:@"生男生女"])
    {
        BoyOrGirlViewController *boyOrGirl = [[BoyOrGirlViewController alloc] init];
        boyOrGirl.parentId = model.title;
        boyOrGirl.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:boyOrGirl animated:YES];
    }
    else if ([model.title isEqualToString:@"育儿百科"] || [model.title isEqualToString:@"孕期百科"])
    {
        WikiViewController *wiki = [[WikiViewController alloc] init];
        wiki.parentId = model.Id;
        wiki.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wiki animated:YES];
    }
    else if ([model.title isEqualToString:@"营养查询"])
    {
        NutritionViewController *nutritionVC = [[NutritionViewController alloc] init];
        nutritionVC.parentId = model.title;
        nutritionVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nutritionVC animated:YES];
        
    }
    else if ([model.title isEqualToString:@"产后恢复"])
    {
        RecoverViewController *recoverVC = [[RecoverViewController alloc] init];
        recoverVC.parentId = model.Id;
        recoverVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:recoverVC animated:YES];
    }
    else if ([model.title isEqualToString:@"成长评测"])
    {
        
    }

}

@end
