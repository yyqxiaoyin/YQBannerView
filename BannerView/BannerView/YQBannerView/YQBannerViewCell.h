//
//  YQBannerViewCell.h
//  BannerView
//
//  Created by Mopon on 16/6/13.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQBannerViewCell : UICollectionViewCell

///** 图片 */
//@property (nonatomic,weak) UIImage  *image;
//
///** 图片URL */
//@property (nonatomic,copy) NSString *URLString;
//
///** 占位图 */
//@property (nonatomic,weak) UIImage *placeHolderImage;

/** 本地图片填充 */
-(void)fillCellWithImage:(UIImage *)image;

/** 网络图片填充 */
-(void)fillCellWithUrl:(NSString *)url;

@end
