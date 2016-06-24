//
//  ResuletFoodListModel.h
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/12/18.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResuletFoodListModel : HttpResponseData

/**
 *  查询结果id
 */
@property (nonatomic, copy) NSString * resuleId;
/**
 *  蛋白质
 */
@property (nonatomic, copy) NSString * protein;
/**
 *  食物名字
 */
@property (nonatomic, copy) NSString * name;
/**
 *  卡路里
 */
@property (nonatomic, copy) NSString * calorie;

@property (nonatomic, copy) NSString * unit;

@end
