//
//  WMCirculateLayout.h
//  CirculateDemo
//
//  Created by oliver on 2018/2/23.
//  Copyright © 2018年 oliver. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreen_width ([UIScreen mainScreen].bounds.size.width)
#define kCollectionHeight 100
#define kSpace 10
#define kItemWidth (kScreen_width - 20 - 5)
#define kHeightSpace 10
#define kScale 0.03
#define kItemSpace 10

@interface WMCirculateLayout : UICollectionViewFlowLayout

@end
