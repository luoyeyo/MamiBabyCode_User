//
//  GuideInfoTableView.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideInfoTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *guideInfoList;
@property (nonatomic, copy) void(^selectCellBlock)(NSInteger index);
@property (nonatomic, assign) CGFloat tableHeight;
@end
