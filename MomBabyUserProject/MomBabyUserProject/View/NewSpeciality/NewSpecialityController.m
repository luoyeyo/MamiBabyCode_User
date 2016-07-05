//
//  NewSpecialityController.m
//  AgentForWorld
//
//  Created by 罗野 on 15/9/10.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "NewSpecialityController.h"
#import "YZKDBTool.h"

@interface NewSpecialityController () <UIScrollViewDelegate> {
    NSArray *_imageList;
    UIPageControl *_page;
    UIButton *begin;
    UIImageView *_lastImage;
}

@property (strong, nonatomic) UIScrollView *scrollView;
/**
 *  初始化界面
 */
- (void)initializeAppearance;
/**
 *  初始化数据
 */
- (void)initializeDataSource;

@end

@implementation NewSpecialityController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self clearnSQLData];
    [self initializeDataSource];
    [self initializeAppearance];
    [kUserInfo exitUser];
}

- (void)clearnSQLData {
    
    // 因为2.0.1版本 数据库表字段修改了  所以要删除之前的数据库 重新创建
    [kSQLTool deleteDatabase];
    kUserInfo.token = nil;
}

- (void)initializeDataSource {
    
    _imageList = @[@"new1",@"new2",@"new3"];
}

- (void)initializeAppearance {
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    ReturnIf(!_imageList || _imageList.count == 0);
    // 初始化图片到scroll
    for (int i = 0; i < _imageList.count; i ++) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0 + self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        image.contentMode = UIViewContentModeScaleAspectFill;
        NSString *imageName = _imageList[i];
        [image setImage:ImageNamed(imageName)];
        // 当初始化到最后一个图片  添加button
        if (i == _imageList.count - 1) {
            [self initializeBeginButtonOnView:image];
        }
        [self.scrollView addSubview:image];
    }
    
    // 添加分页控制器
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _page.numberOfPages = _imageList.count;
    _page.pageIndicatorTintColor = kColorLineGray;
    _page.currentPageIndicatorTintColor = kColorTheme;
    _page.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 20);
    [self.view addSubview:_page];
}

/**
 *  初始化scroll
 *
 *  @return
 */
- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * _imageList.count, self.view.bounds.size.height);
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
    }
    return _scrollView;
}
/**
 *  开始体验 进入app
 */
- (void)beginToExperience {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.block();
    }];
}

// 初始化开始体验按钮
- (void)initializeBeginButtonOnView:(UIImageView *)imageView {
    
    _lastImage = imageView;
    imageView.userInteractionEnabled = YES;
    begin = [UIButton buttonWithType:UIButtonTypeCustom];
    [begin setBackgroundColor:[UIColor colorFromHexRGB:@"0accb7"] forState:UIControlStateNormal];
    [begin setTitle:@"立即体验" forState:UIControlStateNormal];
    [begin setTitleColor:kColorWhite forState:UIControlStateNormal];
    begin.frame = CGRectMake(0, 0, 115, 34);
    begin.layer.cornerRadius = 17;
    begin.clipsToBounds = YES;
    begin.center = CGPointMake(_lastImage.bounds.size.width / 2, _lastImage.bounds.size.height * 0.85);
    [begin addTarget:self action:@selector(beginToExperience) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:begin];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 计算偏移量 更改分页控制器显示
    double numOfPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _page.currentPage = (int)(numOfPage + 0.5);
}

@end
