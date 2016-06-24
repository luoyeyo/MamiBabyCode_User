//
//  UITableView+Util.m
//  HouseMarket
//
//  Created by wangzhi on 15-3-23.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import "UITableView+Util.h"

@implementation UITableView (Util)

- (void)hideExtraCellLine
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    self.tableFooterView = view;
}

- (void)reloadTableViewCell:(UITableViewCell*)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (nil != indexPath) {
        [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)addTopHeaderSpace:(CGFloat)height
{
    ReturnIf(height <= 0);

    UIView *topSpace = [[[UIView alloc]init]clearBackgroundColor];
    topSpace.frame= CGRectMake(0, 0, ScreenWidth, height);
    self.tableHeaderView = topSpace;
}

- (void)scrollSelfToTop
{
    [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

@end
