    //
//  WhiteDatePicker.m
//  pbuXiangShuiiOSClient
//
//  Created by 倾心丶大二姐姐 on 15/11/16.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "WhiteDatePicker.h"

@interface WhiteDatePicker () <UIPickerViewDataSource,UIPickerViewDelegate>

{
    UILabel *firstLabel;
    UILabel *secondLabel;
    UILabel *thirdLabel;
    
    //    NSMutableArray *_firstArr;
    //    NSMutableArray *_secondArr;
    //    NSMutableArray *_thirdArr;
    
    NSString *_selectFirst;
    NSString *_selectSecond;
    NSString *_selectThird;
    
    NSDateFormatter *_formatter;
}

@end

@implementation WhiteDatePicker

- (instancetype)initWithFrame:(CGRect)frame pickModel:(PickerModel)model
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsSelectionIndicator = YES;
        _firstArr  = [[NSMutableArray alloc]init];
        _secondArr = [[NSMutableArray alloc]init];
        _thirdArr   = [[NSMutableArray alloc]init];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.datePickerModel = model;//默认
        
        _formatter = [[NSDateFormatter alloc]init];
        
        self.textColor = [UIColor blackColor];
        firstLabel = [[UILabel alloc]init];
        [firstLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [firstLabel setHidden:YES];
        [self addSubview:firstLabel];
        
        secondLabel = [[UILabel alloc]init];
        [secondLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [firstLabel setHidden:YES];
        [self addSubview:secondLabel];
        
        thirdLabel = [[UILabel alloc]init];
        [thirdLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [thirdLabel setHidden:YES];
        [self addSubview:thirdLabel];
        
        [self reloadSomeData];
    }
    return self;
}

#pragma mark - set方法

- (void)setTextColor:(UIColor *)textColor {
    
    _textColor = textColor;
    
    [firstLabel  setTextColor:self.textColor];
    [secondLabel setTextColor:self.textColor];
    [thirdLabel  setTextColor:self.textColor];
    
    [self reloadAllComponents];
}

- (void)setDatePickerModel:(PickerModel)datePickerModel {
    
    _datePickerModel = datePickerModel;
    
    [self reloadSomeData];
    
}

- (void)setFirstArr:(NSMutableArray *)firstArr {
    
    [self.firstArr removeAllObjects];
    [_firstArr addObjectsFromArray:firstArr];
    
    [self reloadAllComponents];
    
}

- (void)setSecondArr:(NSMutableArray *)secondArr {
    
    [self.secondArr removeAllObjects];
    [_secondArr addObjectsFromArray:secondArr];
    
    [self reloadAllComponents];
    
}

- (void)setThirdArr:(NSMutableArray *)thirdArr {
    
    [self.thirdArr removeAllObjects];
    [_thirdArr addObjectsFromArray:thirdArr];
    
    [self reloadAllComponents];
    
}

- (void)setDefauleDateStr:(NSString *)defauleDateStr {
    
    _defauleDateStr = defauleDateStr;
    
    [self reloadDateStr];
    
    [self reloadAllComponents];
}

- (void)setDefaultDate:(NSDate *)defaultDate {
    _defaultDate = defaultDate;
    
    _defauleDateStr = [_formatter stringFromDate:_defaultDate];
    
    [self reloadDateStr];
    
    [self reloadAllComponents];
}


#pragma mark - 自定义方法
- (void)reloadSomeData {
    [self getDataWith:_datePickerModel];
    [self reloadLabel];
    [self reloadDateStr];
}

- (void)reloadDateStr {
    switch (self.datePickerModel) {
        case ModelDate:
        {
            _formatter.dateFormat = @"yyyy-MM-dd";
            NSArray *array = [_defauleDateStr componentsSeparatedByString:@"-"];
            if (array.count == 3) {
                _selectFirst = array[0];_selectSecond = array[1];_selectThird = array[2];
            } else {
                _selectFirst = @"1990";_selectSecond = @"01";_selectThird = @"01";
            }
            [self selectRow:self.firstArr.count - 1  inComponent:0 animated:NO];
            [self selectRow:[_selectSecond intValue] - 1 inComponent:1 animated:NO];
            [self selectRow:[_selectThird intValue] - 1  inComponent:2 animated:NO];
            break;
        }
        case ModelHour:
        {
            _formatter.dateFormat = @"HH:mm";
            NSArray *array = [_defauleDateStr componentsSeparatedByString:@":"];
            if (array.count == 2) {
                _selectFirst = array[0];_selectSecond = array[1];
            } else {
                _selectFirst = @"22";_selectSecond = @"00";
            }
            [self selectRow:[_selectFirst intValue]  inComponent:0 animated:NO];
            [self selectRow:[_selectSecond intValue] inComponent:1 animated:NO];
            break;
        }
        case ModelDay:
        {
            [self selectRow:0 inComponent:0 animated:NO];
            break;
        }
        default:
            break;
    }
}

- (void)reloadLabel {
    
    [firstLabel setTextColor:self.textColor];
    [secondLabel setTextColor:self.textColor];
    [thirdLabel setTextColor:self.textColor];
    
    switch (_datePickerModel) {
        case ModelDate:
        {
            [firstLabel  setHidden:NO];
            [secondLabel setHidden:NO];
            [thirdLabel  setHidden:NO];
            [firstLabel setText:@"年"];
            [secondLabel setText:@"月"];
            [thirdLabel setText:@"日"];
            CGSize year = [self rowSizeForComponent:0];
            CGSize month = [self rowSizeForComponent:1];
            CGSize day = [self rowSizeForComponent:2];
            [firstLabel setFrame:CGRectMake(year.width - 30, (self.frame.size.height-year.height)/2, 20, year.height)];
            [secondLabel setFrame:CGRectMake(month.width+year.width - 30, (self.frame.size.height-month.height)/2, 20, month.height)];
            [thirdLabel setFrame:CGRectMake(month.width+year.width+day.width-30, (self.frame.size.height-day.height)/2, 20, day.height)];
            
            break;
        }
        case ModelHour:
        {
            [firstLabel  setHidden:NO];
            [secondLabel setHidden:NO];
            [firstLabel setText:@"时"];
            [secondLabel setText:@"分"];
            CGSize hour = [self rowSizeForComponent:0];
            CGSize min = [self rowSizeForComponent:1];
            [firstLabel setFrame:CGRectMake(hour.width-50, (self.frame.size.height-hour.height)/2, 20, hour.height)];
            [secondLabel setFrame:CGRectMake(min.width+hour.width-50, (self.frame.size.height-min.height)/2, 20, min.height)];
            break;
        }
        case ModelDay:
        {
            [firstLabel setHidden:NO];
            [firstLabel setText:@"天"];
            CGSize day = [self rowSizeForComponent:0];
            [firstLabel setFrame:CGRectMake(day.width-100, (self.frame.size.height-day.height)/2, 20, day.height)];
            break;
        }
        default:
            break;
    }
    
}

- (void)getDataWith:(PickerModel)pickerModel {
    [_firstArr removeAllObjects];
    [_secondArr removeAllObjects];
    [_thirdArr removeAllObjects];
    switch (pickerModel) {
        case ModelDate:
        {
            for (NSInteger i = ([self getCurrentYear] - 10); i < [self getCurrentYear] + 1; i++) {
                [_firstArr addObject:[NSString stringWithFormat:@"%ld",i]];
            }
            for (int i = 1; i < 13; i++) {
                if (i < 10) {
                    [_secondArr addObject:[NSString stringWithFormat:@"0%d",i]];
                } else {
                    [_secondArr addObject:[NSString stringWithFormat:@"%d",i]];
                }
            }
            for (int i = 1; i < 32; i++) {
                if (i < 10) {
                    [_thirdArr addObject:[NSString stringWithFormat:@"0%d",i]];
                } else {
                    [_thirdArr addObject:[NSString stringWithFormat:@"%d",i]];
                }
            }
            break;
        }
        case ModelHour:
        {
            for (int i = 0; i <= 23; i++) {
                NSString *string = @"";
                if (i < 10) {
                    string = [NSString stringWithFormat:@"0%d",i];
                }else{
                    string = [NSString stringWithFormat:@"%d",i];
                }
                [_firstArr addObject:string];
            }
            
            NSInteger min = 0;
            for (int i = 0; i < 60 / 15; i++) {
                NSString *str = @"";
                if (min < 10) {
                    str = [NSString stringWithFormat:@"0%ld",(long)min];
                } else {
                    str = [NSString stringWithFormat:@"%ld",(long)min];
                }
                min += 15;
                [_secondArr addObject:str];
            }
            
            break;
        }
        case ModelDay:
        {
            for (int i = 0; i < 8; i++) {
                [_firstArr addObject:[NSString stringWithFormat:@"%d",i]];
            }
            break;
        }
        default:
            break;
    }
    [self reloadAllComponents];
}

#pragma mark - 协议方法

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *myView = [[UILabel alloc]init];
    myView.backgroundColor = [UIColor clearColor];
    myView.textAlignment = NSTextAlignmentCenter;
    myView.font = [UIFont systemFontOfSize:18];
    myView.textColor = _textColor;
    if (component == 0) {
        CGSize year = [pickerView rowSizeForComponent:0];
        myView.frame = CGRectMake(0.0, 0.0, year.width , year.height);
        myView.text = [_firstArr objectAtIndex:row];
    } else if (component == 1) {
        CGSize month = [pickerView rowSizeForComponent:1];
        myView.frame = CGRectMake(0.0, 0.0, month.width , month.height);
        myView.text = [_secondArr objectAtIndex:row];
    } else {
        CGSize day = [pickerView rowSizeForComponent:2];
        myView.frame = CGRectMake(0.0, 0.0, day.width , day.height);
        myView.text = [_thirdArr objectAtIndex:row];
    }
    return myView;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.datePickerModel) {
        case ModelDate:
            return 3;
        case ModelHour:
            return 2;
        case ModelDay:
            return 1;
        default:
            break;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return _firstArr.count;
        case 1:
            return _secondArr.count;
        case 2:
            return _thirdArr.count;
        default:
            break;
    }
    return 0;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 65;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return _firstArr[row];
        case 1:
            return _secondArr[row];
        case 2:
            return _thirdArr[row];
        default:
            break;
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    switch (component) {
        case 0:
            _selectFirst = _firstArr[row];
            [self checkLeapYear];
            break;
        case 1:
            _selectSecond = _secondArr[row];
            [self checkLeapYear];
            break;
        case 2:
        {
            _selectThird = _thirdArr[row];
            [self checkLeapYear];
            break;
        }
        default:
            break;
    }
    
    NSString *selectStr;
    switch (_datePickerModel) {
        case ModelDate:
        {
            selectStr = [NSString stringWithFormat:@"%@-%@-%@",_selectFirst,_selectSecond,_selectThird];
            break;
        }
        case ModelHour:
        {
            selectStr = [NSString stringWithFormat:@"%@:%@",_selectFirst,_selectSecond];
            break;
        }
        case ModelDay:
        {
            selectStr = _selectFirst;
            break;
        }
        default:
            break;
    }
    
    
    NSDate *selectDate = [_formatter dateFromString:selectStr];
    [self.dateDelegate reloadSelectDateStr:selectStr Date:selectDate];
