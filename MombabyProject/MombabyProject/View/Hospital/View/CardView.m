//
//  CardView.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/30.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        
        UISwipeGestureRecognizer * goLeftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goLeftSwipe:)];
        goLeftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:goLeftSwipe];
        
        UISwipeGestureRecognizer * gorightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(gorightSwipe:)];
        gorightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:gorightSwipe];
        
        [self createMyScrollView];
    }
    return self;
}

- (void)createMyScrollView{
//    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(self.width / 2 - 50, -40, 100, 100)];
//    redView.backgroundColor = [UIColor colorFromHexCode:@"f5728b"];
//    redView.layer.cornerRadius = 50;
//    redView.clipsToBounds = NO;
//    redView.layer.masksToBounds = YES;
//    [self addSubview:redView];
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, self.width, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:topView];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.width - 30, 38)];
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.font = UIFONT_H3_14;
    self.numberLabel.layer.masksToBounds = YES;
    self.numberLabel.layer.cornerRadius = 5;
    self.numberLabel.text = @"第1次产检";
    self.numberLabel.backgroundColor = [UIColor colorFromHexRGB:@"f5728b"];
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.numberLabel];
    
    self.weeksLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.numberLabel.bottom + 10, self.width, 20)];
    self.weeksLabel.textColor = COLOR_C1;
    self.weeksLabel.font = UIFONT_H3_14;
    self.weeksLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.weeksLabel];
     
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.weeksLabel.bottom + 5, self.width, 20)];
    self.dateLabel.textColor = COLOR_C1;
    self.dateLabel.font = UIFONT_H3_14;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.dateLabel];
    
    self.muDiLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.dateLabel.bottom + 10, self.width - 10, 20)];
    self.muDiLabel.textColor = COLOR_C1;
    self.muDiLabel.font = UIFONT_H4_15;
    self.muDiLabel.textAlignment = NSTextAlignmentLeft;
    self.muDiLabel.text = @"本次产检目的:";
    [self addSubview:self.muDiLabel];
    
    self.goalLabel = [[UILabel alloc] init];
    self.goalLabel.textColor = COLOR_C3;
    self.goalLabel.font = UIFONT_H3_14;
    self.goalLabel.textAlignment = NSTextAlignmentLeft;
    self.goalLabel.numberOfLines = 0;
    [self addSubview:self.goalLabel];
    
    self.xiangMuLabel = [[UILabel alloc] init];
    self.xiangMuLabel.textColor = COLOR_C1;
    self.xiangMuLabel.font = UIFONT_H4_15;
    self.xiangMuLabel.textAlignment = NSTextAlignmentLeft;
    self.xiangMuLabel.text = @"本次产检项目:";
    [self addSubview:self.xiangMuLabel];
    
    self.projectLabel = [[UILabel alloc] init];
    self.projectLabel.textColor = COLOR_C3;
    self.projectLabel.font = UIFONT_H3_14;
    self.projectLabel.textAlignment = NSTextAlignmentLeft;
    self.projectLabel.backgroundColor = [UIColor whiteColor];
    self.projectLabel.numberOfLines = 0;
    [self addSubview:self.projectLabel];
    
}

- (void)gorightSwipe:(UISwipeGestureRecognizer *)swipe{

    [self.sdelegate historyView:swipe.view];
}

- (void)goLeftSwipe:(UISwipeGestureRecognizer *)swipe{

    [self.sdelegate nextView:swipe.view];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
