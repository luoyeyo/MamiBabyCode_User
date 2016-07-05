//
//  MyCollectionViewCell.m
//  Day13-UICollectionView
//
//  Created by 潘颖超 on 15/8/26.
//  Copyright (c) 2015年 Meakelra. All rights reserved.
//

#import "MyCollectionViewCell.h"

@implementation MyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    CGFloat viewW = ScreenWidth / 5;
    CGFloat viewH = 30;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(viewX, viewY, viewW, viewH);
    button.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:button];
    
    // 上面的文字
    CGFloat topLabelX = 0;
    CGFloat topLabelW = viewW;
    CGFloat topLabelH = 13;
    CGFloat topLabelY = (viewH * 0.5 - topLabelH) * 0.5;
    _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(topLabelX, topLabelY, topLabelW, topLabelH)];
    _topLabel.font = UIFONT_H2_13;
    _topLabel.textColor = COLOR_C2;
    _topLabel.textAlignment = NSTextAlignmentCenter;
    [button addSubview:_topLabel];
    
    // 下面的文字
    CGFloat bottomLabelX = 0;
    CGFloat bottomLabelW = viewW;
    CGFloat bottomLabelH = 13;
    CGFloat bottomLabelY = viewH * 0.5 + topLabelY;
    _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(bottomLabelX, bottomLabelY, bottomLabelW, bottomLabelH)];
    _bottomLabel.font = UIFONT_H2_13;
    _bottomLabel.textColor = COLOR_C2;
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    [button addSubview:_bottomLabel];
    
}


@end
