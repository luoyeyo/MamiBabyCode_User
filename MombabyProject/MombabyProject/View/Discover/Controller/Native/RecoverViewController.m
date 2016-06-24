//
//  RecoverViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/11/13.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "RecoverViewController.h"
#import "RecoverTableViewCell.h"
#import "NSDate+myDate.h"
#import "HomeWebViewController.h"

@interface RecoverViewController ()<UITableViewDelegate,UITableViewDataSource>{
    int _page;
}
@property (nonatomic, strong) UITableView * superTableView;
@property (nonatomic, strong) NSMutableArray * dataArr;

@end

@implementation RecoverViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArr = [NSMutableArray array];
        _page = 1;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"产后恢复"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"产后恢复"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产后恢复";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
}

- (void)conntect {
    
    int birth = 0;
    if (kUserInfo.isLogined) {
        NSString * currentTimeStr = [NSString stringWithFormat:@"%@",kUserInfo.currentTime];
        NSString * birthStr = [NSString stringWithFormat:@"%@",kUserInfo.currentBaby.birth];
        birth = [currentTimeStr getVipNumberDay:birthStr] - 1;
    } else {
        NSString * birthStr = [kUserInfo.currentBaby.birth getTimestamp];
        NSTimeInterval time = [birthStr doubleValue] + 28800;
        NSDate * birthDay =[NSDate dateWithTimeIntervalSince1970:time];
        birth = [birthDay getChuShengNumberDay];
    }
    if (birth > 16 * 7) {
        birth = 16 * 7;
    }
    NSString * pa = [NSString stringWithFormat:@"%d",_page];
    NSString * days = [NSString stringWithFormat:@"%d",1000000 + birth];
    
    Input_params *params = [Input_params new];
    params.page = @([pa integerValue]);
    params.limit = @20;
    params.categoryId = self.parentId;
    params.type = @"2";
    params.days = days;
    
    [[Network_Discover new] getArticlesListWithParams:params ResponseBlock:^(LLError *error, NSArray *list) {
        if (!error) {
            [self.dataArr addObjectsFromArray:list];
            
            [self.superTableView.mj_footer endRefreshing];
            [self.superTableView.mj_header endRefreshing];
            if ([list count] < 20) {
                //                                  [self.myTableView.footer noticeNoMoreData];
                self.superTableView.mj_footer.hidden = YES;
            } else if ([list count] == 20){
                self.superTableView.mj_footer.hidden = NO;
            }
            [self.superTableView reloadData];
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

- (void)createTableView {
    self.superTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    self.superTableView.delegate = self;
    self.superTableView.dataSource = self;
    self.superTableView.rowHeight = 80;
    self.superTableView.showsVerticalScrollIndicator = NO;
    self.superTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.superTableView];
    
    self.superTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(addHeader)];
    self.superTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(addFooter)];
    [self.superTableView.mj_header beginRefreshing];
    [self addHeader];
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeWebViewController * homeWeb = [[HomeWebViewController alloc] init];
    homeWeb.title = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    homeWeb.articleTitle = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"title"];
    homeWeb.articleId = [[self.dataArr objectAtIndex:indexPath.row] objectForKey:@"id"];
    [self.navigationController pushViewController:homeWeb animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
