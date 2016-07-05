//
//  HospitalNameView.m
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/14.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "HospitalNameView.h"

@implementation HospitalNameView

+ (instancetype )defaultClassNameNibViewWithFrame:(CGRect)frame
{
    NSArray *views = [[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:nil options:nil];
    for (HospitalNameView *view in views) {
        if ([view isMemberOfClass:[self class]]) {
            view.frame = frame;
            return view;
        }
    }
    NSAssert(NO, @"Expect file: %@", [NSString stringWithFormat:@"%@.xib", NSStringFromClass([self class])]);
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
