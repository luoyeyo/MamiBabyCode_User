//
//  WikiTopScrollBtnSView.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/12/28.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "WikiTopScrollBtnSView.h"
#import "XMButton.h"
#import "NSDate+myDate.h"

#define btnCount 5.5

@interface WikiTopScrollBtnSView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic, strong) NSArray *topDataSource;

@property (nonatomic, copy) NSString *days;

@property (nonatomic, assign) int week;
@property (nonatomic, assign) int month;

@end

@implementation WikiTopScrollBtnSView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 创建滑动按钮
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
        _topScrollView.backgroundColor = COLOR_C4;
        _topScrollView.bounces = YES;
        _topScrollView.contentMode = UIControlContentVerticalAlignmentBottom;
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.showsVerticalScrollIndicator = NO;
        _topScrollView.delegate = self;
        [self addSubview:_topScrollView];
        
        // 获取孕周或者月数
        [self getDays];
        
        // 获取初始数据值
        [self information];
        
        // 添加上面一行滑动按钮
        [self setScrollBtn];
    }
    return self;
}

// 获取孕周或者月数
- (void)getDays
{
    // 注册用户
    if (kUserInfo.isLogined) {
        NSString * currentTimeStr = [NSString stringWithFormat:@"%@",kUserInfo.currentTime];
        if (kUserInfo.status == kUserStateMum) { // 孕期天数
            NSString * lastMensesStr = [NSString stringWithFormat:@"%@",kUserInfo.lastMenses];
            //怀孕天数 服务器时间减去末次月经
            self.days = [NSString stringWithFormat:@"%d",[currentTimeStr getVipNumberDay:lastMensesStr]];
            if ([self.days intValue] >= 293) {
                self.days = @"293";
            }
            // 计算孕周
            self.week = self.days.intValue / 7;
        }
        else // 育儿天数
        {
            NSString * birthStr = [NSString stringWithFormat:@"%@",kUserInfo.currentBaby.birth];
            self.days = [NSString stringWithFormat:@"%d",[currentTimeStr getVipNumberDay:birthStr]];
            
            // 计算育儿月数
            self.month = self.days.intValue / 30;
        }
    }
    // 游客
    else
    {
        if (kUserInfo.status == kUserStateMum) { // 游客孕期天数
            
            //预产期
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSDate * yuChanQiDate = [dateFormatter dateFromString:kUserInfo.dueDateStr];
            //得到末次月经
            NSDate * moCiDate = [yuChanQiDate getMensesDate];
            //游客  手机时间减去末次月经 得到 怀孕天数
            self.days = [NSString stringWithFormat:@"%d",[moCiDate getHuaiYunNumberDay]];
            if ([self.days intValue] >= 293) {
                self.days = @"293";
            }
            // 计算孕周
            self.week = self.days.intValue / 7;
        }
        else  // 育儿天数
        {
            NSString * birth = [kUserInfo.currentBaby.birth getTimestamp];
            //得到生日日期
            NSTimeInterval time = [birth doubleValue] + 28800;
            NSDate * birthDay =[NSDate dateWithTimeIntervalSince1970:time];
            self.days = [NSString stringWithFormat:@"%d",[birthDay getChuShengNumberDay]];
            
            // 计算育儿月数
            self.month = self.days.intValue / 30;
            
        }
    }
}

