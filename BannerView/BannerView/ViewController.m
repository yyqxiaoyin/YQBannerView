//
//  ViewController.m
//  BannerView
//
//  Created by Mopon on 16/6/13.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "ViewController.h"
#import "YQBannerView.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    NSMutableArray *images = @[].mutableCopy;
    NSMutableArray *titles = @[].mutableCopy;
    for (NSInteger i= 1; i<=7; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu.jpg",i]];
        [images addObject:image];
        NSMutableString *str = [NSMutableString stringWithFormat:@"阿"];
        for (NSInteger j= 0; j<i; j++) {
            [str appendString:@"阿萨德"];
        }
        [titles addObject:str];
    }
    
    CGRect frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.width *9 /16);
//    YQBannerView *bannerView =  [YQBannerView bannerViewWithImages:images
//                                                             frame:frame
//                                                            titles:titles
//                                                  didSelectedIndex:^(NSInteger i) {
//        
//                                                      NSLog(@"%lu",i);
//                                                  }];
//    bannerView.timerInterval = 1;
//    
//    [self.view addSubview:bannerView];
    
    
    NSArray *urls = [NSArray arrayWithObjects:
                    @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1465977947&di=8eca009f37669035ab05cc2a5e54af29&src=http://h.hiphotos.baidu.com/image/pic/item/43a7d933c895d143b233160576f082025aaf074a.jpg",
                    @"http://a.hiphotos.baidu.com/image/pic/item/7dd98d1001e9390191637f187eec54e736d196b7.jpg",
                    @"http://f.hiphotos.baidu.com/image/pic/item/b90e7bec54e736d19a8c7e2e9e504fc2d562697d.jpg",
                    @"http://f.hiphotos.baidu.com/image/pic/item/b03533fa828ba61e4dab3a094434970a304e594b.jpg",
                    @"http://a.hiphotos.baidu.com/image/pic/item/d50735fae6cd7b898628c8a50a2442a7d9330e4b.jpg",
                    @"http://d.hiphotos.baidu.com/image/pic/item/0ff41bd5ad6eddc45a6646dd3cdbb6fd52663316.jpg",
                    @"http://b.hiphotos.baidu.com/image/pic/item/21a4462309f79052e99eb51809f3d7ca7bcbd517.jpg",
                    @"http://b.hiphotos.baidu.com/image/pic/item/8b13632762d0f703f05867fa0dfa513d2697c52a.jpg",
                    nil];
    
    
    YQBannerView *bannerViewUrl = [YQBannerView bannerViewWithURLs:urls frame:frame titles:titles didSelectedIndex:^(NSInteger index) {
       
        NSLog(@"%lu",index);
    }];
    
    bannerViewUrl.timerInterval = 10;
    
    bannerViewUrl.shouldAnimate = YES;
    
    [self.view addSubview:bannerViewUrl];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
