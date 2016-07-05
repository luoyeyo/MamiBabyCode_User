//
//  CardView.h
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/30.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardViewDelegate <NSObject>

- (void)nextView:(UIView *)view;

- (void)historyView:(UIView *)historyView;

@end

@interface CardView : UIScrollView

@property (nonatomic, assign) id<CardViewDelegate> sdelegate;
/*
 视图控件
 */
@property (nonatomic, strong) UILabel * numberLabel;     //第几次产检
@property (nonatomic, strong) UILabel * weeksLabel;      //孕周
@property (nonatomic, strong) UILabel * dateLabel;       //显示时间
@property (nonatomic, strong) UILabel * muDiLabel;       //产检标题
@property (nonatomic, strong) UILabel * goalLabel;       //产检目的
@property (nonatomic, strong) UILabel * xiangMuLabel;    //项目标题
@property (nonatomic, strong) UILabel * projectLabel;    //产检项目

@end
