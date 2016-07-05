//
//  NutritionTableViewCell.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/24.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "NutritionTableViewCell.h"
#import "NutritionModel.h"
#import "FoodModel.h"
#import "NutritionResultViewController.h"

@implementation NutritionTableViewCell


+ (instancetype)cellWithTable:(UITableView *)tableView indexPtah:(NSIndexPath*)indexPath nutritionData:(NSArray *)nutritionData foodData:(NSArray *)foodData
{
    static NSString *iden = @"iden";
    NutritionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:iden];
    
    cell = [[NutritionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell cellSetContentViewWithNutritionData:nutritionData foodData:foodData];
    
    return cell;
}


// 创建 cell UI
- (void)cellSetContentViewWithNutritionData:(NSArray *)nutritionData foodData:(NSArray *)foodData
{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight * 1.5)];
    [self addSubview:backView];
    
    // 选项文字提醒1
    CGFloat chooseLabel1X = 10;
    CGFloat chooseLabel1H = 15;
    CGFloat chooseLabel1Y = (44 - chooseLabel1H) * 0.5;
    CGFloat chooseLabel1W = ScreenWidth - chooseLabel1X * 2;
    UILabel *chooseLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(chooseLabel1X, chooseLabel1Y, chooseLabel1W, chooseLabel1H)];
    chooseLabel1.font = UIFONT_H4_15;
    chooseLabel1.textColor = COLOR_C1;
    chooseLabel1.text = @"选择需要补充的营养（单选）:";
    chooseLabel1.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:chooseLabel1];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, ScreenWidth, 1)];
    line.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [backView addSubview:line];
    
    // 选项文字1
    self.nutritionNames = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in nutritionData) {
        NutritionModel *model = [[NutritionModel alloc] init];
        model.nutritionName = dict[@"name"];
        model.nutritionId = dict[@"id"];
        [self.nutritionNames addObject:model];
    }
    
    // 选项背景1
    CGFloat chooseView1X = 0;
    CGFloat chooseView1H = 10 + (10 + 31) * (self.nutritionNames.count / 3) + 31 + 10;
    CGFloat chooseView1Y = 44;
    CGFloat chooseView1W = ScreenWidth;
    UIView *chooseView1 = [[UIView alloc] initWithFrame:CGRectMake(chooseView1X, chooseView1Y, chooseView1W, chooseView1H)];
    chooseView1.backgroundColor = COLOR_C4;
    [backView addSubview:chooseView1];
    
    for (int i = 0; i < self.nutritionNames.count; i ++)
    {
        NutritionModel *model = self.nutritionNames[i];
        NSInteger row = i / 3; // 取商返回的行数
        NSInteger col = i % 3; // 取余返回的列数
        
        CGFloat buttonX = 10 + ((ScreenWidth - 40) / 3 + 10) * col;
        CGFloat buttonH = 31;
        CGFloat buttonY = 10 + (10 + 31) * row;
        CGFloat buttonW = (ScreenWidth - 40) / 3;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = UIFONT_H2_13;
        [button setTitle:model.nutritionName forState:UIControlStateNormal];
        [button setTitleColor:COLOR_C2 forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"chooseBtn_selected"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"chooseBtn_cancel"] forState:UIControlStateNormal];
        [button setTag:i + 10];
        [button addTarget:self action:@selector(chooseNutritionName:) forControlEvents:UIControlEventTouchUpInside];
        [chooseView1 addSubview:button];
        if (i == 0) {
            button.selected = YES;
        }
    }
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, chooseView1Y + chooseView1H, ScreenWidth, 1)];
    line1.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [backView addSubview:line1];
    
    // 选项文字提醒2
    CGFloat chooseLabel2X = 10;
    CGFloat chooseLabel2H = 15;
    CGFloat chooseLabel2Y = chooseView1Y + chooseView1H + (44 - chooseLabel2H) * 0.5;
    CGFloat chooseLabel2W = ScreenWidth - chooseLabel1X * 2;
    UILabel *chooseLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(chooseLabel2X, chooseLabel2Y + 31 + 10, chooseLabel2W, chooseLabel2H)];
    chooseLabel2.font = UIFONT_H4_15;
    chooseLabel2.textColor = COLOR_C1;
    chooseLabel2.text = @"选择食物类别（单选）：";
    chooseLabel2.textAlignment = NSTextAlignmentLeft;
    [backView addSubview:chooseLabel2];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, chooseView1Y + chooseView1H + 43, ScreenWidth, 1)];
    line2.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [backView addSubview:line2];

    // 选项名字2
    self.foodNames = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in foodData) {
        FoodModel *model = [[FoodModel alloc] init];
        model.foodName = dict[@"name"];
        model.foodId = dict[@"id"];
        [self.foodNames addObject:model];
    }
    
    // 选项背景2
    CGFloat chooseView2X = 0;
    CGFloat chooseView2H = 10 + (10 + 31) * (self.foodNames.count / 3 + 1);
    CGFloat chooseView2Y = chooseView1Y + chooseView1H + 44;
    CGFloat chooseView2W = ScreenWidth;
    UIView *chooseView2 = [[UIView alloc] initWithFrame:CGRectMake(chooseView2X, chooseView2Y + 31 + 10, chooseView2W, chooseView2H)];
    chooseView2.backgroundColor = COLOR_C4;
    [backView addSubview:chooseView2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, chooseView2Y + chooseView2H, ScreenWidth, 1)];
    line3.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [backView addSubview:line3];
    
    for (int i = 0; i < self.foodNames.count; i ++)
    {
        FoodModel *model = self.foodNames[i];
        NSInteger row = i / 3; // 取商返回的行数
        NSInteger col = i % 3; // 取余返回的列数
        
        CGFloat buttonX = 10 + ((ScreenWidth - 40) / 3 + 10) * col;
        CGFloat buttonH = 31;
        CGFloat buttonY = 10 + (10 + 31) * row;
        CGFloat buttonW = (ScreenWidth - 40) / 3;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.titleLabel.font = UIFONT_H2_13;
        [button setTitle:model.foodName forState:UIControlStateNormal];
        [button setTitleColor:COLOR_C2 forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"chooseBtn_selected"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage imageNamed:@"chooseBtn_cancel"] forState:UIControlStateNormal];
        [button setTag:i + 1000];
        [button addTarget:self action:@selector(chooseFoodName:) forControlEvents:UIControlEventTouchUpInside];
        [chooseView2 addSubview:button];
        if (i == 0) {
            button.selected = YES;
        }
    }
}

// 选项框 1 点击事件
- (void)chooseNutritionName:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.selected == NO)
    {
        for (int i = 0; i < self.nutritionNames.count; i++) {
            UIButton * otherButton = (UIButton *)[self viewWithTag:i + 10];
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
    
    NutritionModel *nutritionModel = self.nutritionNames[button.tag - 10];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nutritionModel" object:nutritionModel];
}

// 选项框 2 点击事件
- (void)chooseFoodName:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.selected == NO)
    {
        for (int i = 0; i < self.foodNames.count; i++) {
            UIButton * otherButton = (UIButton *)[self viewWithTag:i + 1000];
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
    FoodModel *foodModel = self.foodNames[button.tag - 1000];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"foodModel" object:foodModel];
}


- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
@end

