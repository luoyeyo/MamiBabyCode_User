//
//  SelfViewController.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/19.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelfViewControllerDelegate <NSObject>

- (void)reloadFaceImageAndName:(NSString *)name;

@end

@interface SelfViewController : ViewController
@property (nonatomic, assign) id<SelfViewControllerDelegate> delegate;
@end
