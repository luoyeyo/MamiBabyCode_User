//
//  HeightAndWeightModel.h
//  MombabyProject
//
//  Created by 罗野 on 16/6/23.
//  Copyright © 2016年 luo. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface HeightAndWeightModel : JSONModel
@property (nonatomic, copy) NSString *height;
@property (nonatomic, copy) NSString *kg;
@end
