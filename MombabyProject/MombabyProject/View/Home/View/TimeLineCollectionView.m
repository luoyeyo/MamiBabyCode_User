//
//  TimeLineCollectionView.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/16.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "TimeLineCollectionView.h"
#import "HMLineLayout.h"
#import "TimeLineCell.h"

@interface TimeLineCollectionView () {
    NSUInteger _dataCount;
    NSUInteger todayIndex;
}

@property (copy, nonatomic) NSMutableArray *daysArray;

@end

@implementation TimeLineCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultConfig];
    }
    return self;
}

- (void)awakeFromNib {
    [self defaultConfig];
}

- (void)defaultConfig {
    
    // 计算数据源
    CalendarLogic * Logic = [[CalendarLogic alloc]init];
    NSInteger allDay = 0;
    if (kUserInfo.status == kUserStateMum) {
        allDay = kUserStateMomDays;
    } else {
        allDay = kUserStateBabyDays;
    }
    self.daysArray = [Logic reloadCalendarView:nil selectDate:[NSDate date] needDays:allDay];
    self.delegate = self;
    self.dataSource = self;
    self.showsHorizontalScrollIndicator = NO;
    [self setCollectionViewLayout:[[HMLineLayout alloc] init] animated:YES];
    todayIndex = Logic.todayIndex;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:Logic.todayIndex + 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        [self.timeLineDidChangeDelegate timeLineDidChangeToDay:self.daysArray[Logic.todayIndex]];
    });
}

- (void)today {
    [self collectionView:self didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:todayIndex inSection:0]];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.daysArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TimeLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CalendarDayModel *model = self.daysArray[indexPath.row];
    cell.dateLabel.text = [NSString stringWithFormat:@"%ld.%ld",model.month,model.day];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    return CGSizeMake(HMItemWH, HMItemWH);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.timeLineDidChangeDelegate timeLineDidChangeToDay:self.daysArray[indexPath.row]];
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // 左右各偏移一部分
    return UIEdgeInsetsMake(0, self.bounds.size.width / 2, 0, self.bounds.size.width / 2);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取第一个cell的index
    NSInteger row = self.contentOffset.x / HMItemWH + 0.5 - 1;
    [self.timeLineDidChangeDelegate timeLineDidChangeToDay:self.daysArray[row]];
}

@end
