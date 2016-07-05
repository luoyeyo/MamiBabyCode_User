//
//  inspectionReportView.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/24.
//  Copyright © 2015年 龙源美生. All rights reserved.
//


#import "inspectionReportView.h"
#import "NSDate+myDate.h"

@implementation inspectionReportView{
    NSInteger _index;
    CardView * _card;
}


- (id)initWithFrame:(CGRect)frame allArr:(NSMutableArray *)arr{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        _index = 0;
        self.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
        self.allData = [NSMutableArray array];   //大数组;
        
        [self.allData addObjectsFromArray:arr];
        [self createCardView];
    }
    return self;
}

- (void)createCardView{
    
    CGFloat heightHHH = 10;
    CGFloat witdhHHH = 10;
    
    for (int i = 0; i < 2; i++) {
        UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(10 + witdhHHH * i, 40 - i * heightHHH, self.width - (10 + witdhHHH * i) * 2, self.height - (40 - i * heightHHH) * 2)];
        downView.backgroundColor = [UIColor whiteColor];
        downView.layer.cornerRadius = 5;
        downView.layer.masksToBounds = YES;
        downView.layer.borderColor = [UIColor colorFromHexRGB:@"e2e2e2"].CGColor;
        downView.layer.borderWidth = 0.5;
        downView.layer.shadowColor = [UIColor blackColor].CGColor;
        downView.layer.shadowOpacity = 0.33;
        downView.layer.shadowOffset = CGSizeMake(0, 1.5);
        downView.layer.shadowRadius = 4.0;
        downView.layer.shouldRasterize = YES;
        [self addSubview:downView];
    }
    
    CardView * card = [[CardView alloc] initWithFrame:CGRectMake(10 + witdhHHH * 2, 40 - 2 * heightHHH, self.width - (10 + witdhHHH * 2) * 2, self.height - (40 - 2 * heightHHH) * 2)];
    card.layer.borderColor = [UIColor colorFromHexRGB:@"e2e2e2"].CGColor;
    card.layer.borderWidth = 0.5;
    card.tag = 10;
    card.userInteractionEnabled = NO;
    card.backgroundColor = [UIColor whiteColor];
    card.sdelegate = self;
    [self addSubview:card];
    
    for (int i = 0; i < 2; i++) {
        CardView * card = [[CardView alloc] initWithFrame:CGRectMake(10 + witdhHHH * 2, 40 - 2 * heightHHH, self.width - (10 + witdhHHH * 2) * 2, self.height - (40 - 2 * heightHHH) * 2)];
        card.layer.borderColor = [UIColor colorFromHexRGB:@"e2e2e2"].CGColor;
        card.layer.borderWidth = 0.5;
        card.tag = 12-i;
        card.backgroundColor = [UIColor whiteColor];
        card.sdelegate = self;
        if (i == 0) {
            card.userInteractionEnabled = NO;
        }
        [self addSubview:card];
    }
    [self reloadData];
}

- (void)nextView:(UIView *)view{
    if (_index < _allData.count-1) {
        [UIView animateWithDuration:0.5 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-500, -100);
            transform = CGAffineTransformRotate(transform, M_PI*0.12);
            view.transform = transform;
        } completion:^(BOOL finished) {
            _index++;
            [self reloadData];
            CardView * cardV = (CardView *)[self viewWithTag:10];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-500, -100);
            transform = CGAffineTransformRotate(transform, M_PI*0.12);
            cardV.alpha = 0.0f;
            cardV.transform = transform;
        }];
    } else {
        //已经到最后一张
        [self.delegate topAndNext:@"最后"];
    }
}

- (void)historyView:(UIView *)historyView{
    if (_index) {
        _index--;
        CardView * cardV = (CardView *)[self viewWithTag:10];
        [cardV.superview bringSubviewToFront:cardV];
        [UIView animateWithDuration:0.5 animations:^{
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
            transform = CGAffineTransformRotate(transform, 0);
            cardV.transform = transform;
            cardV.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [self reloadData];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-500, -100);
            transform = CGAffineTransformRotate(transform, M_PI*0.12);
            cardV.alpha = 0.0f;
            cardV.transform = transform;
        }];
    } else {
        //第一张
        [self.delegate topAndNext:@"第一"];
    }
}

