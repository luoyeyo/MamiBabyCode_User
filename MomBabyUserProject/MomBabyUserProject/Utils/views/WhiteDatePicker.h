//
//  WhiteDatePicker.h
//  pbuXiangShuiiOSClient
//
//  Created by 倾心丶大二姐姐 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import <UIKit/UIKit.h>

enum {
    ModelDate = 0,//格式yyyy-MM-dd
    ModelHour = 1,//格式HH:mm
    ModelDay  = 2 //天数
};
typedef NSUInteger PickerModel;


@protocol whiteDatePickerDelegate;

@interface WhiteDatePicker : UIPickerView

@property (nonatomic, assign) PickerModel datePickerModel;

@property (nonatomic, strong) NSDate   *defaultDate;
@property (nonatomic, strong) NSString *defauleDateStr;
@property (nonatomic, strong) UIColor  *textColor;
@property (nonatomic, assign) id<whiteDatePickerDelegate>dateDelegate;
/**
 *  允许选择今天以后的时间 默认为no
 */
@property (nonatomic, assign) BOOL allowSelectLater;

//显示的数据源
@property (nonatomic, strong) NSMutableArray *firstArr;
@property (nonatomic, strong) NSMutableArray *secondArr;
@property (nonatomic, strong) NSMutableArray *thirdArr;

- (instancetype)initWithFrame:(CGRect)frame pickModel:(PickerModel)model;
- (void)reloadLabel;

@end

@protocol whiteDatePickerDelegate <NSObject>

- (void)reloadSelectDateStr:(NSString *)selectStr Date:(NSDate *)selectDate;

@end
