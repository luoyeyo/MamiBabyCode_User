//
//  HP_VWorkItemCell.m
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/14.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "HP_VWorkItemCell.h"

@implementation HP_VWorkItemCell

+ (instancetype )defaultClassNameNibView
{
    NSArray *views = [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil];
    for (HP_VWorkItemCell *view in views) {
        if ([view isMemberOfClass:[self class]]) {
            return view;
        }
    }
    NSAssert(NO, @"Expect file: %@", [NSString stringWithFormat:@"%@.xib", NSStringFromClass([self class])]);
    return nil;
}

- (void)setModel:(HospitalItemModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    if (model.iconValid) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconValid.medium] placeholderImage:nil];
    } else if (model.iconInvalid) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:model.iconInvalid.medium] placeholderImage:nil];
    }
}

- (void)awakeFromNib {
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor colorFromHexRGB:@"f1ecec"];
    self.selectedBackgroundView = view;
    self.backgroundColor = [UIColor whiteColor];
}

@end