- (void)reloadData{
    for (int i = 0; i < 3; i++) {
        if (_index+i-1 >= 0 && _index+i-1 < _allData.count) {
            NSDictionary * dic = [_allData objectAtIndex:_index+i-1];
            CardView * cardV = (CardView *)[self viewWithTag:i + 10];
            if (i > 0) {
                CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
                transform = CGAffineTransformRotate(transform, 0);
                cardV.transform = transform;
                cardV.alpha = 1.0f;
                cardV.transform = CGAffineTransformIdentity;
            }
            
            NSString * numberText;
            NSString * weekText;
            NSString * dateTest;
            
            NSString * muDiText;
            NSString * xiangMuText;
            if (kUserInfo.isLogined) {
                //有账号
                if (kUserInfo.status == kUserStateMum) {
                    //孕期
                    int weekStart = [[dic objectForKey:@"weekStart"] intValue];
                    int weekEnd = [[dic objectForKey:@"weekEnd"] intValue] + 1;
                    
                    NSTimeInterval time = [kUserInfo.lastMenses intValue] + 28800 + weekStart * 7 * 60 * 60 * 24;
                    NSDate * weekStartDate = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"MM月dd日"];
                    NSString * weekStr = [dateFormatter stringFromDate:weekStartDate];
                    
                    NSTimeInterval timeEnd = [kUserInfo.lastMenses intValue] + 28800 + weekEnd * 7 * 60 * 60 * 24;
                    NSDate * weekEndDate = [NSDate dateWithTimeIntervalSince1970:timeEnd];
                    NSDateFormatter * dateFormatterEnd = [[NSDateFormatter alloc] init];
                    [dateFormatterEnd setDateFormat:@"MM月dd日"];
                    NSString * weekStrEnd = [dateFormatterEnd stringFromDate:weekEndDate];
                    
                    weekText = [NSString stringWithFormat:@"%d周 ~ %d周",weekStart,weekEnd - 1];
                    dateTest = [NSString stringWithFormat:@"(%@ ~ %@)",weekStr,weekStrEnd];
                    muDiText = @"本次产检目的:";
                    xiangMuText = @"本次产检项目:";
                }
                else{
                    //育儿
                    int weekStart = [[dic objectForKey:@"weekStart"] intValue];
                    int weekEnd = [[dic objectForKey:@"weekEnd"] intValue] + 1;
                    
                    NSTimeInterval time = [kUserInfo.currentBaby.birth intValue] + 28800 + weekStart * 7 * 60 * 60 * 24;
                    NSDate * weekStartDate = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"MM月dd日"];
                    NSString * weekStr = [dateFormatter stringFromDate:weekStartDate];
                    
                    NSTimeInterval timeEnd = [kUserInfo.currentBaby.birth intValue] + 28800 + weekEnd * 7 * 60 * 60 * 24;
                    NSDate * weekEndDate = [NSDate dateWithTimeIntervalSince1970:timeEnd];
                    NSDateFormatter * dateFormatterEnd = [[NSDateFormatter alloc] init];
                    [dateFormatterEnd setDateFormat:@"MM月dd日"];
                    NSString * weekStrEnd = [dateFormatterEnd stringFromDate:weekEndDate];
                    
                    weekText = [NSString stringWithFormat:@"%d月 ~ %d月",weekStart,weekEnd - 1];
                    dateTest = [NSString stringWithFormat:@"(%@ ~ %@)",weekStr,weekStrEnd];

                    muDiText = @"本次体检目的:";
                    xiangMuText = @"本次体检项目:";
                }
            }
            else{
                //游客
                
                if (kUserInfo.status == kUserStateMum) {
                    //孕期
                    NSTimeInterval dueTime = [[kUserInfo.dueDateStr getTimestamp] doubleValue] + 28800;
                    NSDate * dueDate = [NSDate dateWithTimeIntervalSince1970:dueTime];
                    NSDate * lastM = [dueDate getMensesDate];
                    
                    int weekStart = [[dic objectForKey:@"weekStart"] intValue];
                    int weekEnd = [[dic objectForKey:@"weekEnd"] intValue] + 1;
                    
                    NSTimeInterval time = lastM.timeIntervalSince1970 + weekStart * 7 * 60 * 60 * 24;
                    NSDate * weekStartDate = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"MM月dd日"];
                    NSString * weekStr = [dateFormatter stringFromDate:weekStartDate];
                    
                    NSTimeInterval timeEnd = lastM.timeIntervalSince1970 + weekEnd * 7 * 60 * 60 * 24;
                    NSDate * weekEndDate = [NSDate dateWithTimeIntervalSince1970:timeEnd];
                    NSDateFormatter * dateFormatterEnd = [[NSDateFormatter alloc] init];
                    [dateFormatterEnd setDateFormat:@"MM月dd日"];
                    NSString * weekStrEnd = [dateFormatterEnd stringFromDate:weekEndDate];
                    
                    
                    weekText = [NSString stringWithFormat:@"%d周 ~ %d周",weekStart,weekEnd - 1];
                    dateTest = [NSString stringWithFormat:@"(%@ ~ %@)",weekStr,weekStrEnd];

                    muDiText = @"本次产检目的:";
                    xiangMuText = @"本次产检项目:";
                }
                else{
                    int weekStart = [[dic objectForKey:@"weekStart"] intValue];
                    int weekEnd = [[dic objectForKey:@"weekEnd"] intValue] + 1;
                    
                    NSTimeInterval birTime = [[kUserInfo.currentBaby.birth getTimestamp] doubleValue] + 28800;
                    
                    
                    NSTimeInterval time = birTime + weekStart * 7 * 60 * 60 * 24;
                    NSDate * weekStartDate = [NSDate dateWithTimeIntervalSince1970:time];
                    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"MM月dd日"];
                    NSString * weekStr = [dateFormatter stringFromDate:weekStartDate];
                    
                    NSTimeInterval timeEnd = birTime + weekEnd * 7 * 60 * 60 * 24;
                    NSDate * weekEndDate = [NSDate dateWithTimeIntervalSince1970:timeEnd];
                    NSDateFormatter * dateFormatterEnd = [[NSDateFormatter alloc] init];
                    [dateFormatterEnd setDateFormat:@"MM月dd日"];
                    NSString * weekStrEnd = [dateFormatterEnd stringFromDate:weekEndDate];
                    
                    
                    weekText = [NSString stringWithFormat:@"%d月 ~ %d月",weekStart,weekEnd - 1];
                    dateTest = [NSString stringWithFormat:@"(%@ ~ %@)",weekStr,weekStrEnd];
                    
                    muDiText = @"本次体检目的:";
                    xiangMuText = @"本次体检项目:";
                }
            }
            
            numberText = [dic objectForKey:@"title"];
            
            CGFloat numBerLabelWitdh = [numberText sizeWithFont:UIFONT_H3_14 maxSize:CGSizeMake(MAXFLOAT, 38)].width + 20;
            cardV.numberLabel.frame = CGRectMake((cardV.width - numBerLabelWitdh) / 2, 0, numBerLabelWitdh, 38);
            
            cardV.numberLabel.text = numberText;
            cardV.muDiLabel.text = muDiText;
            cardV.xiangMuLabel.text = xiangMuText;
            
            cardV.weeksLabel.text = weekText;
            cardV.dateLabel.text = dateTest;
            
            NSString * goalStr = [dic objectForKey:@"purpose"];
            CGFloat goalHeight = [goalStr sizeWithFont:UIFONT_H3_14 maxSize:CGSizeMake(self.width - 70, MAXFLOAT)].height;
            cardV.goalLabel.frame = CGRectMake(5, cardV.muDiLabel.bottom + 5, self.width - 70, goalHeight);
            cardV.goalLabel.text = goalStr;
            cardV.xiangMuLabel.frame = CGRectMake(5, cardV.goalLabel.bottom + 5, self.width - 70, 20);
            
            NSString * projectStr = [dic objectForKey:@"items"];
            CGFloat projectHeight = [projectStr sizeWithFont:UIFONT_H3_14 maxSize:CGSizeMake(self.width - 70, MAXFLOAT)].height;
            cardV.projectLabel.frame = CGRectMake(5, cardV.xiangMuLabel.bottom + 5, self.width - 70, projectHeight);
            cardV.projectLabel.text = projectStr;
            cardV.contentSize = CGSizeMake(0, cardV.projectLabel.bottom + 10);
        }
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
