//
//  CustomLayout.m
//  自定义集合视图
//
//  Created by 罗野 on 15/5/15.
//  Copyright (c) 2015年 luo. All rights reserved.
//

#import "CustomLayout.h"

@interface CustomLayout () {
    CGFloat _itemY;
    CGFloat _itemX;
    CGFloat _itemWidth;
    CGFloat _itemHeight;
}

// 记录当前有多少元素
@property (nonatomic, assign) NSInteger cellCount;

@end

@implementation CustomLayout

// 在CustomLayout初始化(init)后会自动调用  可以进行参数的初始化
- (void)prepareLayout {
    [super prepareLayout];
    if (self.collectionView.numberOfSections != 0) {
        _cellCount = [self.collectionView numberOfItemsInSection:0];
        _itemX = 0;
        _itemY = 0;
    }
    // 初始化数据
}
// 指定collectionView 的ContentSize值
- (CGSize)collectionViewContentSize {
    return [self collectionView].frame.size;
}

// 所有元素布局的数组
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < _cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [array addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return array;
}
// 根据下标返回每个item的布局方式
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewLayoutAttributes* attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath]; //生成空白的attributes对象，其中只记录了类型是cell以及对应的位置是indexPath
    CGFloat selfWidth = [self collectionView].bounds.size.width;
    NSInteger index = 0;
    switch (indexPath.row) {
        case 0:
            index = 0;
            _itemY = 0;
            _itemHeight = selfWidth / 5 * 2 + 1;
            _itemWidth = selfWidth / 2 + 1;
            break;
        case 1:
            index = 2;
            _itemHeight = selfWidth / 5 + 1;
            _itemWidth = selfWidth / 4 + 1;
            break;
        case 2:
            index = 3;
            break;
        case 3:
            index = 2;
            _itemY = selfWidth / 5;
            break;
        case 4:
            index = 3;
            break;
        case 5:
            // 第五个的高度为第一个的宽度 + 6   因为下面加了65  所以要先减65
            _itemY = selfWidth / 5 * 2 + 6 - 65;
            _itemWidth = selfWidth / 2;
            _itemHeight = 65;
        default:
            // 单数证明换行了  所以位置高度+65
            if (indexPath.row % 2 == 1) {
                _itemY += 65;
            }
            // 根据后面5 6 7.。。的规律计算X起点
            index = (indexPath.row + 1) % 2 * 2;
            // 最后一个cell  并且cell总数为复数
            if (indexPath.row == _cellCount - 1 && _cellCount % 2 == 0) {
                _itemWidth = selfWidth;
            }
            break;
    }
    _itemX = selfWidth / 4 * index;
    attributes.frame = CGRectMake(_itemX, _itemY, _itemWidth, _itemHeight);
    return attributes;
}


@end
