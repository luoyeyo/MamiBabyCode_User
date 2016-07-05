//
//  FLViewController.m
//  15-QQ聊天布局
//
//  Created by Liu Feng on 13-12-3.
//  Copyright (c) 2013年 Liu Feng. All rights reserved.
//

#import "SystemMessageViewController.h"
#import "SystemMessageFrame.h"
#import "SystemMessage.h"
#import "SystemMessageCell.h"
#import "Input_params.h"
#import "DataManager.h"

@interface SystemMessageViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
    NSMutableArray  *_allMessagesFrame;
    Input_params *_params;
    NSMutableArray *_messages;
    // 当前最后一个数据的id
    NSInteger _currentIndex;
    NSInteger _totalCount;
}
@end

@implementation SystemMessageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"系统消息";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundColor = [UIColor colorFromHexRGB:@"e4dfdf"];
    self.tableView.contentOffset = CGPointMake(0, CGFLOAT_MAX);
    _messages = [[NSMutableArray alloc] init];
    _params = [[Input_params alloc] init];
//    _params.page = 1;
//    _params.limit = 100;
//    [self.view showPopupLoading];
    [self requestDefaultData];
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
    self.tableView.mj_footer = footer;
}

- (void)setMessage {
    NSString *previousTime = nil;
    _allMessagesFrame = [NSMutableArray array];
    for (SystemMessage *message in _messages) {
        SystemMessageFrame *messageFrame = [[SystemMessageFrame alloc] init];
        messageFrame.showTime = ![previousTime isEqualToString:message.time];
        messageFrame.ipsilateral = message.type - 1;
        messageFrame.message = message;
        previousTime = message.time;
        [_allMessagesFrame addObject:messageFrame];
    }
    [self.tableView reloadData];
    [self.tableView.mj_footer endRefreshing];
}

- (void)requestDefaultData {
    Input_params *params = [[Input_params alloc] init];
    params.time = [NSString stringWithFormat:@"%@",@([DataManager getLastNotiTime])];
    [self.view showPopupLoading];
//    [kShareManager_Vaccinate getNotiMessageWith:params responseBlock:^(LLError *error) {
//        [self.view hidePopupLoading];
//        
//        // 本地取啊
////        [_messages addObjectsFromArray:list];
//        [self requestMoreData];
//        [kUserInfo setUserUnreadCount:0];
//    }];
//    _params.time = @([APNSDataManager getLastNotiTime]);
////    _params.time = @(1456279500);
//    [[Home_Manager sharedManager] requestMessageListInfoWithParams:_params responseBlock:^(LLError *error) {
//        [self.view hidePopupLoading];
//        [self.tableView.footer endRefreshing];
//        // 更新刷新时间
//        [self requestMoreData];
//        // 如果是在消息页面获取的  系统消息 直接标记为已读
//        if (!error && [Home_Manager sharedManager].messageList.count > 0) {
//            // 系统消息count
//            NSInteger sysCount = [APNSDataManager getUnreadSystemCountWithCount];
//            NSInteger totalCount = kUserInfo.unreadCount;
//            // 保存count
//            [APNSDataManager updateUnreadSystemMessageCountWithCount:0];
//            [kUserInfo setUserUnreadCount:totalCount - sysCount];
//        }
//    }];
}

- (void)requestMoreData {
    NSArray *allData;
    NSMutableArray *messageArr = [NSMutableArray array];
    // 如果当前没有数据 就从新的开始获取
    if (_messages.count == 0) {
        allData = [DataManager descSelect];
        [self getCurrentIndexWith:allData];
        // 总数为  当前最后一条的id + 条数 (要减去最后一个的 所以是10-1)
        _totalCount = _currentIndex + allData.count - 1;
        for (NSDictionary *dic in allData) {
            [messageArr addObject:[dic objectForKey:SQLTableKeyMessage]];
        }
    } else {
        // 有数据就从 当前最后一个的id开始
        allData = [DataManager getMessageWithLastId:_currentIndex];
        _currentIndex -= allData.count;
        if (allData.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.view showToastMessage:@"已经没有更多通知了"];
            return;
        }
        // 根据数据库结构  需要倒序
        for (NSDictionary *dic in [[allData reverseObjectEnumerator] allObjects]) {
            [messageArr addObject:[dic objectForKey:SQLTableKeyMessage]];
        }
    }
    
    for (NSData *data in messageArr) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [_messages addObject:[[SystemMessage alloc] initWithDictionary:dictionary error:nil]];
    }
    [self setMessage];
}

- (void)getCurrentIndexWith:(NSArray *)array {
    NSDictionary *lastObj = [array lastObject];
    _currentIndex = [[lastObj objectForKey:SQLTablePrimaryKey] integerValue];
}

#pragma mark - tableView数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SystemMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.row = indexPath.row;
    // 设置数据
    cell.messageFrame = _allMessagesFrame[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [_allMessagesFrame[indexPath.row] cellHeight] + 5;
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
