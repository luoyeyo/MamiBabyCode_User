//
//  WikiBottomScrollBtnView.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/12/28.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "WikiBottomScrollBtnView.h"
#import "WikiModel.h"
#import "WikiSubViewController.h"
#import "CAPSPageMenu.h"

@interface WikiBottomScrollBtnView () <UIScrollViewDelegate>
@property (nonatomic, strong) CAPSPageMenu *menu;
@end

@implementation WikiBottomScrollBtnView
// 添加子视图
- (void)viewsWithDataSource:(NSArray *)array
{
    NSMutableArray *controllers = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        WikiModel *model = array[i];
        WikiSubViewController *ctr = [[WikiSubViewController alloc] init];
        ctr.title = model.title;
        ctr.categoryId = model.parentId;
        [controllers addObject:ctr];
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[CAPSPageMenuOptionScrollMenuBackgroundColor] = [UIColor whiteColor];
    dict[CAPSPageMenuOptionUnselectedMenuItemLabelColor] = COLOR_C2;
    dict[CAPSPageMenuOptionSelectedMenuItemLabelColor] = kColorTheme;
    dict[CAPSPageMenuOptionViewBackgroundColor] = [UIColor whiteColor];
    dict[CAPSPageMenuOptionMenuItemWidth] = @(ScreenWidth / 4);
    dict[CAPSPageMenuOptionMenuItemFont] = UIFONT_H3_14;
    dict[CAPSPageMenuOptionMenuHeight] = @(45);
    dict[CAPSPageMenuOptionMenuMargin] = @(0.0);
    dict[CAPSPageMenuOptionCenterMenuItems] = @(YES);
    dict[CAPSPageMenuOptionSelectionIndicatorColor] = kColorTheme;
    
    self.menu = [[CAPSPageMenu alloc] initWithViewControllers:controllers frame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 45) options:dict];
    [self addSubview:self.menu.view];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self.menu.view addSubview:line];
    
    for (int i = 1; i < array.count; i ++) {
        CGFloat lienX = ScreenWidth / 4  * i;
        CGFloat lienW = 1;
        CGFloat lienH = 20;
        CGFloat lienY = 12;
        UIView *lien = [[UIView alloc] initWithFrame:CGRectMake(lienX, lienY, lienW, lienH)];
        lien.backgroundColor = COLOR_LINE;
        [self.menu.menuScrollView addSubview:lien];
    }
}

@end
