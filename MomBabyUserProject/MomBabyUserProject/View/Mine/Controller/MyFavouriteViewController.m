//
//  MyFavouriteViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/20.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "MyFavouriteViewController.h"
#import "HomeWebViewController.h"
#import "RecoverTableViewCell.h"

@interface MyFavouriteViewController () <UITableViewDataSource,UITableViewDelegate>
{
    int _page;
}
@property (nonatomic, strong) UITableView * superTableView;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UIButton * rightBtn;
@property (nonatomic, strong) NSMutableDictionary *removeDic;
@property (nonatomic, strong) UIView * dowView;
@end

@implementation MyFavouriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArr = [NSMutableArray array];
        self.removeDic = [NSMutableDictionary dictionary];
        _page = 1;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"我的收藏"];
    
    if (!self.rightBtn) {
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.frame = CGRectMake(ScreenWidth - 10 - 40, 20 + (44 - 15) * 0.5, 40, 15);
        self.rightBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.titleLabel.font = UIFONT_H4_15;
        [self.rightBtn addTarget:self action:@selector(othersButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.rightBtn];
    }

    if (self.superTableView) {
        [self.superTableView.mj_header beginRefreshing];
    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"我的收藏"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self downView];
    [self customNavgationBar];
    self.navTitle.text = @"我的收藏";
}

- (void)downView {
    self.dowView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 59)];
    self.dowView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.dowView];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorFromHexRGB:@"e2e2e2"];
    [self.dowView addSubview:lineView];
    
    UIButton * deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.frame = CGRectMake(10, 10.5, ScreenWidth - 20, 38);
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    deleteBtn.titleLabel.font = UIFONT_H6_16;
    deleteBtn.layer.cornerRadius = 5;
    deleteBtn.backgroundColor = kColorTheme;
    [deleteBtn addTarget:self action:@selector(delegateBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.dowView addSubview:deleteBtn];
}

- (void)delegateBtnAction{
    if ([self.removeDic count] != 0) {
        [self deleteConnect];
    }
    else{
        [self.view showToastMessage:@"操作不对呀"];
    }
}

/**
 *  删除收藏
 */
- (void)deleteConnect {
    NSString * ids = @"";
    for (int i = 0; i < [[self.removeDic allKeys] count]; i++) {
        NSString * xiaoStr = [[self.removeDic allKeys] objectAtIndex:i];
        ids = [NSString stringWithFormat:@"%@,%@",ids,xiaoStr];
    }
    
    NSString * idStr = [ids substringFromIndex:1];
    
    [[Network_Mine new] deleteMyCollectionArticlesWith:idStr responseBlock:^(LLError *err) {
        if (!err) {
            [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
            [UIView animateWithDuration:0.5 animations:^{
                self.dowView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 59);
            }];
            [self.superTableView setEditing:NO animated:YES];
            [self.dataArr removeAllObjects];
            _page = 1;
            [self conntect];
        }
    }];
}


- (void)othersButtonAction{
    if (self.dataArr.count != 0) {
        if ([self.rightBtn.titleLabel.text isEqualToString:@"编辑"]) {
            [self.rightBtn setTitle:@"取消" forState:UIControlStateNormal];
            [UIView animateWithDuration:0.5 animations:^{
                self.dowView.frame = CGRectMake(0, ScreenHeight - 59, ScreenWidth, 59);
            }];
            [self.superTableView setEditing:YES animated:YES];
        }
        else{
            [self.rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
            [UIView animateWithDuration:0.5 animations:^{
                self.dowView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 59);
            }];
            [self.superTableView setEditing:NO animated:YES];
        }
    }
}

- (void)conntect {
    
    Input_params *params = [[Input_params alloc] init];
    params.page = @(_page);
    params.limit = @20;
    [[Network_Mine new] getMyCollectionArticlesWith:params responseBlock:^(LLError *err, id responseData) {
        if (!err) {
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:[responseData objectForKey:@"list"]];
            
            if ([[responseData objectForKey:@"list"] count] < 20) {
                self.superTableView.mj_footer.hidden = YES;
            }
            else if ([[responseData objectForKey:@"list"] count] == 20){
                self.superTableView.mj_footer.hidden = NO;
            }
            NSLog(@"%@",responseData);
            [self.superTableView reloadData];
        } else {
            [self.view showToastMessage:err.errormsg];
        }
        [self.superTableView.mj_footer endRefreshing];
        [self.superTableView.mj_header endRefreshing];
    }];
}

- (void)createTableView {
    self.superTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight - 44) style:UITableViewStylePlain];
    self.superTableView.delegate = self;
    self.superTableView.dataSource = self;
    self.superTableView.rowHeight = 80;
    self.superTableView.showsVerticalScrollIndicator = NO;
    self.superTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.superTableView];
    
    self.superTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(addHeader)];
    self.superTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(addFooter)];
    [self.superTableView.mj_header beginRefreshing];
}

- (void)addHeader {
    _page = 1;
    [self.dataArr removeAllObjects];
    [self conntect];
}

- (void)addFooter {
    _page++;
    [self conntect];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell";
    RecoverTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[RecoverTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    if (self.dataArr.count != 0) {
        NSDictionary * dic = [self.dataArr objectAtIndex:indexPath.row];
        NSURL * imgUrl = [NSURL URLWithString:[[dic objectForKey:@"image"] objectForKey:@"real"]];
        [cell.showImageView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"default_content_tt"]];
        cell.headlineLabel.text = [dic objectForKey:@"title"];
        cell.abstractLabel.text = [dic objectForKey:@"introduction"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    cell.tintColor = kColorTheme;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.rightBtn.titleLabel.text isEqualToString:@"取消"]) {
        [self.removeDic setObject:indexPath forKey:[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"id"]];
        //添加
    }
    else{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        HomeWebViewController * homeWeb = [[HomeWebViewController alloc] init];
        homeWeb.title = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
        homeWeb.articleTitle = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
        homeWeb.articleId = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"id"];
        [self.navigationController pushViewController:homeWeb animated:YES];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.rightBtn.titleLabel.text isEqualToString:@"取消"]) {
        //删除
        [self.removeDic removeObjectForKey:[[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"id"]];
    }
//    [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithArray:[deleteDic allValues]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
