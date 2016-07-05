//
//  NoResponseView.h
//  DoctorProject
//
//  Created by 罗野 on 16/1/26.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NoResponseViewDelegate <NSObject>

- (void)onceAgain;

@end

/**
 *  无数据页面类型
 */
typedef NS_ENUM(NSInteger, kNoResponseType) {
    /**
     *  正常
     */
    kNoResponseTypeNormal = 0,
    /**
     *  无数据
     */
    kNoResponseTypeNoData = 1,
    /**
     *  无网络
     */
    kNoResponseTypeNoConnection = 2,
};

/**
 *  无请求数据页面
 */
@interface NoResponseView : UIView

@property (nonatomic, assign) id<NoResponseViewDelegate> delegate;
@property (nonatomic, assign) kNoResponseType type;
@property (nonatomic, strong) NSString *message;
@end
