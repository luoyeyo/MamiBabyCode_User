//
//  TableViewController.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/12.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoResponseView.h"

@interface TableViewController : UITableViewController

@property (nonatomic, strong) NoResponseView *noResponeView;
- (void)noMoreData;
@end
