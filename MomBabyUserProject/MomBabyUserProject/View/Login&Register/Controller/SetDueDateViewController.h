//
//  SetDueDateViewController.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/20.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
   dueType,
   lastMensType,
}dateType;

@interface SetDueDateViewController : ViewController

@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, assign) NSInteger dateType;

@end
