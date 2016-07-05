//
//  SuperTableView.h
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/17.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SuperTableView;
@protocol SuperTableViewDelegate <NSObject>

- (void)connect:(SuperTableView *)superTable;

@end

@interface SuperTableView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, strong) NSMutableArray * sourceArr;
@property (nonatomic, strong) NSMutableArray * indexPathArr;
@property (nonatomic, assign) int page;
@property (nonatomic, assign) id<SuperTableViewDelegate> delegate;
@end
