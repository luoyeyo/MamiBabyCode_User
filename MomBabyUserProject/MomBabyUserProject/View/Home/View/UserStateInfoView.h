//
//  UserStateInfoView.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/15.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  用户状态显示（生日、预产期等   主页的状态条）
 */
@interface UserStateInfoView : UIView
// 计算的天数（怀孕天数和）
@property (nonatomic, assign) NSInteger days;
// 以改时间为基准算 （改变时间轴时选中的）
@property (nonatomic, assign) NSTimeInterval currentDate;

/**
 *  刷新UI  如果传了currentDate就依他为基准  否则以记录的为基准
 */
- (void)updateInfo;

@end
