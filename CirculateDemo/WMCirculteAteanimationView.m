//
//  WMCirculteAteanimationView.m
//  CirculateDemo
//
//  Created by oliver on 2018/2/23.
//  Copyright © 2018年 oliver. All rights reserved.
//

#import "WMCirculteAteanimationView.h"
#import "WMCirculateLayout.h"

#define kSectionCount 6

static NSString *cellIdentifier = @"CollectionCell";

@interface WMCirculteAteanimationView()

@property (nonatomic, strong) UICollectionView *circulteCollectionView;

@end

@implementation WMCirculteAteanimationView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        [self addSubview:self.circulteCollectionView];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self.clipsToBounds = NO;
        [self addSubview:self.circulteCollectionView];
    }
    return self;
}


#pragma mark - collectionView
- (UICollectionView *)circulteCollectionView
{
    if (!_circulteCollectionView) {
        
        WMCirculateLayout *layout = [[WMCirculateLayout alloc] init];
        _circulteCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_width, kCollectionHeight) collectionViewLayout:layout];
        _circulteCollectionView.decelerationRate = 0.3;
//        _circulteCollectionView.pagingEnabled = YES;
//        _circulteCollectionView.clipsToBounds = NO;
        _circulteCollectionView.backgroundColor = [UIColor redColor];
        [_circulteCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
        _circulteCollectionView.delegate = self;
        _circulteCollectionView.dataSource = self;
        
        //开始时让CollectionView滚动到一个中间位置
        //计算frame，确保Item居中
//        [_circulteCollectionView setContentOffset:CGPointMake((kItemWidth+kSpace)*kSectionCount/2-kItemSpace, 0)];
    }
    return _circulteCollectionView;
}


#pragma mark UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSString *imageName = [NSString stringWithFormat:@"wm_0%ld", (long)indexPath.item];
    UIImage *myImage = [UIImage imageNamed:imageName];
//    cell.clipsToBounds = NO;
//    cell.contentView.clipsToBounds = NO;
    cell.contentView.layer.contents = (__bridge id _Nullable)(myImage.CGImage);
    return cell;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kSectionCount;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第几张 %ld", (long)indexPath.item);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset  {
    

}


@end
