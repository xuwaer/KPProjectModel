//
//  KPLaunchController.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/31.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPLaunchController.h"

static NSUInteger const kSplashTimeInterval = 2;

@implementation KPLaunchController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
    [self initViewControllers];
    
    [self showSplash];
}

- (void)initViews
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initViewControllers
{
    if (_splashController) {
        [self addChildViewController:_splashController];
        [_splashController didMoveToParentViewController:self];
    }
    
    if (_guideController) {
        [self addChildViewController:_guideController];
        [_guideController didMoveToParentViewController:self];
    }
    
    if (_mainViewController) {
        [self addChildViewController:_mainViewController];
        [_mainViewController didMoveToParentViewController:self];
    }
}

#pragma mark - 闪屏页

- (void)showSplash
{
    if (_isShowSplash) {
        
        _splashController.view.frame = self.view.frame;

        [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
            [self.view addSubview:_splashController.view];
            
        } completion:^(BOOL finished) {
            
            [self performSelector:@selector(showGuide) withObject:nil afterDelay:(self.stayTime > kSplashTimeInterval ? self.stayTime : kSplashTimeInterval)];
        }];
    }
    else {
        [self showGuide];
    }
}

- (void)hideSplash
{
    if (_splashController) {
        [_splashController.view removeFromSuperview];
    }
}

#pragma mark - 引导页

- (void)showGuide
{
    if (_isShowGuide) {
        
        __weak typeof(self) weakSelf = self;
        
        _guideController.completionBlock = ^{
            [weakSelf showMain];
        };
        
        _guideController.view.frame = self.view.frame;

        [UIView transitionWithView:self.view duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
            [weakSelf.view addSubview:_guideController.view];
            
        } completion:^(BOOL finished) {
            
            [weakSelf hideSplash];
        }];
    }
    else {
        [self showMain];
    }
}

- (void)hideGuide
{
    if (_guideController) {
        [_guideController.view removeFromSuperview];
    }
}

#pragma mark - 主界面

- (void)showMain
{
    __weak typeof(self) weakSelf = self;

    _mainViewController.view.frame = self.view.frame;

    [UIView transitionWithView:self.view duration:0.7 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        [weakSelf.view addSubview:_mainViewController.view];
        
    } completion:^(BOOL finished) {
        
        [weakSelf hideSplash];
        [weakSelf hideGuide];
    }];
}

@end
