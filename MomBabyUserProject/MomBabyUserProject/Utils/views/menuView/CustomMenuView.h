//
//  CustomListView.h
//  listView
//
//  Created by 罗野 on 15/10/3.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger,MenuPosition) {
    kPositionCenter = 0,
    kPositionLeft = 1,
    kPositionRight = 2,
};

@protocol CustomMenuViewDelegate <NSObject>

- (void)menuSelected:(NSInteger)index;

@end
/**
 *  添加资源种类
 */
@interface CustomMenuView : UIView

@property (nonatomic, assign) MenuPosition Position;
@property (nonatomic, assign) id <CustomMenuViewDelegate> delegate;
@property (nonatomic, strong) NSArray *dataSource;
- (void)showListView;
 
@end
