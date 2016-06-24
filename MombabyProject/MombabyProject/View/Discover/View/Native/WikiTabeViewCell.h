//
//  WikiTabeViewCell.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/25.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiModel.h"

@class WikiModel;

@interface WikiTabeViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * iconImage;

@property (nonatomic, strong) UILabel * title;

@property (nonatomic, strong) UILabel * detail;

- (void)cellWithModel:(WikiModel *)model;
@end
