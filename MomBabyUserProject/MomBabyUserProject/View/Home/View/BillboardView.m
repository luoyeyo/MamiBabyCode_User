//
//  BillboardView.m
//  MombabyProject
//
//  Created by 罗野 on 16/6/24.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "BillboardView.h"


@interface BillboardView ()

@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImageView *billboardImage;
@property (nonatomic, strong) UIView *billboardBaseView;
@property (nonatomic, copy) void(^clickBlock)();

@end

@implementation BillboardView

+ (BillboardView *)billboardViewWithImage:(UIImage *)image imageUrl:(NSString *)url clickBlock:(void (^)())clickBlock {
    
    BillboardView *view = [[BillboardView alloc] initWithFrame:kAppDelegate.window.bounds];
    view.billboardImage.image = image;
    view.imageUrl = url;
    view.clickBlock = clickBlock;
    view.alpha = 0;
    view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
    [view closeBtn];
    [view initData];
    return view;
}

- (void)initData {
    
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [self.billboardImage addGestureRecognizer:tag];
    
    if (self.billboardImage.image != nil) {
        [self showBillboardView];
    } else if (self.imageUrl && self.imageUrl.length > 0) {
        // 开辟新线程执行方法 并传入参数
        [NSThread detachNewThreadSelector:@selector(loadimageWithURL:) toTarget:self withObject:self.imageUrl];
    }
}

- (void)closeBtn {
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeBtn setImage:ImageNamed(@"close") forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(self.billboardBaseView.width - 20, 40, 32, 32);
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.billboardBaseView addSubview:closeBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(closeBtn.frame) - 1, 1.5, 100)];
    line.backgroundColor = kColorWhite;
    line.center = CGPointMake(closeBtn.center.x, line.center.y);
    [self.billboardBaseView insertSubview:line atIndex:0];
}

- (void)clickImage {
    if (self.clickBlock) {
        self.clickBlock();
    }
    [self dismiss];
}

- (void)loadimageWithURL:(NSString *)url {
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (data == nil) {
        return;
    }
    //     交给主线程执行方法
    [self performSelectorOnMainThread:@selector(refreshImageViewWithData:) withObject:data waitUntilDone:NO];
}

- (void)refreshImageViewWithData:(NSData *)data {
    self.billboardImage.image = [UIImage imageWithData:data];
    [self showBillboardView];
}

- (void)showBillboardView {
    [kAppDelegate.window addSubview:self];
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0f;
    }];
    CATransform3D move = CATransform3DIdentity;
    CGFloat initAlertViewYPosition = (ScreenHeight + self.billboardImage.height) / 2;
    move = CATransform3DMakeTranslation(0, - initAlertViewYPosition, 0);
    move = CATransform3DRotate(move, 40 * M_PI / 180, 0, 0, 1.0f);
    self.billboardBaseView.layer.transform = move;
    
    [UIView animateWithDuration:1.0f
                          delay:0.0f
         usingSpringWithDamping:0.4f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CATransform3D init = CATransform3DIdentity;
                         self.billboardBaseView.layer.transform = init;
                     }
                     completion:^(BOOL finished) {
                         
                     }];
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.8f
                          delay:0.0f
         usingSpringWithDamping:1.0f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         CGRect screen = kAppDelegate.window.bounds;
                         CATransform3D move = CATransform3DIdentity;
                         CGFloat initAlertViewYPosition = CGRectGetHeight(screen);
                         
                         move = CATransform3DMakeTranslation(0, initAlertViewYPosition, 0);
                         move = CATransform3DRotate(move, -40 * M_PI / 180, 0, 0, 1.0f);
                         self.billboardBaseView.layer.transform = move;
                         
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [self removeFromSuperview];
                     }];
}

- (UIImageView *)billboardImage {
    if (!_billboardImage) {
        _billboardImage = [[UIImageView alloc] initWithFrame:self.billboardBaseView.bounds];
        _billboardImage.contentMode = UIViewContentModeScaleAspectFill;
        _billboardImage.layer.cornerRadius = 8;
        _billboardImage.clipsToBounds = YES;
        _billboardImage.backgroundColor = kColorWhite;
        _billboardImage.userInteractionEnabled = YES;
        _billboardImage.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
        [self.billboardBaseView addSubview:_billboardImage];
    }
    return _billboardImage;
}

- (UIView *)billboardBaseView {
    if (!_billboardBaseView) {
        _billboardBaseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 40, ScreenHeight * .65f)];
        _billboardBaseView.layer.cornerRadius = 4;
        [self addSubview:_billboardBaseView];
    }
    return _billboardBaseView;
}

@end
