//
//  UITableView+Refresh.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/25.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "UITableView+Refresh.h"

@implementation UITableView (Refresh)

- (void)addNoTitleHeaderWithAction:(SEL)action {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:action];
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.header = header;
}

@end
