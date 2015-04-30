//
//  AdView.m
//  Wedding
//
//  Created by 徐恺君 on 15/3/10.
//  Copyright (c) 2015年 7jj. All rights reserved.
//

#import "AdView.h"

@interface AdView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation AdView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.delegate = self;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 37, self.frame.size.width, 37)];
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
}

- (NSUInteger)index
{
    return self.pageControl.currentPage;
}

- (void)setIndex:(NSUInteger)index
{
    [self scrollToIndex:index];
}

- (void)setCurrentPageColor:(UIColor *)currentColor tintColor:(UIColor *)tintColor
{
    self.pageControl.currentPageIndicatorTintColor = currentColor;
    self.pageControl.pageIndicatorTintColor = tintColor;
}

- (void)addAds:(NSArray *)ads
{
    _count = ads.count;

    self.scrollView.contentSize = CGSizeMake(self.frame.size.width * _count, self.frame.size.height);
    self.pageControl.numberOfPages = _count;
    
    for (int i = 0; i < ads.count; i++) {
        
        CGPoint center = CGPointMake(self.scrollView.bounds.size.width * (i + 0.5), self.scrollView.bounds.size.height / 2.0);
        UIView *adView = ads[i];
        adView.center = center;
        [self.scrollView addSubview:adView];
        
        // 添加点击手势
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        gesture.numberOfTapsRequired = 1;
        [adView addGestureRecognizer:gesture];
    }
}

- (void)onTap:(UIGestureRecognizer *)recognizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(adView:didSelectedIndex:)]) {
        [self.delegate adView:self didSelectedIndex:self.pageControl.currentPage];
    }
}

#pragma mark - 自动滚动

- (void)startAutoScrollWithTime:(NSTimeInterval)time
{
    if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(scrollAdView) userInfo:nil repeats:YES];
    }
}

- (void)scrollAdView
{
    NSUInteger nextIndex = self.pageControl.currentPage + 1;
    
    if (nextIndex > _count - 1) {
        [self scrollToIndex:0];
    }
    else {
        [self scrollToIndex:nextIndex];
    }
}

- (void)scrollToIndex:(NSUInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * index, 0) animated:YES];
    self.pageControl.currentPage = index;
}

- (void)stopAutoScroll
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

#pragma mark - scroll delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat x = scrollView.contentOffset.x;
    self.pageControl.currentPage = x / self.frame.size.width;
}

@end
