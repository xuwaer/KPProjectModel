//
//  KPGuideController.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/27.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPGuideController.h"

static CGFloat const kPageControlWidth = 80;
static CGFloat const kSkipButtonWidth = 100;
static CGFloat const kSkipButtonHeight = 44;

static NSString * const kSkipButtonText = @"跳过";

@interface KPGuideController () <UIPageViewControllerDelegate, UIPageViewControllerDataSource, UIScrollViewDelegate>
{
    UIPageViewController *pageController;
    UIPageControl *pageControl;
}

@end

@implementation KPGuideController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建引导页page
    [self generatePageViews];
    // 创建page control
    [self generatePageControl];
    // 其他控件
    [self generateOther];
}

- (void)generatePageViews
{
    pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageController.view.frame = self.view.frame;
    pageController.view.backgroundColor = [UIColor whiteColor];
    pageController.delegate = self;
    pageController.dataSource = self;
    
    UIViewController *currentPageController = [_viewControllers firstObject];
    
    [pageController setViewControllers:@[currentPageController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    pageController.view.backgroundColor = [UIColor clearColor];
    [self addChildViewController:pageController];
    [self.view addSubview:pageController.view];
    [pageController didMoveToParentViewController:self];
    
    for (UIView *view in pageController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)view setDelegate:self];
        }
    }
}

- (void)generatePageControl
{
    pageControl = [[UIPageControl alloc] init];
    pageControl.bounds = Rect(0, 0, kPageControlWidth, 37);
    pageControl.center = Point(ScreenWidth / 2.0, ScreenHeight - 37);
    pageControl.currentPage = 0;
    pageControl.numberOfPages = _viewControllers.count;
    pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
    pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
    [self.view addSubview:pageControl];
    [self.view bringSubviewToFront:pageControl];
}

- (void)generateOther
{
    if (_showSkip) {
        
        UIButton *btnSkip = [UIButton buttonWithType:UIButtonTypeCustom];
        btnSkip.frame = Rect(ScreenWidth - kSkipButtonWidth, ScreenHeight - kSkipButtonHeight, kSkipButtonWidth, kSkipButtonHeight);
        [btnSkip setTitle:kSkipButtonText forState:UIControlStateNormal];
        [btnSkip addTarget:self action:@selector(onSkipClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnSkip];
        [self.view bringSubviewToFront:btnSkip];
    }
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)onSkipClick
{
    _completionBlock();
}

#pragma mark - pageController delegate / datasource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController == [_viewControllers firstObject]) {
        [self setPageControl:0];
        return nil;
    }
    else {
        
        NSInteger priorPageIndex = [self.viewControllers indexOfObject:viewController] - 1;
        [self setPageControl:priorPageIndex + 1];
        return _viewControllers[priorPageIndex];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController == [_viewControllers lastObject]) {
        [self setPageControl:_viewControllers.count - 1];
        return nil;
    }
    else {
        NSInteger nextPageIndex = [_viewControllers indexOfObject:viewController] + 1;
        [self setPageControl:nextPageIndex - 1];
        return _viewControllers[nextPageIndex];
    }
}

#pragma mark - 页面处理

- (void)setPageControl:(NSUInteger)index
{
    pageControl.currentPage = index;
}

#pragma mark - page scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat percentComplete = (scrollView.contentOffset.x - self.view.frame.size.width) / self.view.frame.size.width;

    if (percentComplete > 0.15 && pageControl.currentPage == pageControl.numberOfPages - 1) {
        _completionBlock();
    }
}

@end
