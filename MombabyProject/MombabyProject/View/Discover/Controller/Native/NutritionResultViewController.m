//
//  NutritionResultViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/24.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "NutritionResultViewController.h"
#import "NutritionResultTableViewCell.h"
#import "NutritionTableViewCell.h"
#import "ResuletFoodListModel.h"
#import "NutritionModel.h"
#import "FoodModel.h"

@interface NutritionResultViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UIButton *_shareButton;
}

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *textArr;
@property(nonatomic, strong)NSArray *foodListModelArr;
@end

@implementation NutritionResultViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"查询结果"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"查询结果"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询结果";
    self.view.backgroundColor = [UIColor whiteColor];
    _textArr= [[NSMutableArray alloc] init];
    [self.textArr addObject:self.nutrtionNmae];
    [self.textArr addObject:self.foodName];
    // 请求数据
    [self requestInfo];
    
    [self createUI];
    
}
#pragma mark - 请求数据
- (void)requestInfo
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(1);
    parameters[@"limit"] = @(50);
    parameters[@"foodNutritionId"] = self.nutrtionId;
    parameters[@"foodCategoryId"] = self.foodId;
    [self.view showPopupLoading];
    [[Network_Discover new] getFoodsInfoWithParams:parameters ResponseBlock:^(LLError *error, id response) {
        [self.view hidePopupLoading];
        if (!error) {
            NSArray *foodDictArr = response[@"list"];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in foodDictArr) {
                ResuletFoodListModel *model = [[ResuletFoodListModel alloc] initWithDictionary:dic error:nil];
                [arr addObject:model];
            }
            self.foodListModelArr = [NSArray arrayWithArray:arr];
            [self.table reloadData];
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

- (void)createUI {
    // 选项按钮展示
    for (int i = 0; i < self.textArr.count; i ++) {
        UIButton *nutritionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat nutritionBtnW = (ScreenWidth - 40) / 3;
        CGFloat nutritionBtnX = 10 + 80 + (10 + nutritionBtnW) * i;
        CGFloat nutritionBtnH = 31;
        CGFloat nutritionBtnY = (44 - nutritionBtnH) * 0.5;
        nutritionBtn.frame = CGRectMake(nutritionBtnX, nutritionBtnY, nutritionBtnW, nutritionBtnH);
        nutritionBtn.userInteractionEnabled = NO;
        nutritionBtn.titleLabel.font = UIFONT_H2_13;
        [nutritionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nutritionBtn setTitle:self.textArr[i] forState:UIControlStateNormal];
        [nutritionBtn setBackgroundImage:[UIImage imageNamed:@"chooseBtn_selected"] forState:UIControlStateNormal];
        [self.view addSubview:nutritionBtn];
    }
    if (self.textArr.count != 0) {
        [self.textArr removeAllObjects];
    }
    // 选项文字提醒1
    CGFloat conditionLabelX = 10;
    CGFloat conditionLabelH = 15;
    CGFloat conditionLabelY = (44 - conditionLabelH) * 0.5;
    CGFloat conditionLabelW = 80;
    UILabel *conditionLabel = [[UILabel alloc] initWithFrame:CGRectMake(conditionLabelX, conditionLabelY, conditionLabelW, conditionLabelH)];
    conditionLabel.font = UIFONT_H4_15;
    conditionLabel.textColor = COLOR_C1;
    conditionLabel.text = @"查询条件：";
    conditionLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:conditionLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 43, ScreenWidth, 1)];
    line.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [self.view addSubview:line];
    
    // 选项按钮展示
    for (int i = 0; i < _textArr.count; i ++) {
        UIButton *nutritionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat nutritionBtnW = (ScreenWidth - 40) / 3;
        CGFloat nutritionBtnX = conditionLabelX + conditionLabelW + (10 + nutritionBtnW) * i;
        CGFloat nutritionBtnH = 31;
        CGFloat nutritionBtnY = (44 - nutritionBtnH) * 0.5;
        nutritionBtn.frame = CGRectMake(nutritionBtnX, nutritionBtnY, nutritionBtnW, nutritionBtnH);
        nutritionBtn.userInteractionEnabled = NO;
        nutritionBtn.titleLabel.font = UIFONT_H2_13;
        [nutritionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [nutritionBtn setTitle:_textArr[i] forState:UIControlStateNormal];
        [nutritionBtn setBackgroundImage:[UIImage imageNamed:@"chooseBtn_selected"] forState:UIControlStateNormal];
        [self.view addSubview:nutritionBtn];
    }
    
    CGFloat viewW = ScreenWidth;
    CGFloat viewX = 0;
    CGFloat viewH = 10;
    CGFloat viewY = 44;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
    view.backgroundColor = COLOR_C4;
    [self.view addSubview:view];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 43 + 10, ScreenWidth, 1)];
    line1.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [self.view addSubview:line1];
    
    
    // 选项文字提醒2
    CGFloat resultLabelX = 10;
    CGFloat resultLabelH = 15;
    CGFloat resultLabelY = viewY + viewH + (44 - resultLabelH) * 0.5;
    CGFloat resultLabelW = 80;
    UILabel *resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(resultLabelX, resultLabelY, resultLabelW, resultLabelH)];
    resultLabel.font = UIFONT_H4_15;
    resultLabel.textColor = COLOR_C1;
    resultLabel.text = @"查询结果：";
    resultLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:resultLabel];
    
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, viewY + viewH + 43, ScreenWidth, 1)];
    line2.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [self.view addSubview:line2];
    
    CGFloat view2W = ScreenWidth;
    CGFloat view2X = 0;
    CGFloat view2H = 44;
    CGFloat view2Y = viewY + viewH + 44;
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(view2X, view2Y, view2W, view2H)];
    view2.backgroundColor = COLOR_C4;
    [self.view addSubview:view2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, view2Y + view2H - 1, ScreenWidth, 1)];
    line3.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [self.view addSubview:line3];
    
    // 标题文字
    NSArray *resuleArr1 = @[@"食物名称", [NSString stringWithFormat:@"%@含量",self.nutrtionNmae], @"单位"];
    
    for (int i = 0; i < resuleArr1.count; i ++) {
        
        CGFloat topLabelW = ScreenWidth / 3;
        CGFloat topLabelX = topLabelW * i;
        CGFloat topLabelH = 14;
        CGFloat topLabelY;
        topLabelY = (44 - topLabelH) * 0.5;
        UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(topLabelX, topLabelY, topLabelW, topLabelH)];
        topLabel.font = UIFONT_H3_14;
        topLabel.textColor = COLOR_C1;
        topLabel.text = resuleArr1[i];
        topLabel.textAlignment = NSTextAlignmentCenter;
        [view2 addSubview:topLabel];
        
