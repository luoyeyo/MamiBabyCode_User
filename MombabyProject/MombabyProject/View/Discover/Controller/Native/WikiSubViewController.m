//
//  WikiSubViewController.m
//  MommyBaby_user
//
//  Created by 龙源美生 on 15/12/29.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "WikiSubViewController.h"
#import "WikiTabeViewCell.h"
#import "WikiModel.h"
#import "NSDate+myDate.h"


#define LibraryChchePath [NSHomeDirectory() stringByAppendingString:@"/Library/localCache"]
@interface WikiSubViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    int _page;
}

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *cacheKey;

@end

@implementation WikiSubViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.dataSource = [NSMutableArray array];
    _page = 1;
    [self getDays];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(relaodDays:) name:@"days" object:nil];
    [self getTypeAndDays];
    [self getCache];
    [self createTabel];
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
            NSString *days = [NSString stringWithFormat:@"%d",[currentTimeStr getVipNumberDay:lastMensesStr]];
            if ([days intValue] >= 293) {
                days = @"293";
            }
            // 计算孕周
            self.days = [NSString stringWithFormat:@"%d", days.intValue / 7];
        }
        else // 育儿天数
        {
            NSString * birthStr = [NSString stringWithFormat:@"%@",kUserInfo.currentBaby.birth];
            NSString *days = [NSString stringWithFormat:@"%d",[currentTimeStr getVipNumberDay:birthStr]];
            
            // 计算育儿月数
            self.days = [NSString stringWithFormat:@"%d", days.intValue / 30];
        }
        
        
    }
    // 游客
    else
    {
        if (![NSString isEmptyString:kUserInfo.dueDateStr]) { // 游客孕期天数
            
            //预产期
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY-MM-dd"];
            NSDate * yuChanQiDate = [dateFormatter dateFromString:kUserInfo.dueDateStr];
            //得到末次月经
            NSDate * moCiDate = [yuChanQiDate getMensesDate];
            //游客  手机时间减去末次月经 得到 怀孕天数
            NSString *days = [NSString stringWithFormat:@"%d",[moCiDate getHuaiYunNumberDay]];
            if ([days intValue] >= 293) {
                days = @"293";
            }
            
            // 计算孕周
            self.days = [NSString stringWithFormat:@"%d", days.intValue / 7];
        }
        else  // 育儿天数
        {
            NSString * birth = [kUserInfo.currentBaby.birth getTimestamp];
            //得到生日日期
            NSTimeInterval time = [birth doubleValue] + 28800;
            NSDate * birthDay =[NSDate dateWithTimeIntervalSince1970:time];
            NSString *days = [NSString stringWithFormat:@"%d",[birthDay getChuShengNumberDay]];
            
            // 计算育儿月数
            self.days = [NSString stringWithFormat:@"%d", days.intValue / 30];
            
        }
    }
    
}
- (void)relaodDays:(NSNotification *)not
{
    self.days = not.object;
    [self getTypeAndDays];
    [self getCache];
    [self requestInfo];
}
// 获取用户类型和天数
- (void)getTypeAndDays
{
    if (kUserInfo.isLogined) {
        self.type = [NSString stringWithFormat:@"%ld", (long)kUserInfo.status];
        if (self.type.integerValue == 1) {
            self.days = [NSString stringWithFormat:@"%d", (int)self.days.integerValue * 7];
        }
        else
        {
            self.days = [NSString stringWithFormat:@"%d", (int)self.days.integerValue * 30];
        }
    }
    else
    {
        if (kUserInfo.status == kUserStateMum) {
            self.type = @"1";
            self.days = [NSString stringWithFormat:@"%d", (int)self.days.integerValue * 7];
        }
        else
        {
            self.type = @"2";
            self.days = [NSString stringWithFormat:@"%d", (int)self.days.integerValue * 30];
        }
    }
}

#pragma mark - 加载缓存数据
- (NSArray *)getCache
{
    // 设置为零 可以避免不同页面加载同样的数据
    if (self.dataSource.count != 0) {
        [self.dataSource removeAllObjects];
    }
    self.cacheKey = [NSString stringWithFormat:@"%@%@", self.days, self.categoryId];
    NSArray *allKeys = [[EGOCache share] allKeys];
    if ([allKeys containsObject:self.cacheKey]) {
        if ([[EGOCache share] hasCacheForKey:self.cacheKey]) {
            id cache = [[EGOCache share] plistForKey:self.cacheKey];
            for (NSDictionary *smallDict in cache) {
                WikiModel *model = [[WikiModel alloc] init];
                model.parentId = smallDict[@"id"];
                model.title = smallDict[@"title"];
                model.introduction = smallDict[@"introduction"];
                model.realIconImage = smallDict[@"image"][@"real"];
                model.mediumIconImage = smallDict[@"image"][@"medium"];
                [self.dataSource addObject:model];
            }
        }
    }
    if (self.dataSource.count < 10) {
        self.table.mj_footer.hidden = YES;
    }
    [self.table reloadData];
    return self.dataSource;
}
// 请求数据
- (void)requestInfo {
    
    Input_params *params = [[Input_params alloc] init];
    params.page = @(_page);
    params.limit = @(10);
    params.categoryId = self.categoryId;
    params.type = self.type;
    params.days = self.days;
    
    [[Network_Discover new] getArticlesListWithParams:params ResponseBlock:^(LLError *error, NSArray *list) {
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            // 如果断网  不会走这一步  不会清空数据
            if (_page == 1 && self.dataSource.count != 0) {
                [self.dataSource removeAllObjects];
            }
            // 存储缓存供断网时使用
            [[EGOCache share] setPlist:list forKey:self.cacheKey];
            if (list.count == 0) {
                [self.view showToastMessage:@"已无更多数据"];
                self.table.mj_footer.hidden = YES;
            }
            for (NSDictionary *smallDict in list) {
                WikiModel *model = [[WikiModel alloc] init];
                model.parentId = smallDict[@"id"];
                model.title = smallDict[@"title"];
                model.introduction = smallDict[@"introduction"];
                model.realIconImage = smallDict[@"image"][@"real"];
                model.mediumIconImage = smallDict[@"image"][@"medium"];
                [self.dataSource addObject:model];
            }
            if (self.dataSource.count < 10) {
                self.table.mj_footer.hidden = YES;
            }
            [self.table reloadData];
        }
    }];
    
    [self endRefreshingAndLoading];
}
#pragma mark - XMRequestInfoTool
- (void)sendInfoWithData:(NSDictionary *)dict path:(NSString *)path
{
    
}
- (void)createTabel
{
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64 - 45 - 45) style:UITableViewStylePlain];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.rowHeight = 65;
    self.table.separatorColor = COLOR_LINE;
    self.table.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.table];
    
    [self startRefreshAndLoading];
}

#pragma mark - 添加刷新和加载方法
- (void)startRefreshAndLoading
{
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadIngAction)];
    [self.table.mj_header beginRefreshing];
//    self.table.footer.automaticallyHidden = NO;
}

- (void)refreshAction
{
    _page = 1;
    [self requestInfo];
}

- (void)loadIngAction
{
    _page++;
    [self requestInfo];
}
- (void)endRefreshingAndLoading
{
    if (self.dataSource.count < 20) {
        self.table.mj_footer.hidden = NO;
    }
    else
    {
        self.table.mj_footer.hidden = YES;
    }
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
}
#pragma mark - UITableViewDelegate  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *iden = @"iden";
    WikiTabeViewCell *cell = [[WikiTabeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:iden];
    [cell cellWithModel:self.dataSource[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WikiModel *model = self.dataSource[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"selectRow" object:model];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
