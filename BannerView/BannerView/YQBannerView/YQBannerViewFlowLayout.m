//
//  YQBannerViewFlowLayout.m
//  BannerView
//
//  Created by Mopon on 16/6/13.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQBannerViewFlowLayout.h"

@implementation YQBannerViewFlowLayout

-(void)prepareLayout{
    [super prepareLayout];
    
    // 设置item的尺寸
    self.itemSize = self.collectionView.bounds.size;
    // 设置item之间的间隙
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    // 设置方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置分页效果
    self.collectionView.pagingEnabled = YES;
    // 设置隐藏水平滚动条
//    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    // 禁止弹簧效果
    self.collectionView.bounces = NO;
}

@end
