//
//  RelatedReadingTableView.m
//  yiMiaoProject
//
//  Created by 罗野 on 16/6/17.
//  Copyright © 2016年 luo. All rights reserved.
//

#import "RelatedReadingTableView.h"
#import "RelateReadCell.h"
#import "OneGuideInfoCell.h"

@implementation RelatedReadingTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        OneGuideInfoCell *cell = [OneGuideInfoCell defaultClassNameNibView];
        cell.tagImage.hidden = YES;
        cell.titleImage.image = ImageNamed(@"page3_icon_read");
        cell.title.text = @"相关阅读";
        return cell;
    }
    RelateReadCell *cell = [RelateReadCell defaultClassNameNibView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectCellBlock) {
        self.selectCellBlock(indexPath.section);
    }
}

- (CGFloat)tableHeight {
    return 120 + 90;
}

@end
