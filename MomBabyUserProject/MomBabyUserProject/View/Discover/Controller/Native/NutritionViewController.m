//
//  NutritionViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/13.
//  Copyright © 2015年 龙源美生. All rights reserved.
//  营养查询

#import "NutritionViewController.h"
#import "NutritionTableViewCell.h"
#import "NutritionResultViewController.h"

@interface NutritionViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
}

@property(nonatomic, strong) NSMutableArray *nutritionData;
@property(nonatomic, strong) NSMutableArray *foodData;


// 存值
@property (nonatomic, copy) NSString * nutrtionId;
@property (nonatomic, copy) NSString * nutrtionNmae;

@property (nonatomic, copy) NSString * foodId;
@property (nonatomic, copy) NSString * foodName;
@end

@implementation NutritionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"营养查询"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"营养查询"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"营养查询";
    // 1、初始化数据源
    self.nutritionData = [NSMutableArray array];
    self.foodData = [NSMutableArray array];
    self.nutrtionId = @"1001";
    self.nutrtionNmae = @"能量";
    self.foodId = @"1";
    self.foodName = @"谷物";
    self.view.backgroundColor = [UIColor whiteColor];

    // 2、请求数据
    [self requestInfo];
    // 3、创建UI
    [self createUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFirstName:) name:@"nutritionModel" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getSecondName:) name:@"foodModel" object:nil];
}

- (void)requestInfo
{
    // 营养数据请求
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(1);
    parameters[@"limit"] = @(50);
    
    [[Network_Discover new] getFoodListWithParams:parameters ResponseBlock:^(LLError *error, id response) {
        if (!error) {
            self.foodData = [response[@"list"] copy];
            [_tableView reloadData];
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
    
    [[Network_Discover new] getNutritionDataWithParams:parameters ResponseBlock:^(LLError *error, id response) {
        if (!error) {
            self.nutritionData = [response[@"list"] copy];
            [_tableView reloadData];
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

// 创建UI
- (void)createUI
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = COLOR_LINE;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 59 - 64, ScreenWidth, 59)];
    testView.backgroundColor = COLOR_C4;
    [self.view addSubview:testView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    line.backgroundColor =  COLOR_LINE;
    [testView addSubview:line];
    
    UIButton *testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat testButtonX = 10;
    CGFloat testButtonY = 10;
    CGFloat testButtonW = ScreenWidth - 20;
    CGFloat testButtonH = 39;
    testButton.frame = CGRectMake(testButtonX, testButtonY, testButtonW, testButtonH);
    [testButton setTitle:@"查询" forState:UIControlStateNormal];
    [testButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    testButton.layer.masksToBounds = YES;
    testButton.layer.cornerRadius = 3;
    testButton.backgroundColor = kColorTheme;
    [testButton addTarget:self action:@selector(nutritionButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [testView addSubview:testButton];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NutritionTableViewCell *cell = [NutritionTableViewCell cellWithTable:tableView indexPtah:indexPath nutritionData:self.nutritionData foodData:self.foodData];
        
    return cell;
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (iPhone4) {
        return ScreenHeight * 1.6;
    }
    else if (iPhone5)
    {
        return ScreenHeight * 1.35;
    }
    else if (iPhone6)
    {
        return ScreenHeight * 1.2;
    }
    return ScreenHeight * 1.1;
}

// 查询按钮点击事件
- (void)nutritionButtonAction
{
    NutritionResultViewController *nutritionRe = [[NutritionResultViewController alloc] init];
    nutritionRe.nutrtionId = self.nutrtionId;
    nutritionRe.nutrtionNmae = self.nutrtionNmae;
    nutritionRe.foodId = self.foodId;
    nutritionRe.foodName =self.foodName;
    nutritionRe.title = @"查询结果";
    
    [self.navigationController pushViewController:nutritionRe animated:YES];
    
}

- (void)getFirstName:(NSNotification *)not
{
    
    NutritionModel *nutriModel = not.object;
    self.nutrtionId = nutriModel.nutritionId;
    self.nutrtionNmae = nutriModel.nutritionName;
}
- (void)getSecondName:(NSNotification *)not
{
    FoodModel *foodModel = not.object;
    self.foodId = foodModel.foodId;
    self.foodName = foodModel.foodName;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
