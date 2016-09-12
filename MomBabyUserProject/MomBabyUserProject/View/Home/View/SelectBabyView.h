//
//  SelectBabyView.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/21.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectBabyView : UIView

@property (strong, nonatomic) UITableView *tableView;
@property (copy, nonatomic) void(^selectBabyBlock)(NSInteger index);
- (void)show;

@end