//    NSLog(@"%@",selectStr);
}

- (void)checkLeapYear {
    if (self.datePickerModel == ModelDate) {
        if (self.allowSelectLater == NO) {
            // 如果是选的今年 不能超过今天
            NSInteger year = [self getCurrentYear];
            NSInteger month = [self getCurrentMonth];
            NSInteger day = [self getCurrentDay];
            if ([_selectFirst integerValue] == year) {
                if ([_selectSecond integerValue] > month) {
                    _selectSecond = [NSString stringWithFormat:@"%ld",month];
                    [self selectRow:month - 1 inComponent:1 animated:YES];
                }
                ReturnIf([_selectSecond integerValue] < month);
                if ([_selectThird integerValue] > day) {
                    _selectThird = [NSString stringWithFormat:@"%ld",day];
                    [self selectRow:day - 1 inComponent:2 animated:YES];
                }
            }
        }
        //判断闰年，大小月
        switch ([_selectSecond integerValue]) {
            case 1: case 3: case 5: case 7: case 8: case 10: case 12:
                
                break;
            case 4: case 6: case 9: case 11:
            {
                if ([_selectThird integerValue] > 30) {
                    _selectThird = @"30";
                    [self selectRow:29 inComponent:2 animated:YES];
                }
                break;
            }
            case 2:
            {
                if ([_selectThird integerValue] > 28) {
                    int yearNum = [_selectFirst integerValue];
                    if ((yearNum % 4 == 0 && yearNum % 100 != 0)||(yearNum % 400 == 0)) {
                        //闰年
                        if ([_selectThird integerValue] > 29) {
                            _selectThird = @"29";
                            [self selectRow:28 inComponent:2 animated:YES];
                        }
                    } else {
                        //平年
                        _selectThird = @"28";
                        [self selectRow:27 inComponent:2 animated:YES];
                    }
                }
                break;
            }
            default:
                break;
        }
    }
}

- (NSInteger)getCurrentYear {
    NSDate *current = [NSDate date];
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    form.dateFormat = @"YYYY";
    NSString *yearStr = [form stringFromDate:current];
    return [yearStr integerValue];
}

- (NSInteger)getCurrentMonth {
    NSDate *current = [NSDate date];
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    form.dateFormat = @"MM";
    NSString *monthStr = [form stringFromDate:current];
    return [monthStr integerValue];
}

- (NSInteger)getCurrentDay {
    NSDate *current = [NSDate date];
    NSDateFormatter *form = [[NSDateFormatter alloc] init];
    form.dateFormat = @"dd";
    NSString *dayStr = [form stringFromDate:current];
    return [dayStr integerValue];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
