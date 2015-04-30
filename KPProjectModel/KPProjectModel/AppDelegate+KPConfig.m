//
//  AppDelegate+KPConfig.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/24.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "AppDelegate+KPConfig.h"
#import "ViewController.h"

@implementation AppDelegate (KPConfig)

- (void)config
{
    // 开启日志
    [KPManager addLog];
    // 开启提示
    [KPManager addAlert:self.window];
}


#pragma mark - 启动页设置

- (void)setupLaunch
{
    ViewController *mainController = [[ViewController alloc] initFromStoryboard:@"Main" identifier:@"ViewController" bundle:nil];
    
    KPLaunchController *controller = [[KPLaunchController alloc] init];
    controller.splashController = [self setupSplash];
    controller.guideController = [self setupGuide];
    controller.mainViewController = [[UINavigationController alloc] initWithRootViewController:mainController];
    
    controller.isShowSplash = YES;
    controller.isShowGuide = YES;
    
    self.window.rootViewController = controller;
}

/**
 *  设置闪屏启动页
 *
 *  @return
 */
- (KPSplashController *)setupSplash
{
    KPSplashController *controller = [[KPSplashController alloc] init];
    controller.view.backgroundColor = [UIColor orangeColor];
    return controller;
}

/**
 *  设置引导页
 *
 *  @return 
 */
- (KPGuideController *)setupGuide
{
    UIViewController *v1 = [[UIViewController alloc] init];
    v1.view.backgroundColor = [UIColor redColor];
    
    UIViewController *v2 = [[UIViewController alloc] init];
    v2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController *v3 = [[UIViewController alloc] init];
    v3.view.backgroundColor = [UIColor grayColor];
    
    UIViewController *v4 = [[UIViewController alloc] init];
    v4.view.backgroundColor = [UIColor blueColor];
    
    KPGuideController *controller = [[KPGuideController alloc] init];
    controller.viewControllers = @[v1, v2, v3, v4];
    controller.completionBlock = nil;
    controller.showSkip = YES;
    
    return controller;
}

@end
