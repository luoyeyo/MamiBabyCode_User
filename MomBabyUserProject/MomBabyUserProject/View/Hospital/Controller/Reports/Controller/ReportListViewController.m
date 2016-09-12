//
//  ReportListViewController.m
//  DoctorProject
//
//  Created by 罗野 on 16/1/14.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "ReportListViewController.h"
#import "ReportListCell.h"
#import "ReportSecondCell.h"
#import "ReportView.h"
#import "CustomMenuView.h"
#import "ImageReportCell.h"
#import "AssayReportCell.h"

@interface ReportListViewController ()<CustomMenuViewDelegate,UITableViewDelegate,UITableViewDataSource> {
    Input_params *_params;
    NSMutableArray *_list;
    NSMutableArray *_antenatalList;
    NSMutableArray *_imageReportList;
    NSMutableArray *_assayList;
    UIView *_line;
    BOOL _lastReport;
    ReportType _reportType;
}

@property (nonatomic, strong) NoResponseView *noResponeView;
@property (nonatomic, strong) UIButton *titleBtn;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ReportListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = NO;
    [self setNavBarTitleView:self.titleBtn];
    self.view.backgroundColor = kColorBackground;
    self.tableView.backgroundColor = kColorClear;
    _reportType = kReportTypeAntenatal;
    // 加底部间距
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
    self.tableView.tableFooterView = footer;
    [self initDataSource];
    
    if (kUserInfo.status == kUserStateMum) {
        _reportType = kReportTypeAntenatal;
        [self.navigationBarView addSubview:self.titleBtn];
    } else {
        _reportType = kReportTypeChild;
        self.navTitle.text = @"儿保检查";
    }
    
    [self.view showPopupLoading];
    [self requestDefaultData];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDefaultData)];
    [header setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMoreGravidList)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lookReportDetails:) name:kNotiClickReport object:nil];
}

- (void)initDataSource {
    _list = [NSMutableArray array];
    _antenatalList = [NSMutableArray array];
    _imageReportList = [NSMutableArray array];
    _assayList = [NSMutableArray array];
    
    _params = [[Input_params alloc] init];
    _params.page = @1;
    _params.limit = @(kRequestDataCount);
    _params.type = @"1";
    _params.checkType = @(_reportType);
    if (kUserInfo.status == kUserStateMum) {
        _params.patientId = @(kUserInfo.Id);
    } else {
        _params.patientId = kUserInfo.currentBaby.Id;
    }
    
}

- (void)addline {
    if (_line && _line.superview) {
        return;
    }
    _line = [[UIView alloc] initWithFrame:CGRectMake(10.5, - 200, 1.5, ScreenHeight + 200)];
    _line.backgroundColor = kColorTheme;
    [self.view insertSubview:_line atIndex:0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_reportType == kReportTypeAntenatal) {
        return 248;
    } else if (_reportType == kReportTypeAssay) {
        return 228;
    } else {
        return 348;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_reportType == kReportTypeAntenatal) {
        return [self getAntenatalReportCellWithTableView:tableView indexPath:indexPath];
    } else if (_reportType == kReportTypeAssay) {
        return [self getAssayReportCellTableView:tableView indexPath:indexPath];
    } else {
        return [self getImageReportCellTableView:tableView indexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)getAntenatalReportCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    if (_lastReport && indexPath.row == _list.count - 1) {
        ReportListCell *cell = [ReportListCell defaultClassNameNibView];
        cell.report = _list[indexPath.row];
        return cell;
    }
    ReportSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReportSecondCell"];
    if (!cell) {
        cell = [ReportSecondCell defaultClassNameNibView];
    }
    cell.report = _list[indexPath.row];
    return cell;
}

- (UITableViewCell *)getImageReportCellTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    ImageReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageReportCell"];
    if (!cell) {
        cell = [ImageReportCell defaultClassNameNibView];
    }
    cell.imageReportData = _list[indexPath.row];
    return cell;
}

- (UITableViewCell *)getAssayReportCellTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    AssayReportCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckReportCell"];
    if (!cell) {
        cell = [AssayReportCell defaultClassNameNibView];
    }
    cell.assayReportData = _list[indexPath.row];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.contentSize.height + ScreenHeight;
    if (height < ScreenHeight + 200) {
        height = ScreenHeight + ScreenHeight;
    }
    _line.height = height;
}

/**
 *  切换指导类型
 *
 *  @param index
 */
