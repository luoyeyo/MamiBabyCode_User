//
//  SelfTableViewCell.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/19.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelfTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel     * titleText;
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UILabel     * detail;
@property (nonatomic, strong) UIView      * lineView;



-(void)createCellWithTitle:(NSString *)text detail:(NSString *)detailText iconImage:(NSString *)imageName andIndexPtah:(NSIndexPath *)indexPtah;

@end
