//
//  GetVerifyButton.h
//  yiMiaoProject
//
//  Created by 罗野 on 16/4/30.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetVerifyButton : UIButton
/**
 *  自定义点击后的背景色  默认透明
 */
@property (nonatomic, strong) UIColor *highlightColor;

/**
 *  开始计时
 */
- (void)beginTimer;
/**
 *  停止计时
 */
- (void)stopTimer;

@end