- (void)menuSelected:(NSInteger)index {
    self.titleBtn.selected = NO;
    ReturnIf(index == 10);
    [self.titleBtn setTitle:@[@"产检报告",@"化验报告",@"影像报告"][index] forState:UIControlStateNormal];
    [self.titleBtn setTitle:@[@"产检报告",@"化验报告",@"影像报告"][index] forState:UIControlStateSelected];
    [self.titleBtn setTitle:@[@"产检报告",@"化验报告",@"影像报告"][index] forState:UIControlStateHighlighted];
    // 3是产检报告
    if (index == 0) index = 3;
    _reportType = index;
    if (index == kReportTypeImage && _imageReportList.count > 0) {
        [_list removeAllObjects];
        [_list addObjectsFromArray:_imageReportList];
        [self.tableView reloadData];
        self.noResponeView.type = kNoResponseTypeNormal;
        [self addline];
        return;
    } else if (index == kReportTypeAssay && _assayList.count > 0) {
        [_list removeAllObjects];
        [_list addObjectsFromArray:_assayList];
        [self.tableView reloadData];
        self.noResponeView.type = kNoResponseTypeNormal;
        [self addline];
        return;
    } else if (index == kReportTypeAntenatal && _antenatalList.count > 0) {
        [_list removeAllObjects];
        [_list addObjectsFromArray:_antenatalList];
        [self.tableView reloadData];
        self.noResponeView.type = kNoResponseTypeNormal;
        [self addline];
        return;
    }
    [self.view showPopupLoading];
    [self requestDefaultData];
}

/**
 *  点击事件
 *
 *  @param noti
 */
- (void)lookReportDetails:(NSNotification *)noti {
    ReportsModel *report = noti.object;
    ReportView *review = [ReportView defaultReportView];
    review.reportId = report.Id;
    [review show];
}

#pragma mark - private

/**
 *  指导  顶部的选择器
 */
- (void)showTypeMenu {
    CustomMenuView *menu = [[CustomMenuView alloc] init];
    menu.dataSource = @[@"产检报告",@"检验报告",@"影像报告"];
    menu.Position = kPositionCenter;
    [menu showListView];
    menu.delegate = self;
    _titleBtn.selected = !_titleBtn.selected;
}

- (void)requestDefaultData {
    _params.page = @1;
    _params.checkType = @(_reportType);
    [[Network_Hospital new] requestReportListWithParams:_params responseBlock:^(LLError *error,NSArray *responseData) {
        [self.view hidePopupLoading];
        [self.tableView.mj_header endRefreshing];
        if (!error) {
            if (responseData.count == 0) {
                [self noMoreData];
                self.noResponeView.message = [NSString stringWithFormat:@"%@%@",@"暂时没有",self.titleBtn.currentTitle];
                [_line removeFromSuperview];
            } else {
                self.noResponeView.type = kNoResponseTypeNormal;
            }
            [self addline];
            [_list removeAllObjects];
            [_list addObjectsFromArray:responseData];
            [self.tableView.mj_footer resetNoMoreData];
            [self.tableView reloadData];
            if (_list.count > 0 && _list.count < kRequestDataCount) {
                _lastReport = YES;
            }
            [self saveReportListInMemory];
        } else {
            [self noMoreData];
            self.noResponeView.message = [NSString stringWithFormat:@"%@%@",@"暂时没有",self.titleBtn.currentTitle];
            [self showErrorToastWithError:error message:nil];
            [_line removeFromSuperview];
        }
    }];
}

- (void)requestMoreGravidList {
    
    NSInteger currentPage = [_params.page integerValue];
    currentPage ++;
    _params.page = @(currentPage);
    [[Network_Hospital new] requestReportListWithParams:_params responseBlock:^(LLError *error,NSArray *responseData) {
        [self.view hidePopupLoading];
        [self.tableView.mj_footer endRefreshing];
        if (!error) {
            if (responseData.count == 0) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                _lastReport = YES;
                return ;
            }
            [_list addObjectsFromArray:responseData];
            [self.tableView reloadData];
            [self saveReportListInMemory];
        } else {
            [self showErrorToastWithError:error message:nil];
        }
    }];
}
/**
 *  数据存在内存中
 */
- (void)saveReportListInMemory {
    if (_reportType == kReportTypeImage) {
        [_imageReportList removeAllObjects];
        [_imageReportList addObjectsFromArray:_list];
    } else if (_reportType == kReportTypeAssay) {
        [_assayList removeAllObjects];
        [_assayList addObjectsFromArray:_list];
    } else {
        [_antenatalList removeAllObjects];
        [_antenatalList addObjectsFromArray:_list];
    }
}

- (void)noMoreData {
    [self.tableView addSubview:self.noResponeView];
    self.noResponeView.type = kNoResponseTypeNoData;
}

- (NoResponseView *)noResponeView {
    if (_noResponeView == nil) {
        _noResponeView = [[NoResponseView alloc] initWithFrame:self.view.bounds];
        _noResponeView.type = kNoResponseTypeNoConnection;
    }
    return _noResponeView;
}

- (UIButton *)titleBtn {
    if (_titleBtn == nil) {
        _titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 110, 30)];
        _titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, CGRectGetWidth(_titleBtn.frame) - _titleBtn.imageView.image.size.width - 20, 0, 0);
        _titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 20);
        [_titleBtn setTitle:@"产检报告" forState:UIControlStateNormal];
        [_titleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_titleBtn addTarget:self action:@selector(showTypeMenu) forControlEvents:UIControlEventTouchUpInside];
        [_titleBtn setImage:[UIImage imageNamed:@"arrowheadDown"] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"arrowheadUp"] forState:UIControlStateSelected];
        _titleBtn.center = CGPointMake(ScreenWidth / 2, 40);
    }
    return _titleBtn;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
