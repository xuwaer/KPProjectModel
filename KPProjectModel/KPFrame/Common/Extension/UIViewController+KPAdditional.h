//
//  UIViewController+KPAdditional.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/3.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (KPAdditional)




#pragma mark - 适配

/**
 *  iOS7适配，以防止navigationBar阻挡view
 */
- (void)adjustIOS7;



#pragma mark - 样式


/**
 *  设置状态栏样式
 *
 *  @param statusBarStyle
 */
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle;

/**
 *  设置导航栏标题样式
 *
 *  @param attribute
 */
- (void)setNavigationTitleAttribute:(NSDictionary *)attribute;

/**
 *  设置导航栏背景图
 *
 *  @param backgroundImage
 */
- (void)setNavigationBackgroundImage:(UIImage *)backgroundImage;

/**
 *  设置导航栏背景颜色
 *
 *  @param color 
 */
- (void)setNavigationBackgroundColor:(UIColor *)color;

/**
 *  设置透明的导航栏
 */
- (void)setTransparentNavigation;



#pragma mark - 导航栏按钮

/**
 *  设置导航栏左边按钮
 *
 *  @param item
 */
- (void)setNavigationLeftItem:(UIBarButtonItem *)item;

/**
 *  设置导航栏左边返回按钮
 *
 *  @param item 
 */
- (void)setNavigationBackItem:(UIBarButtonItem *)item;

/**
 *  设置导航栏右边按钮
 *
 *  @param item
 */
- (void)setNavigationRightItem:(UIBarButtonItem *)item;

/**
 *  设置导航栏右边多个按钮
 *
 *  @param items
 */
- (void)setNavigationRightItems:(NSArray *)items;



#pragma mark - transform

/**
 *  返回功能
 */
- (void)pop;
- (void)popToViewControllerClass:(Class)targetClass;
- (void)popToViewControllerObject:(UIViewController *)targetController;

/**
 *  退出功能
 */
- (void)dismiss;
- (void)dismissBlock:(void (^)(void))block;

@end