//        if (i > 0) {
//            
//            CGFloat bottomLabelW = ScreenWidth / 3;
//            CGFloat bottomLabelX = topLabelW * i;
//            CGFloat bottomLabelH = 14;
//            CGFloat bottomLabelY = 22;
//            UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(bottomLabelX, bottomLabelY, bottomLabelW, bottomLabelH)];
//            bottomLabel.font = UIFONT_H3_14;
//            bottomLabel.textColor = COLOR_C1;
//            bottomLabel.text = resuleArr2[i - 1];
//            bottomLabel.textAlignment = NSTextAlignmentCenter;
//            [view2 addSubview:bottomLabel];
//        }
        
    }
    
    CGFloat view3W = ScreenWidth;
    CGFloat view3X = 0;
    CGFloat view3H = 20 + 39;
    CGFloat view3Y = ScreenHeight - view3H;
    UIView *view3 = [[UIView alloc] initWithFrame:CGRectMake(view3X, view3Y, view3W, view3H)];
    view3.backgroundColor = COLOR_C4;
    [self.view addSubview:view3];
    
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
    line4.backgroundColor =  [UIColor colorFromHexRGB:@"e2e2e2"];
    [view3 addSubview:line4];
    
    _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat testButtonX = 10;
    CGFloat testButtonH = 39;
    CGFloat testButtonY = 10;
    CGFloat testButtonW = ScreenWidth - 20;
    _shareButton.frame = CGRectMake(testButtonX, testButtonY, testButtonW, testButtonH);
    _shareButton.layer.masksToBounds = YES;
    _shareButton.layer.cornerRadius = 3;
    [_shareButton setTitle:@"分享查询结果" forState:UIControlStateNormal];
    [_shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shareButton setBackgroundColor:kColorTheme];
    [_shareButton addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [view3  addSubview:_shareButton];
    
    CGFloat tableViewX = 0;
    CGFloat tableViewY = view2Y + view2H;
    CGFloat tableViewW = ScreenWidth;
    CGFloat tableViewH = ScreenHeight - tableViewY - view3H;

    self.table = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorColor = COLOR_LINE;
    UIView *lineView = [[UIView alloc] init];
    self.table.tableFooterView = lineView;
    [self.view addSubview:self.table];
    
}

// 分享按钮点击事件
- (void)share
{
//    XMLog(@"分享");//1072814144
//    [[ShareManager shareManager] shareWithTitle:@"营养查询结果" shareWithText:@"我的营养查询结果" shareViewController:self shareUrl:kSHAREURL];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.foodListModelArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NutritionResultTableViewCell *cell = [NutritionResultTableViewCell cellWithTableView:tableView dataSource:self.foodListModelArr indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
