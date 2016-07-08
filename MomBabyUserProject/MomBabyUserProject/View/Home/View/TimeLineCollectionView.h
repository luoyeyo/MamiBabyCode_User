//
//  TimeLineCollectionView.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TimeLineDidChangeDelegate <NSObject>

/**
 *  时间轴改变
 *
 *  @param currentDay 当前选中的
 */
- (void)timeLineDidChangeToDay:(CalendarDayModel *)currentDay;

@end

@interface TimeLineCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, assign) id<TimeLineDidChangeDelegate> timeLineDidChangeDelegate;

- (void)updateInfo;
- (void)today;

@end
