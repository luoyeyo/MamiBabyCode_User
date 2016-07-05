//
//  UITableViewCell+Util.m
//  HouseMarket
//
//  Created by wangzhi on 15-2-13.
//  Copyright (c) 2015年 wangzhi. All rights reserved.
//

#import "UITableViewCell+Util.h"

#define kaddDefaultSepraterLineTag 0x280437

@implementation UITableViewCell (Util)

- (UIView*)addDefaultSepraterLine
{
    UIView *line = [self viewWithTag:kaddDefaultSepraterLineTag];
    if (nil == line) {
        CGFloat lineLeftPadding = 15;
        CGFloat lineHeight = 0.5;

        CGRect frame =  CGRectMake(lineLeftPadding, CGRectGetHeight(self.contentView.frame)-lineHeight, CGRectGetWidth(self.contentView.frame) - lineLeftPadding, lineHeight);
        UIView *line = [[UIView alloc]initWithFrame:frame];
        line.backgroundColor = [UIColor lightGrayColor];
        line.alpha = 0.5;
        line.tag = kaddDefaultSepraterLineTag;
        line.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        [self addSubview:line];
    }
    line.hidden = NO;
    [self bringSubviewToFront:line];
    return line;
}

- (void)removeDefaultSepraterLine
{
    UIView *line = [self.contentView viewWithTag:kaddDefaultSepraterLineTag];
    if (nil != line) {
        line.hidden = YES;
        [line removeFromSuperview];
    }
}

- (CGFloat)fitHeight
{
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];

    [self setNeedsLayout];
    [self layoutIfNeeded];

    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;

    return height;
}

@end
