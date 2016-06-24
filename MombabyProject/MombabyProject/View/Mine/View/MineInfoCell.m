//
//  MineInfoCell.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/26.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "MineInfoCell.h"

@implementation MineInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)drawRect:(CGRect)rect {
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"image"]];
//    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 400);
//    imageView.center = self.view.center;
//    [self.view addSubview:imageView];
    
    //初始化渐变层
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.frame = self.bounds;
    [self.contentView.layer insertSublayer:self.gradientLayer atIndex:0];
    //设置渐变颜色方向
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    
    UIColor *beginColor = [UIColor colorWithRed:93/255.0 green:193/255.0 blue:208/255.0 alpha:1.0];
    UIColor *endColor = [UIColor colorWithRed:99/255.0 green:212/255.0 blue:209/255.0 alpha:1.0];
    //设定颜色组
    self.gradientLayer.colors = @[(__bridge id)beginColor.CGColor,
                                  (__bridge id)endColor.CGColor];
    
    //设定颜色分割点
    self.gradientLayer.locations = @[@(0.5f) ,@(1.0f)];
}

@end
