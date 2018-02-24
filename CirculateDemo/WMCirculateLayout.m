//
//  WMCirculateLayout.m
//  CirculateDemo
//
//  Created by oliver on 2018/2/23.
//  Copyright © 2018年 oliver. All rights reserved.
//

#import "WMCirculateLayout.h"



@interface WMCirculateLayout()

@end



@implementation WMCirculateLayout

- (void)prepareLayout
{
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = kSpace;
    self.sectionInset = UIEdgeInsetsMake(0, kSpace, 0, 0);
    self.itemSize = CGSizeMake(kItemWidth,
                               self.collectionView.frame.size.height - kHeightSpace*2);
    [super prepareLayout];
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *superAttributes = [super layoutAttributesForElementsInRect:rect];
    NSArray *attributes = [[NSArray alloc] initWithArray:superAttributes copyItems:YES];
    
    CGRect visibleRect = CGRectMake(self.collectionView.contentOffset.x,
                                    0,
                                    kScreen_width,
                                    kCollectionHeight);
    CGFloat centerX = CGRectGetMidX(visibleRect);
    
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat distance = centerX - attribute.center.x;
        // 越靠近中心，值越小，缩放系数越小，显示越大
        // 越远离中心，值越大，缩放就越大，显示就越小
        // 缩放的是高度，也就是Y轴，以ItemHeight计算缩放系数
        CGFloat scaleHeight = distance / self.itemSize.height;
        
        CGFloat scale = (1 - kScale) + kScale * (1 - fabs(scaleHeight));
        attribute.transform3D = CATransform3DMakeScale(1, scale, 1);
        attribute.zIndex = 1;
    }];
    
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 确定停止时显示区域
    CGRect visibleRect;
    visibleRect.origin  = proposedContentOffset;
    visibleRect.size    = CGSizeMake(kScreen_width, kCollectionHeight);
    // 获取这个区域中心
    CGFloat centerX = CGRectGetMidX(visibleRect);
    // 获得这个区域内Item
    NSArray *arr = [super layoutAttributesForElementsInRect:visibleRect];
    
    CGFloat distance = MAXFLOAT;
    
    // 遍历寻找距离中心点最近的Item
    for (UICollectionViewLayoutAttributes *atts in arr) {
        if (fabs(centerX - atts.center.x) < distance) {
            distance = centerX - atts.center.x;
        }
    }
    distance -= 4;
    // 补偿差值
    proposedContentOffset.x -= distance;
    
    // 防止在第一个和最后一个  卡住
    if (proposedContentOffset.x < 0) {
        proposedContentOffset.x = 0;
    }
    if (proposedContentOffset.x > (self.collectionView.contentSize.width - self.sectionInset.left - self.sectionInset.right - self.itemSize.width)) {
        
        proposedContentOffset.x = floor(proposedContentOffset.x);
    }
    NSLog(@"x1 = %f, y1 = %f",proposedContentOffset.x,proposedContentOffset.y);
    NSLog(@"x = %f, y = %f",velocity.x,velocity.y);

    return proposedContentOffset;
}

//滚动的时会调用
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds;
{
    return YES;
}



@end
