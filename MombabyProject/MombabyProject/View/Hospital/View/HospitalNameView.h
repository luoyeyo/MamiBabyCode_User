//
//  HospitalNameView.h
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/14.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalNameView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *hospitalImage;
@property (strong, nonatomic) IBOutlet UILabel *hospitalName;
+ (instancetype )defaultClassNameNibViewWithFrame:(CGRect)frame;
@end
