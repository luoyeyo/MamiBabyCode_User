//
//  HeightAndWeightRange.h
//  MombabyProject
//
//  Created by 罗野 on 16/6/23.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HeightAndWeightRange : JSONModel
@property (nonatomic, copy) NSString *heightLow;
@property (nonatomic, copy) NSString *heightHigh;
@property (nonatomic, copy) NSString *weightLow;
@property (nonatomic, copy) NSString *weightHigh;
@end
