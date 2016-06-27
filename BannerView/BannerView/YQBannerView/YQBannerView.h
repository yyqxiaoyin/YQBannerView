//
//  YQBannerView.h
//  BannerView
//
//  Created by Mopon on 16/6/13.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YQBannerViewCell.h"

typedef enum : NSUInteger {
    banerViewAnimationTypeFade,//淡化过度
    banerViewAnimationTypeRippleEffect,//水纹效果
    banerViewAnimationTypeOglFlip,//左右翻转效果
    banerViewAnimationTypeCube,//立体翻转效果
    banerViewAnimationTypeSuckEffect,//收缩效果
    banerViewAnimationTypePageCurl,//向上翻页效果
    banerViewAnimationTypePageUnCurl,//向下翻页效果
} banerViewAnimationType;

typedef void(^imageSelectedBlock)(NSInteger index);

@interface YQBannerView : UIView

/**
 *  图片数组创建图片轮播器
 *
 *  @param images 图片数组
 *  @param titles 标题数组
 *  @param block  点击图片回调
 *
 *  @return 图片轮播器
 */
+(instancetype)bannerViewWithImages:(NSArray <UIImage *> *)images frame:(CGRect )frame titles:(NSArray <NSString *> *)titles didSelectedIndex:(imageSelectedBlock)selectedblock;

/**
 *  图片链接数组创建图片轮播器
 *
 *  @param urls          图片链接数组
 *  @param frame         轮播器frame
 *  @param titles        标题数组
 *  @param selectedblock 图片点击回调
 *
 *  @return 图片轮播器
 */
+(instancetype)bannerViewWithURLs:(NSArray <NSString *>*)urls frame:(CGRect )frame titles:(NSArray <NSString *> *)titles didSelectedIndex:(imageSelectedBlock)selectedblock;

/**
 *  轮播时间间隔
 */
@property (nonatomic ,assign)NSInteger timerInterval;

/**
 *  标题颜色
 */
@property (nonatomic ,strong)UIColor *titleColor;

/**
 *  标题背景颜色
 */
@property (nonatomic ,strong)UIColor *titleBackGroundColor;

/**
 *  页面器普通状态下的颜色
 */
@property (nonatomic ,strong)UIColor *pageControlNormalColor;

/**
 *  页码器选中状态下的颜色
 */
@property (nonatomic ,strong)UIColor *pageControlSelectColor;

/**
 *  动画类型
 */
@property (nonatomic ,assign)banerViewAnimationType animationType;

/**
 *  是否开启动画
 */
@property (nonatomic ,assign)BOOL shouldAnimate;


@end
