//
//  UIView+HUDExtensions.m
//  Parking
//
//  Created by ZhangTinghui on 14/12/13.
//  Copyright (c) 2014年 www.660pp.com. All rights reserved.
//

#import "UIView+HUDExtensions.h"
#import <MBProgressHUD/MBProgressHUD.h>

static const NSInteger kHUDPopLoadingViewTag        = 1412301511;
static const NSInteger kHUDPlaneLoadingViewTag      = 1503310900;
static const NSInteger kHUDPlaneLoadingActivityTag  = 1503310914;
static const NSInteger kHUDPlaneMessageViewTag      = 1501091133;
static const NSInteger kHUDToastMessageViewTag      = 1503261359;
static const NSInteger kHUDToastLabelTag            = 1503261411;


@interface HUDCustomLoadingView : UIView
@property (nonatomic, weak) UIImageView *loadingView;
@property (nonatomic, assign) BOOL shouldRestoreAnimation;

+ (instancetype)loadingView;
- (void)stopLoadingAnimation;
- (void)startLoadingAnimation;
@end

@implementation HUDCustomLoadingView
- (void)dealloc {
    [self stopLoadingAnimation];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)loadingView {
    CGRect rect = CGRectMake(0, 0, 37, 37);
    return [[self alloc] initWithFrame:rect];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self _addLoadingView];
        [self _registerAppStateNotifications];
        [self startLoadingAnimation];
    }
    return self;
}

- (void)_addLoadingView {
    // , @"hud_icon_pp"
    [@[@"hud_icon_loading"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImage *image = [UIImage imageNamed:obj];
        UIImageView *view = [[UIImageView alloc] initWithImage:image];
        view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        view.frame = self.bounds;
        [self addSubview:view];
        
        if (idx == 0) {
            self.loadingView = view;
        }
    }];
}

- (BOOL)_isInLoadingAnimation {
    return ([self.loadingView.layer animationForKey:@"loading"] != nil);
}

- (void)stopLoadingAnimation {
    if (![self _isInLoadingAnimation]) {
        return;
    }
    [self.loadingView.layer removeAnimationForKey:@"loading"];
}

- (void)startLoadingAnimation {
    CABasicAnimation *rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2.0);
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = CGFLOAT_MAX;
    [self.loadingView.layer addAnimation:rotationAnimation forKey:@"loading"];
}

#pragma mark - AppStateNotification
- (void)_registerAppStateNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_appDidEnterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_appWillEnterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)_appDidEnterBackground:(NSNotification *)notification {
    self.shouldRestoreAnimation = [self _isInLoadingAnimation];
    [self stopLoadingAnimation];
}

- (void)_appWillEnterForeground:(NSNotification *)notification {
    if (!self.shouldRestoreAnimation) {
        return;
    }
    
    [self startLoadingAnimation];
}

@end



@implementation UIView (HUDExtensions)

#pragma mark - Popup Loading
- (MBProgressHUD *)_createAndShowHUDForPopupLoading {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];

    hud.tag = kHUDPopLoadingViewTag;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [HUDCustomLoadingView loadingView];
    return hud;
}

- (void)showPopupLoading {
    [self showPopupLoadingWithText:nil];
}

- (void)showPopupLoadingWithText:(NSString *)text {
    [[self _createAndShowHUDForPopupLoading] setLabelText:text];
}

- (void)showPopupLoadingWithText:(NSString *)text hideAfterDelay:(float)delay {
    MBProgressHUD *hud = [self _createAndShowHUDForPopupLoading];
    hud.labelText = text;
    [hud hide:YES afterDelay:delay];
}

- (void)hidePopupLoading {
    [self hidePopupLoadingAnimated:YES];
}

- (void)hidePopupLoadingAnimated:(BOOL)animated {
    NSArray *huds = [MBProgressHUD allHUDsForView:self];
    for (MBProgressHUD *hud in huds) {
        if (hud.tag == kHUDPopLoadingViewTag) {
            [hud hide:animated];
        }
    }
}

#pragma mark - Popup Message
- (void)showPopupOKMessage:(NSString *)message {
    [self showPopupMessage:message type:UIViewPopupMessageTypeOK];
}

