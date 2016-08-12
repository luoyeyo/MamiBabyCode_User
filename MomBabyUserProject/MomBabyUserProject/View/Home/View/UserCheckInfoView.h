//
//  UserCheckInfoView.h
//  MomBabyUserProject
//
//  Created by 罗野 on 16/7/6.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCheckInfoView : UIView
// 剩余时间
@property (strong, nonatomic) IBOutlet UILabel *surplusDay;
@property (strong, nonatomic) IBOutlet UILabel *introText;
@property (strong, nonatomic) IBOutlet UILabel *nextCheckTime;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *content;

- (void)updateCheckInfo;

@end
