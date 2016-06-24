//
//  UIView+HUDExtensions.h
//  Parking
//
//  Created by ZhangTinghui on 14/12/13.
//  Copyright (c) 2014年 www.660pp.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIViewPopupMessageType) {
    UIViewPopupMessageTypeOK,
    UIViewPopupMessageTypeError
};

@interface UIView (HUDExtensions)

#pragma mark - Popup Loading
- (void)showPopupLoading;
- (void)showPopupLoadingWithText:(NSString *)text;
- (void)showPopupLoadingWithText:(NSString *)text hideAfterDelay:(float)delay;
- (void)hidePopupLoading;
- (void)hidePopupLoadingAnimated:(BOOL)animated;

#pragma mark - Popup Message
- (void)showPopupOKMessage:(NSString *)message;
- (void)showPopupErrorMessage:(NSString *)message;
- (void)showPopupMessage:(NSString *)message type:(UIViewPopupMessageType)type;
- (void)showPopupMessage:(NSString *)message type:(UIViewPopupMessageType)type completion:(void(^)(void))completion;

#pragma mark - PlaneLoading
- (void)showPlaneLoading;
- (void)hidePlaneLoading;

#pragma mark - PlaneMessage
- (void)showPlaneMessage:(NSString *)message;
- (void)showPlaneMessage:(NSString *)message withIconImage:(UIImage *)iconImage;
- (void)hidePlaneMessage;

#pragma mark - ToastMessage
- (void)showToastMessage:(NSString *)message;

@end