- (void)showPopupErrorMessage:(NSString *)message {
    [self showPopupMessage:message type:UIViewPopupMessageTypeError];
}

- (void)showPopupMessage:(NSString *)message type:(UIViewPopupMessageType)type {
    [self showPopupMessage:message type:type completion:nil];
}

- (void)showPopupMessage:(NSString *)message
                    type:(UIViewPopupMessageType)type
              completion:(void(^)(void))completion {
    
    if ([message length] <= 0) {
        if (completion) {
            completion();
        }
        return;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    UIImage *iconImage = nil;
    switch (type) {
        case UIViewPopupMessageTypeError:
            iconImage = [UIImage imageNamed:@"hud_icon_error"];
            break;
        case UIViewPopupMessageTypeOK:
        default:
            iconImage = [UIImage imageNamed:@"hud_icon_ok"];
            break;
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:iconImage];
    hud.detailsLabelText = message;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    
    if (completion) {
        hud.completionBlock = completion;
    }
    
    //根据消息的文字长度，决定delay时间长短
    //按照人平均阅读速度 400个/分钟
    NSTimeInterval delay = [message length] / (400/60);
    [hud hide:YES afterDelay:MAX(1.5f, delay)];
    
    //handle tap
    [hud addGestureRecognizer:[[UITapGestureRecognizer alloc]
                               initWithTarget:self
                               action:@selector(_handleHUDTap:)]];
}

- (void)_handleHUDTap:(UITapGestureRecognizer *)recognizer {
    [MBProgressHUD hideHUDForView:self animated:YES];
}

#pragma mark - PlaneLoading
- (void)showPlaneLoading {
    UIView *view = [self viewWithTag:kHUDPlaneLoadingViewTag];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:self.bounds];
        view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        view.backgroundColor = [UIColor whiteColor];
        view.tag = kHUDPlaneLoadingViewTag;
        [self addSubview:view];
    }
    
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)[view viewWithTag:kHUDPlaneLoadingActivityTag];
    if (loadingView == nil) {
        loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        loadingView.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
        loadingView.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin
                                        | UIViewAutoresizingFlexibleBottomMargin
                                        | UIViewAutoresizingFlexibleLeftMargin
                                        | UIViewAutoresizingFlexibleRightMargin);
        loadingView.tag = kHUDPlaneLoadingActivityTag;
        loadingView.hidesWhenStopped = YES;
        [view addSubview:loadingView];
    }
    
    [loadingView startAnimating];
}

- (void)hidePlaneLoading {
    UIView *view = [self viewWithTag:kHUDPlaneLoadingViewTag];
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)[view viewWithTag:kHUDPlaneLoadingActivityTag];
    [loadingView stopAnimating];
    [view removeFromSuperview];
}

#pragma mark - PlaneMessage 
- (void)showPlaneMessage:(NSString *)message {
    [self showPlaneMessage:message withIconImage:[UIImage imageNamed:@"hud_gray_info"]];
}

- (void)showPlaneMessage:(NSString *)message withIconImage:(UIImage *)iconImage {
    UIView *containerView = [self viewWithTag:kHUDPlaneMessageViewTag];
    if (!containerView) {
        CGRect frame = self.bounds;
        CGPoint contentCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
        containerView = [[UIView alloc] initWithFrame:frame];
        containerView.backgroundColor = HexColor(0xEFEFF4);
        containerView.tag = kHUDPlaneMessageViewTag;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:iconImage];
        
        UILabel *label      = [[UILabel alloc] initWithFrame:CGRectZero];
        label.font          = [UIFont systemFontOfSize:14];
        label.textColor     = HexColor(0xB5B5B5);
        label.text          = message;
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
        // message
        CGRect labelBounds = self.bounds;
        labelBounds.size.width -= 15 * 2;
        labelBounds.size.height = [message boundingRectWithSize:CGSizeMake(CGRectGetWidth(labelBounds), CGFLOAT_MAX)
                                                        options:NSStringDrawingUsesLineFragmentOrigin
                                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                        context:nil].size.height;
        label.bounds = labelBounds;
        label.center = contentCenter;
        imageView.center = CGPointMake(contentCenter.x,
                                       contentCenter.y - CGRectGetHeight(labelBounds)/2 - 15 - CGRectGetHeight(imageView.bounds)/2);
        
        [containerView addSubview:imageView];
        [containerView addSubview:label];
        
        [self addSubview:containerView];
    }
}

