//
//  KPGuideController.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/27.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GuideCompletion)(void);

@interface KPGuideController : UIViewController

/**
 *  引导页数组
 */
@property (nonatomic, strong) NSArray *viewControllers;

/**
 *  pageControl属性
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;

/**
 *  跳过
 */
@property (nonatomic, assign) BOOL showSkip;

/**
 * 完成后的代码块
 */
@property (nonatomic, strong) GuideCompletion completionBlock;

@end
