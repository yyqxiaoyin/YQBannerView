//
//  YQBannerView.m
//  BannerView
//
//  Created by Mopon on 16/6/13.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQBannerView.h"
#import "YQBannerViewFlowLayout.h"


#define CellIdentifier @"bannerCell"
#define selfWeight self.bounds.size.width
#define selfHeight self.bounds.size.height

#define defaultMargin 10

@interface YQBannerView ()<UICollectionViewDataSource,UIScrollViewDelegate,UICollectionViewDelegate>

/** 点击图片的回调block */
@property (nonatomic ,copy)imageSelectedBlock selectedBlock;

/** 图片数组 */
@property (nonatomic ,strong)NSArray *images;

/** 图片链接数组 */
@property (nonatomic ,strong)NSArray *urls;

/** 标题数组 */
@property (nonatomic ,strong)NSArray *titles;

/** 图片数量 */
@property (nonatomic ,assign)NSInteger imageCount;

/** 轮播器滚动视图 */
@property (nonatomic ,strong)UICollectionView *collectionView;

/** 当前页 */
@property (nonatomic ,assign)NSInteger currPage;

/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;

/** 标题与页码View */
@property (nonatomic ,strong)UIView *titlePageView;

/** 显示标题 */
@property (nonatomic,strong) UILabel *titleLabel;

/** 分页指示器 */
@property (nonatomic,strong) UIPageControl *pageControl;

@end

@implementation YQBannerView

#pragma mark - 初始化方法
+(instancetype)bannerViewWithImages:(NSArray <UIImage *> *)images frame:(CGRect )frame titles:(NSArray <NSString *> *)titles didSelectedIndex:(imageSelectedBlock)selectedblock{

    NSAssert(images !=nil, @"图片数组不能为空");
    
    YQBannerView *bannerView = [[self alloc]initWithFrame:frame];
    if (selectedblock) {
        bannerView.selectedBlock = [selectedblock copy];
    }
    if (images) {
        bannerView.images = images;
    }
    if (titles) {
        bannerView.titles = titles;
    }
    
    return bannerView;
}

+(instancetype)bannerViewWithURLs:(NSArray<NSString *> *)urls frame:(CGRect)frame titles:(NSArray<NSString *> *)titles didSelectedIndex:(imageSelectedBlock)selectedblock{

    NSAssert(urls !=nil, @"图片链接数组不能为空");
    YQBannerView *bannerView = [[self alloc]initWithFrame:frame];
    if (selectedblock) {
        bannerView.selectedBlock = [selectedblock copy];
    }
    if (urls) {
        bannerView.urls = urls;
    }
    if (titles) {
        bannerView.titles = titles;
    }

    return bannerView;
}


#pragma mark - 成员赋值
- (void)setImages:(NSArray *)images{
    
    _images = images;
    self.imageCount = images.count;
    self.pageControl.numberOfPages = images.count;
    
    [self setUpViews];
}

-(void)setUrls:(NSArray *)urls{
    
    _urls = urls;
    self.imageCount = urls.count;
    self.pageControl.numberOfPages = urls.count;
    [self setUpViews];
}

- (void)setTitles:(NSArray *)titles{

    _titles = titles;
    if (titles) {
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.text = [titles objectAtIndex:0];
        [self.titlePageView addSubview:self.titleLabel];
    }
}