- (void)hidePlaneMessage {
    UIView *containerView = [self viewWithTag:kHUDPlaneMessageViewTag];
    if (containerView) {
        [containerView removeFromSuperview];
        containerView = nil;
    }
}

#pragma mark - ToastMessage
- (UILabel *)_createToastLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 2;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.tag = kHUDToastLabelTag;
    return label;
}

- (CGSize)_sizeForToastLabel:(UILabel *)label
              displayMessage:(NSString *)message
                withMaxWidth:(CGFloat)maxWidth {
    
    static const CGFloat kMaxHeight = 40.0f;
    NSDictionary *attributes = @{NSFontAttributeName:label.font};
    CGRect rect = [message boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
    CGSize size = rect.size;
    if (size.height > kMaxHeight) {
        size.height = kMaxHeight;
    }
    
    return size;
}

- (UIView *)_toastMessageViewOnView:(UIView *)view createIfNotExisted:(BOOL)create {
    UIView *toastView = [view viewWithTag:kHUDToastMessageViewTag];
    if (toastView == nil && create) {
        toastView = [[UIView alloc] initWithFrame:CGRectZero];
        toastView.tag = kHUDToastMessageViewTag;
        toastView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        toastView.userInteractionEnabled = YES;
        toastView.layer.cornerRadius = 5.0f;
        UILabel *label = [self _createToastLabel];
        [toastView addSubview:label];
    }
    
    return toastView;
}
- (void)showToastMessage:(NSString *)message {
    //根据消息的文字长度，决定delay时间长短
    //按照人平均阅读速度 400个/分钟
    ReturnIf(message == nil);
    NSTimeInterval delay = [message length] / (400 / 60);
    if (delay < 0.4) {
        delay = 0.4;
    }
    if (delay > 1) {
        delay = 1;
    }
    UIView *showOnView = [[UIApplication sharedApplication]keyWindow];
    NSTimeInterval defaultDuration = delay;
    MBProgressHUD *tipHUD = [[MBProgressHUD alloc] initWithView:showOnView];
    tipHUD.opacity = .4f;
    tipHUD.labelText = message;
    tipHUD.mode = MBProgressHUDModeText;
    [showOnView addSubview:tipHUD];
    [tipHUD show:YES];
    [tipHUD hide:YES afterDelay:defaultDuration];
}
//- (void)showToastMessage:(NSString *)message {
//    UIView *view = [self _toastMessageViewOnView:self createIfNotExisted:YES];
//    [view.layer removeAllAnimations];
//    
//    UILabel *label = (UILabel *)[view viewWithTag:kHUDToastLabelTag];
//    label.text = message;
//    CGSize size = [self _sizeForToastLabel:label
//                            displayMessage:message
//                              withMaxWidth:CGRectGetWidth(self.bounds) * 2 / 3];
//    label.bounds = CGRectMake(0, 0, size.width, size.height);
//    view.bounds = CGRectMake(0, 0, size.width + 16, size.height + 16);
//    label.center = CGPointMake(CGRectGetMidX(view.bounds), CGRectGetMidY(view.bounds));
//    view.center = CGPointMake(CGRectGetMidX(self.bounds),
//                              CGRectGetHeight(self.bounds) + CGRectGetHeight(view.bounds) * 0.5);
//    
//    [self addSubview:view];
//    [UIView animateWithDuration:0.4f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        
//        CGPoint center = view.center;
//        center.y -= 60 + CGRectGetHeight(view.bounds);
//        view.center = center;
//        
//    } completion:^(BOOL finished) {
//        
//        if (!finished) {
//            return;
//        }
//        
//        //根据消息的文字长度，决定delay时间长短
//        //按照人平均阅读速度 400个/分钟
//        NSTimeInterval delay = [message length] / (400/60);
//        [UIView animateWithDuration:0.25f delay:delay options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            view.alpha = 0.0f;
//        } completion:^(BOOL finished) {
//            [view removeFromSuperview];
//        }];
//    }];
//}

@end

