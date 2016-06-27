//
//  YQBannerViewCell.m
//  BannerView
//
//  Created by Mopon on 16/6/13.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQBannerViewCell.h"

#define cachePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"cacheImageDict.data"]

@interface YQBannerViewCell ()

/** 广告图片 */
@property (nonatomic ,strong)UIImageView *bannerImageView;

@end

static NSMutableDictionary *imageCacheDict;

@implementation YQBannerViewCell

+(void)initialize{
    
    if (imageCacheDict == nil) {
        imageCacheDict = [NSKeyedUnarchiver unarchiveObjectWithFile:cachePath];
        if (imageCacheDict ==nil) {
            imageCacheDict = [NSMutableDictionary dictionary];
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
//        self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];

        self.bannerImageView = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
        self.bannerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bannerImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.bannerImageView];


    }
    return self;
}

-(void)fillCellWithImage:(UIImage *)image{

    self.bannerImageView.image = image;
    
}

-(void)fillCellWithUrl:(NSString *)url{

    UIImage *image = imageCacheDict[url];//根据url查找缓存中有没有缓存好的图片
    
    if (image ==nil) {//该链接没有缓存的图片
        
        self.bannerImageView.image = [UIImage imageNamed:@"placeHolderImage"];//先设置占坑图
        
        [self downloadImage:[NSURL URLWithString:url] cacheKey:url];
        
        
    }else{//有缓存用缓存的图片
    
        self.bannerImageView.image = image;
        
    }
}

-(void)downloadImage:(NSURL *)url cacheKey:(NSString *)key{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{//新开子线程下载图片
        
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        if(imageData == nil) return ;
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        [imageCacheDict setObject:image forKey:key];
            
        [NSKeyedArchiver archiveRootObject:imageCacheDict toFile:cachePath];

    });
    
}


@end
