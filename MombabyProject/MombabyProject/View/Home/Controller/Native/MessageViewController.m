//
//  MessageViewController.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/13.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "SuperTableView.h"


@interface MessageViewController ()<UIScrollViewDelegate,SuperTableViewDelegate>{
    NSMutableArray * _titleArr;
}
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UILabel * scrollLabel;
@property (nonatomic, strong) NSMutableArray * dataArr;
@property (nonatomic, strong) UITableView * myTableView;
@property (nonatomic, copy) NSString * myType;


@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataArr = [NSMutableArray array];
        _titleArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"消息"];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"消息"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_C4;
    [self customNavgationBar];
    self.navTitle.text = @"消息";
    if ([self.pushType isEqualToString:@"推送"]) {
        [self.backButton addTarget:self action:@selector(ppppppp) forControlEvents:UIControlEventTouchUpInside];
    }
    [self createView];
}

- (void)ppppppp {
    [self dismissViewControllerAnimated:NO completion:^{
        
    }];
}

- (void)createView{
    //type : 1:消息,2:医生指导,3:健康贴士
    if (kUserInfo.userType  == kUserTypeNormal) {
        //注册用户
        NSArray * arr = @[@"健康贴士",@"通知"];
        [_titleArr addObjectsFromArray:arr];
        self.myType = @"3";
    }
    else{
        //会员用户
        NSArray * vipArr = @[@"医生指导",@"健康贴士",@"通知"];
        [_titleArr addObjectsFromArray:vipArr];
        self.myType = @"2";
    }
    [self threeBtn];
    [self createTableView];
}

- (void)createTableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 109, self.view.width, self.view.height - 108.5)];
    self.scrollView.contentSize = CGSizeMake(self.view.width * _titleArr.count, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    
    for (int i = 0; i < _titleArr.count; i++) {
        SuperTableView * superView = [[SuperTableView alloc] initWithFrame:CGRectMake(self.view.width * i, 0, self.view.width, self.scrollView.height)];
        superView.delegate = self;
        superView.tag = 2000 + i;
        [self.scrollView addSubview:superView];
    }
    
    SuperTableView * superView = (SuperTableView *)[self.view viewWithTag:2000];
    [self connect:superView];
}

- (void)connect:(SuperTableView *)superTable
{
    NSString * page = [NSString stringWithFormat:@"%d",superTable.page];
    //type : 1:消息,2:医生指导,3:健康贴士
    NSDictionary * dic = @{@"page":page,@"limit":@"20",@"type":self.myType};
    [self.view showPopupLoading];
    [kShareManager_Home getMessageWithParams:dic ResponseBlock:^(LLError *error, id result) {
        [self.view hidePopupLoading];
        if (error) {
            [self.view showToastMessage:error.errormsg];
        } else {
            [superTable.sourceArr addObjectsFromArray:[result objectForKey:@"list"]];
            [superTable.myTableView reloadData];
            [superTable.myTableView.mj_header endRefreshing];
            [superTable.myTableView.mj_footer endRefreshing];
            if ([[result objectForKey:@"list"] count] < 20){
                superTable.myTableView.mj_footer.hidden = YES;
            }
            else if ([[result objectForKey:@"list"] count] == 20){
                superTable.myTableView.mj_footer.hidden = NO;
                [superTable.myTableView.mj_footer endRefreshing];
            }
        }
    }];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        NSInteger btnTag = self.scrollView.contentOffset.x / self.scrollView.width;
        UIButton *selectButton = (UIButton *)[self.view viewWithTag:btnTag+1000];
        [self btnAction:selectButton];
    }
}
#pragma mark - 顶部三个按钮 实现方法
- (void)threeBtn{
    
    for (int i = 0; i < _titleArr.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.bounds.size.width / _titleArr.count * i, 64, self.view.bounds.size.width / _titleArr.count, 44);
        [btn setTitle:[_titleArr objectAtIndex:i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorFromHexRGB:@"666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorFromHexRGB:@"f5728b"] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        btn.backgroundColor = [UIColor colorFromHexRGB:@"ffffff"];
        btn.tag = 1000 + i;
        if (i == 0) {
            btn.selected = YES;
        }
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(self.view.width / _titleArr.count * i, 76, 1, 20)];
        lineView.backgroundColor = [UIColor colorFromHexRGB:@"e2e2e2"];
        [self.view addSubview:lineView];
    }
    
    UILabel * xLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 108, self.view.bounds.size.width, 0.5)];
    xLabel.backgroundColor = [UIColor colorFromHexRGB:@"e2e2e2"];
    [self.view addSubview:xLabel];
    
    //滑动的红线
    self.scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 106.5, self.view.bounds.size.width / 3 - 40, 2)];
    if (_titleArr.count < 3) {
        self.scrollLabel.frame = CGRectMake((self.view.width / 4) - 25, 106.5, 50, 2);
    }
    [_scrollLabel setBackgroundColor:kColorTheme];
    [self.view addSubview:_scrollLabel];
    
}

- (void)btnAction:(UIButton *)btn{
    if (btn.selected == NO) {
        UIButton * button  = (UIButton *)btn;
        for (int i = 0; i < _titleArr.count; i++) {
            UIButton * otherButton = (UIButton *)[self.view viewWithTag:1000 + i];
            if (otherButton.tag != button.tag) {
                otherButton.selected = NO;
                otherButton.userInteractionEnabled = YES;
            }
        }
        button.selected = !button.selected;
        if (button.selected == YES) {
            button.userInteractionEnabled = NO;
        }
        NSInteger i = button.tag - 1000;
        [UIView animateWithDuration:0.5
                         animations:^{
                             if (_titleArr.count < 3) {
                                 CGFloat witdh = (self.view.width / 4) - 25;
                                 _scrollLabel.frame = CGRectMake(witdh + i * self.view.width / 2, 106.5, 50, 2);
                             }
                             else{
                                 _scrollLabel.frame = CGRectMake(20 + i * (self.view.width / 3 - 40) + i * 40, 106.5, self.view.bounds.size.width / 3 - 40, 2);
                             }
                             self.scrollView.contentOffset = CGPointMake(ScreenWidth * i, 0);
                         }];
        
        SuperTableView * superView = (SuperTableView *)[self.view viewWithTag:2000 + i];
        //type : 1:消息,2:医生指导,3:健康贴士
        if (_titleArr.count < 3) {
            //注册
            if (i == 0) {
                self.myType = @"3";
            }
            else{
                self.myType = @"1";
            }
            if (superView.sourceArr.count == 0) {
                [self connect:superView];
            }
        }
        else{
            //会员
            if (i == 0) {
                self.myType = @"2";
            }
            else if (i == 1){
                self.myType = @"3";
            }
            else{
                self.myType = @"1";
            }
            if (superView.sourceArr.count == 0) {
                [self connect:superView];
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
