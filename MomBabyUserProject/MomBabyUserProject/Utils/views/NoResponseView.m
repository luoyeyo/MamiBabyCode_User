//
//  NoResponseView.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/26.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "NoResponseView.h"

@interface NoResponseView ()

@property (nonatomic,strong) UIImageView *image;
@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UIButton *loadBtn;

@end
@implementation NoResponseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.image];
        [self addSubview:self.titleLable];
        [self addSubview:self.loadBtn];
        [self setType:kNoResponseTypeNoConnection];
    }
    return self;
}

- (void)setType:(kNoResponseType)type {
    if (type == kNoResponseTypeNormal) {
        [self removeFromSuperview];
    } else if (type == kNoResponseTypeNoConnection) {
        [self.image setImage:[UIImage imageNamed:@"no_connection"]];
        self.titleLable.text = @"抱歉，您的网络好像不给力，请检查您的网络设置";
        self.loadBtn.hidden = NO;
    }
}

- (void)setMessage:(NSString *)message {
    self.titleLable.text = message;
}

- (void)layoutSubviews {
    self.image.center = CGPointMake(ScreenWidth / 2, self.height / 2 - 50);
    self.titleLable.center = CGPointMake(ScreenWidth / 2, CGRectGetMaxY(self.image.frame) + 15);
    _loadBtn.center = CGPointMake(ScreenWidth / 2, CGRectGetMaxY(self.titleLable.frame) + 40);
}

- (UIImageView *)image {
    if (_image == nil) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        _image.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _image;
}

- (UILabel *)titleLable {
    if (_titleLable == nil) {
        _titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 60, 40)];
        _titleLable.font = [UIFont systemFontOfSize:13];
        _titleLable.textColor = [UIColor colorFromHexRGB:@"999999"];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.numberOfLines = 2;
    }
    return _titleLable;
}

- (UIButton *)loadBtn {
    if (_loadBtn == nil) {
        _loadBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _loadBtn.frame = CGRectMake(0, 0, 90, 33);
        _loadBtn.layer.cornerRadius = 5;
        _loadBtn.backgroundColor = [UIColor colorFromHexRGB:@"f5728b"];
        [_loadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_loadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loadBtn addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
        _loadBtn.hidden = YES;
    }
    return _loadBtn;
}

- (void)loadData {
    if ([self.delegate respondsToSelector:@selector(onceAgain)]) {
        [self.delegate onceAgain];
    }
}

@end
