//
//  SuperTableView.m
//  MommyBaby_user
//
//  Created by 倾心丶大二姐姐 on 15/11/17.
//  Copyright © 2015年 龙源美生. All rights reserved.
//

#import "SuperTableView.h"
#import "MessageCell.h"

@implementation SuperTableView
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = frame;
        self.backgroundColor = COLOR_C4;
        self.page = 1;
        self.sourceArr = [NSMutableArray array];
        self.indexPathArr = [NSMutableArray array];
        [self createTableView];
    }
    return self;
}

- (void)createTableView{
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.backgroundColor = COLOR_C4;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.myTableView];
    
    
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(addHeader)];
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(addFooter)];
    
//    [self.myTableView.header beginRefreshing];
}

- (void)addHeader{
    _page = 1;
    [_sourceArr removeAllObjects];
    [self.delegate connect:self];
}

- (void)addFooter{
    _page++;
    [self.delegate connect:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sourceArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellId = @"cell";
    MessageCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSString * timeStr = [NSString stringWithFormat:@"%@",[[self.sourceArr objectAtIndex:indexPath.row] objectForKey:@"created"]];
    cell.dateLabel.text = [NSDate dateStringWithTimeInterval:timeStr.doubleValue formatterStr:@"yyyy-MM-dd"];
    
    CGFloat height = [[[self.sourceArr objectAtIndex:indexPath.row] objectForKey:@"content"] sizeWithFont:UIFONT_H2_13 maxSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT)].height;
    
    if ([self.indexPathArr containsObject:indexPath]) {
        cell.detailsLabel.frame = CGRectMake(5, 5, ScreenWidth - 30, height);
        cell.detailsLabel.text = [[self.sourceArr objectAtIndex:indexPath.row] objectForKey:@"content"];
        cell.whiteColorView.frame = CGRectMake(10, 45, ScreenWidth - 20, height + 30);
        cell.isOpenLabel.frame = CGRectMake(ScreenWidth - 75, cell.detailsLabel.bottom, 60, 20);
        cell.isOpenLabel.hidden = NO;
        cell.isOpenLabel.text = @"[收起]"; 
    }
    else{
        if (height > 46.541016) {
            height = 47;
            cell.detailsLabel.frame = CGRectMake(5, 5, ScreenWidth - 30, height);
            cell.detailsLabel.text = [[self.sourceArr objectAtIndex:indexPath.row] objectForKey:@"content"];
            cell.whiteColorView.frame = CGRectMake(10, 45, ScreenWidth - 20, height + 30);
            cell.isOpenLabel.frame = CGRectMake(ScreenWidth - 75, cell.detailsLabel.bottom, 60, 20);
            cell.isOpenLabel.hidden = NO;
            cell.isOpenLabel.text = @"[展开]";
        }
        else{
            cell.detailsLabel.frame = CGRectMake(5, 5, ScreenWidth - 30, height);
            cell.detailsLabel.text = [[self.sourceArr objectAtIndex:indexPath.row] objectForKey:@"content"];
            cell.whiteColorView.frame = CGRectMake(10, 45, ScreenWidth - 20, height + 10);
            cell.isOpenLabel.frame = CGRectMake(ScreenWidth - 75, cell.detailsLabel.bottom, 60, 20);
            cell.isOpenLabel.hidden = YES;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.clipsToBounds = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [[[self.sourceArr objectAtIndex:indexPath.row] objectForKey:@"content"] sizeWithFont:UIFONT_H2_13 maxSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT)].height;
    if ([self.indexPathArr containsObject:indexPath]) {
        return height + 75 + 10;
    }
    else{
        if (height > 46.541016) {
            return 75 + 47 + 10;
        }
        else{
            return height + 55 + 10;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = [[[self.sourceArr objectAtIndex:indexPath.row] objectForKey:@"content"] sizeWithFont:[UIFont systemFontOfSize:13] maxSize:CGSizeMake(ScreenWidth - 30, MAXFLOAT)].height;
    
    if ([self.indexPathArr containsObject:indexPath]) {
        [self.indexPathArr removeObject:indexPath];
    }
    else{
        if (height > 46.541016) {
            [self.indexPathArr addObject:indexPath];
        }
        else{
            
        }
    }
    
    if (height > 46.541016) {
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}

@end
