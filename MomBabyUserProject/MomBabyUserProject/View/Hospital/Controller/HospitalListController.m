//
//  HospitalListController.m
//  MommyBaby_user
//
//  Created by 罗野 on 16/4/15.
//  Copyright © 2016年 龙源美生. All rights reserved.
//

#import "HospitalListController.h"
#import "HospitalInfoCell.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "HospitalViewController.h"
#import "LogInViewController.h"

@interface HospitalListController ()<UITableViewDelegate,UITableViewDataSource,BMKLocationServiceDelegate,UISearchBarDelegate> {
    Input_params *_params;
    NSMutableArray *_dataArr;
    BMKLocationService * _locService;
    BOOL _requestDefault;
    BOOL _locationServices;
}
@property (nonatomic, strong) UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation HospitalListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationServices = NO;
    self.navTitle.text = @"医院列表";
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView = self.searchBar;
    self.tableView.frame = self.view.bounds;
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDefaultList)];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    _requestDefault = NO;
    [self initDataSource];
    self.tableView.contentOffset = CGPointMake(0, 44);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)initDataSource {
    _params = [[Input_params alloc] init];
    _params.page = @1;
    _params.limit = @15;
    _dataArr = [NSMutableArray array];
    [self checkLocationInfo];
}

- (void)checkLocationInfo {
    
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)) {
            //定位功能可用，开始定位
            [self getLocation];
        } else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请打开定位功能以精确获取您附近的医院信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            [self getDefaultHosiptalList];
        } else {
            //定位功能可用，开始定位
            [self getLocation];
        }
}

- (void)requestDefaultList {
    _params.page = @1;
    _requestDefault = YES;
    [_tableView.mj_footer setState:MJRefreshStateIdle];
    [self checkLocationInfo];
}

- (void)requestData {
    [self.view showPopupLoading];
    
    [[[Network_ParentingClass alloc] init] getHospitalListInfoWithParams:_params ResponseBlock:^(LLError *error, NSArray *info) {
        [self.view hidePopupLoading];
        [_tableView.mj_footer endRefreshing];
        [_tableView.mj_header endRefreshing];
        if (!error) {
            if (info.count < 15) {
                [_tableView.mj_footer setState:MJRefreshStateNoMoreData];
            }
            // 防止清空数据的时候还在使用tab
            if (_requestDefault) {
                [_dataArr removeAllObjects];
                _requestDefault = NO;
            }
            NSInteger page = [_params.page integerValue];
            NSInteger nextPage = page + 1;
            _params.page = @(nextPage);
            [_dataArr addObjectsFromArray:info];
            [_tableView reloadData];
        } else {
            [self.view showToastMessage:error.errormsg];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HospitalInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HospitalInfoCell"];
    cell.model = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 如果未登录
    if (!kUserInfo.isLogined) {
        [kAppDelegate toPresentLogin];
        return;
    }
    
    HospitalEntryModel *model = _dataArr[indexPath.row];
    if (model.isBookbuilding == NO) {
        UIStoryboard *hospitalStoryb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HospitalViewController * vc = [hospitalStoryb instantiateViewControllerWithIdentifier:@"HospitalViewController"];
        vc.hospitalInfo = model;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else { // 已建档就更新首页医院
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeHospital" object:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

#pragma mark - baiduMap

//百度定位
- (void)getLocation {
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    [_locService startUserLocationService];
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [_locService stopUserLocationService];
    
    NSString * longitude = [NSString stringWithFormat:@"%.2f",userLocation.location.coordinate.longitude];
    NSString * latitude = [NSString stringWithFormat:@"%.2f",userLocation.location.coordinate.latitude];
    NSMutableDictionary * userLocationDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:longitude,@"longitude",latitude,@"latitude", nil];
    [XMAccountTool saveLocation:userLocationDic];
    NSDictionary *location = [XMAccountTool userLocation];
    
    NSString *lat = location[@"latitude"];
    NSString *lng = location[@"longitude"];
    _params.lat = @([lat floatValue]);
    _params.lng = @([lng floatValue]);
    [self requestData];
}

- (void)didFailToLocateUserWithError:(NSError *)error {
    [self getDefaultHosiptalList];
}

#pragma mark - search

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _params.title = searchText;
    [self.view showPopupLoading];
    [self requestData];
}

/**
 *  获取默认医院列表
 */
- (void)getDefaultHosiptalList {
    _params.lat = @0;
    _params.lng = @0;
    [self requestData];
}

- (UISearchBar *)searchBar {
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 70)];
        _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
        // 设置大小
        _searchBar.placeholder = @"输入医院名称搜索";
        [_searchBar sizeToFit];
        _searchBar.backgroundImage = [UIImage imageWithColor:kColorLineGray];
        _searchBar.barTintColor = [UIColor lightGrayColor];
        // 设置协议
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
