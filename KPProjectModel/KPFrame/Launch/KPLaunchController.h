//
//  KPLaunchController.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/31.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KPSplashController.h"
#import "KPGuideController.h"

@interface KPLaunchController : UIViewController

/**
 *  主界面
 */
@property (nonatomic, strong) UIViewController *mainViewController;

/**
 *  引导页
 */
@property (nonatomic, strong) KPGuideController *guideController;

/**
 *  闪屏页
 */
@property (nonatomic, strong) KPSplashController *splashController;

/**
 *  是否显示闪屏页
 */
@property (nonatomic, assign) BOOL isShowSplash;

/**
 *  是否显示引导页
 */
@property (nonatomic, assign) BOOL isShowGuide;

/**
 *  闪屏页停留时间，最低2秒
 */
@property (nonatomic, assign) NSTimeInterval stayTime;

@end
