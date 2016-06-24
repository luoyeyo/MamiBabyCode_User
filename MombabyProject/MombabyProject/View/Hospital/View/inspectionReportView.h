//
//  inspectionReportView.h
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/24.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@protocol inspectionReportViewDelegate <NSObject>

- (void)topAndNext:(NSString *)tex;

@end

@interface inspectionReportView : UIView<CardViewDelegate>
@property (nonatomic, strong) NSMutableArray * allData;    //外部数据  大数组;
@property (nonatomic, assign) id <inspectionReportViewDelegate> delegate;
- (id)initWithFrame:(CGRect)frame allArr:(NSMutableArray *)arr;


@end