// 获取初始数据值
- (void)information
{
    if (kUserInfo.isLogined) {
        
        if (kUserInfo.status == kUserStateMum) {
            
            self.topDataSource = @[@"0周",@"1周", @"2周", @"3周", @"4周", @"5周", @"6周", @"7周", @"8周", @"9周", @"10周", @"11周", @"12周", @"13周", @"14周", @"15周", @"16周", @"17周", @"18周", @"19周", @"20周", @"21周", @"22周", @"23周", @"24周", @"25周", @"26周", @"27周", @"28周", @"29周", @"30周", @"31周", @"32周", @"33周", @"34周", @"35周", @"36周", @"37周", @"38周", @"39周", @"40周", @"41周", @"42周"];
        }
        else
        {
            self.topDataSource = @[@"0个月", @"1个月", @"2个月", @"3个月", @"4个月", @"5个月", @"6个月", @"7个月", @"8个月", @"9个月", @"10个月", @"11个月", @"12个月", @"13个月", @"14个月", @"15个月", @"16个月", @"17个月", @"18个月", @"19个月", @"20个月", @"21个月", @"22个月", @"23个月", @"24个月", @"25个月", @"26个月", @"27个月", @"28个月", @"29个月", @"30个月", @"31个月", @"32个月", @"33个月", @"34个月", @"35个月", @"36个月", @"37个月", @"38个月", @"39个月", @"40个月", @"41个月", @"42个月", @"43个月", @"44个月", @"45个月", @"46个月", @"47个月", @"48个月", @"49个月", @"50个月", @"51个月", @"52个月", @"53个月", @"54个月", @"55个月", @"56个月", @"57个月", @"58个月", @"59个月", @"60个月", @"61个月", @"62个月", @"63个月", @"64个月", @"65个月", @"66个月", @"67个月", @"68个月", @"69个月", @"70个月", @"71个月"];
        }
    }
    else
    {
        if (kUserInfo.status == kUserStateMum) {
            self.topDataSource = @[@"0周",@"1周", @"2周", @"3周", @"4周", @"5周", @"6周", @"7周", @"8周", @"9周", @"10周", @"11周", @"12周", @"13周", @"14周", @"15周", @"16周", @"17周", @"18周", @"19周", @"20周", @"21周", @"22周", @"23周", @"24周", @"25周", @"26周", @"27周", @"28周", @"29周", @"30周", @"31周", @"32周", @"33周", @"34周", @"35周", @"36周", @"37周", @"38周", @"39周", @"40周", @"41周", @"42周"];
        }
        else
        {
            self.topDataSource = @[@"0个月", @"1个月", @"2个月", @"3个月", @"4个月", @"5个月", @"6个月", @"7个月", @"8个月", @"9个月", @"10个月", @"11个月", @"12个月", @"13个月", @"14个月", @"15个月", @"16个月", @"17个月", @"18个月", @"19个月", @"20个月", @"21个月", @"22个月", @"23个月", @"24个月", @"25个月", @"26个月", @"27个月", @"28个月", @"29个月", @"30个月", @"31个月", @"32个月", @"33个月", @"34个月", @"35个月", @"36个月", @"37个月", @"38个月", @"39个月", @"40个月", @"41个月", @"42个月", @"43个月", @"44个月", @"45个月", @"46个月", @"47个月", @"48个月", @"49个月", @"50个月", @"51个月", @"52个月", @"53个月", @"54个月", @"55个月", @"56个月", @"57个月", @"58个月", @"59个月", @"60个月", @"61个月", @"62个月", @"63个月", @"64个月", @"65个月", @"66个月", @"67个月", @"68个月", @"69个月", @"70个月", @"71个月"];
        }
    }
}

- (void)setScrollBtn
{
    self.topScrollView.contentSize = CGSizeMake(ScreenWidth / btnCount * self.topDataSource.count, 0);
    
    for (int i = 0; i < self.topDataSource.count; i ++) {
        
        CGFloat backButtonX = 5 + (ScreenWidth / btnCount) * i;
        CGFloat backButtonW = ScreenWidth / btnCount - 10;
        CGFloat backButtonH = 35;
        CGFloat backButtonY = 5;
        XMButton *backButton = [[XMButton alloc] initWithFrame:CGRectMake(backButtonX, backButtonY, backButtonW, backButtonH)];
        backButton.layer.masksToBounds = YES;
        backButton.layer.cornerRadius = 3;
        [backButton setBackgroundImage:[UIImage imageNamed:@"chooseBtn_selected"] forState:UIControlStateSelected];
        [backButton addTarget:self action:@selector(topBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        backButton.tag = 100 + i;
        
        [_topScrollView addSubview:backButton];
        
        if (kUserInfo.isLogined) {
            
            if (kUserInfo.status == kUserStateMum) {
                backButton.topLabel.text = @"怀孕";
                self.topScrollView.contentOffset = CGPointMake(ScreenWidth / btnCount * self.week, 0);
                if (i == self.week) {
                    backButton.selected = YES;
                }
            }
            else
            {
                backButton.topLabel.text = @"月龄";
                self.topScrollView.contentOffset = CGPointMake(ScreenWidth / btnCount * self.month, 0);
                if (i == self.month) {
                    backButton.selected = YES;
                }
            }
        }
        else
        {
            if (kUserInfo.status == kUserStateMum) {
                backButton.topLabel.text = @"怀孕";
                self.topScrollView.contentOffset = CGPointMake(ScreenWidth / btnCount * self.week, 0);
                if (i == self.week) {
                    backButton.selected = YES;
                }
            }
            else
            {
                backButton.topLabel.text = @"月龄";
                self.topScrollView.contentOffset = CGPointMake(ScreenWidth / btnCount * self.month, 0);
                if (i == self.month) {
                    backButton.selected = YES;
                }
            }
        }
        backButton.bottomLabel.text = self.topDataSource[i];
    }
}

// 上面一行滑动按钮点击事件
- (void)topBtnClick:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.selected == NO)
    {
        for (int i = 0; i < self.topDataSource.count; i++) {
            UIButton * otherButton = (UIButton *)[self viewWithTag:100 + i];
            if (otherButton.tag != button.tag) {
                
                otherButton.selected = NO;
                otherButton.userInteractionEnabled = YES;
            }
        }
        button.selected = !button.selected;
        if (button.selected == YES) {
            button.userInteractionEnabled = NO;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"days" object:@(button.tag - 100)];
}

@end
