//
//  WikiModel.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/12/28.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WikiModel : NSObject

/**
 *  栏目 ID
 */
@property (nonatomic, copy) NSString * parentId;
/**
 *  标题
 */
@property (nonatomic, copy) NSString * title;
/**
 *  栏目图标(缩略图)
 */
@property (nonatomic, copy) NSString * mediumIconImage;
/**
 *  栏目图标(大图)
 */
@property (nonatomic, copy) NSString * realIconImage;
/**
 *  介绍
 */
@property (nonatomic, copy) NSString * introduction;

@end