- (void)setTitleColor:(UIColor *)titleColor{

    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setTitleBackGroundColor:(UIColor *)titleBackGroundColor{

    _titleBackGroundColor = titleBackGroundColor;
    self.titleLabel.backgroundColor = titleBackGroundColor;
}

- (void)setPageControlNormalColor:(UIColor *)pageControlNormalColor{

    _pageControlNormalColor = pageControlNormalColor;
    
    self.pageControl.pageIndicatorTintColor = pageControlNormalColor;
}

- (void)setPageControlSelectColor:(UIColor *)pageControlSelectColor{

    _pageControlSelectColor = pageControlSelectColor;
    
    self.pageControl.currentPageIndicatorTintColor = pageControlSelectColor;
}

- (void)setTimerInterval:(NSInteger)timerInterval{

    _timerInterval = timerInterval;
    [self removeTimer];
    [self addTimer];
}

- (void)setAnimationType:(banerViewAnimationType)animationType{
    _animationType = animationType;
    
}

#pragma mark - 初始化子控件
- (void)setUpViews{

    [self addSubview:self.collectionView];
    
    [self addSubview:self.titlePageView];
    
    [self.titlePageView addSubview:self.pageControl];
    
//    设置默认轮播时间间隔
    _timerInterval = 2;
    [self addTimer];
    
}

#pragma mark - collection代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.images.count==1 ? 1 : 1000;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    YQBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (self.images) {
        
        [cell fillCellWithImage:self.images[indexPath.item % self.imageCount]];
    }else{
    
        [cell fillCellWithUrl:self.urls[indexPath.item %self.imageCount]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.selectedBlock) {
        self.selectedBlock(indexPath.row%self.imageCount);
    }
}

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
//{
//    [self scrollViewDidEndDecelerating:scrollView];
//}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//
//    
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    if (page == 0 || page == ([self.collectionView numberOfItemsInSection:0] - 1)) {
        
        page = self.imageCount - ((page == 0) ? 0: 1);
        self.collectionView.contentOffset = CGPointMake(page * scrollView.bounds.size.width, 0);
    }
    if (_titles) {
        self.titleLabel.text = _titles[page % self.titles.count];
    }
    self.pageControl.currentPage = page % self.imageCount;
    
}

// 当用户开始拖拽时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

// 当用户结束拖拽时调用
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

    [self addTimer];
}

- (void)scrollCollectionView
{
    // 获得当前显示的页号
    NSInteger page = self.collectionView.contentOffset.x / self.collectionView.bounds.size.width;
    // 计算偏移量
    CGFloat offsetX = (page + 1) * self.collectionView.bounds.size.width;
    
    if (self.shouldAnimate) {
        //水波动效果
        CATransition *animation=[CATransition animation];
        animation.delegate=self;
        animation.duration=0.5f;
        animation.type=@"suckEffect";
        
        [[self.collectionView layer] addAnimation:animation forKey:@"rippleEffect"];
        
    }

    // 设置偏移量
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:!self.shouldAnimate];
    
}

#pragma mark - 定时器
- (void)addTimer{
   if (_timerInterval == 0) return;
//    计时器
    self.timer = [NSTimer timerWithTimeInterval:_timerInterval target:self selector:@selector(scrollCollectionView) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)removeTimer{
    
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 布局子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    
    CGFloat titlePageH = frame.size.height *0.1;
    CGFloat titlePageW = frame.size.width;
    CGFloat titlePageY = frame.size.height -= titlePageH;
    
    _titlePageView.frame = CGRectMake(0, titlePageY, titlePageW, titlePageH);
    
    CGFloat pageW = self.imageCount * 15;
    CGFloat pageX = frame.size.width - pageW - defaultMargin;
    
    _pageControl.frame = CGRectMake(pageX , 0, pageW, titlePageH);
    
    
    CGFloat titleW = titlePageW - defaultMargin *3 - pageW;
    
    _titleLabel.frame = CGRectMake(defaultMargin, 0, titleW, titlePageH);
    
}

#pragma mark - 懒加载
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:[[YQBannerViewFlowLayout alloc] init]];
        [_collectionView registerClass:[YQBannerViewCell class] forCellWithReuseIdentifier:CellIdentifier];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}


-(UIView *)titlePageView{

    if (!_titlePageView) {
        _titlePageView = [[UIView alloc] init];
        _titlePageView.backgroundColor = [UIColor blackColor];
        _titlePageView.alpha = 0.7;
    }
    return _titlePageView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}

@end
