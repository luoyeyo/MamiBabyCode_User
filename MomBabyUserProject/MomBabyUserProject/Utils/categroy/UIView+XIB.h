//
//  UIView+XIB.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/22.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XIB)
/**
 *  通过xib创建
 *
 *  @param frame
 *
 *  @return 
 */
+ (instancetype )defaultClassNameNibViewWithFrame:(CGRect)frame;
+ (instancetype )defaultClassNameNibView;
@end
