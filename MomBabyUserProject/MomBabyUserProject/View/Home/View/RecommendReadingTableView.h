//
//  RelatedReadingTableView.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/17.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommendReadingTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign) CGFloat tableHeight;
@property (nonatomic, copy) void(^selectCellBlock)(NSInteger index);
@property (nonatomic, copy) NSMutableArray *list;
@end
