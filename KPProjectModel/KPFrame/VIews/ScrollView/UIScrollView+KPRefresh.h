//
//  UIScrollView+KPRefresh.h
//  KPProjectModel
//
//  Created by xukj on 15/3/24.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (KPRefresh)

/**
 *  设置下拉刷新，上滑更多
 *
 *  @param newBlock     下拉刷新时调用的block
 *  @param dateKey      下拉刷新时间保存的key值(用于对应不同的下拉刷新控件触发的时间)
 *  @param moreBlock    上滑更多时调用的block
 */
- (void)addRefreshNewBlock:(void(^)(void))newBlock refreshMoreBlock:(void(^)(void))moreBlock;
- (void)addRefreshNewBlock:(void(^)(void))newBlock dateKey:(NSString *)dateKey refreshMoreBlock:(void(^)(void))moreBlock;

/**
 *  设置下拉刷新、上滑更多
 *
 *  @param selectorNew      下拉刷新时调用的方法
 *  @param selectorMore     上滑更多时调用的方法
 */

/**
 *  设置下拉刷新、上滑更多
 *
 *  @param selectorNew      下拉刷新时调用的方法
 *  @param selectorMore     上滑更多时调用的方法
 *  @param selectorMore     下拉刷新时间保存的key值
 */
- (void)addRefreshTarget:(id)target refreshNew:(SEL)selectorNew refreshMore:(SEL)selectorMore;
- (void)addRefreshTarget:(id)target refreshNew:(SEL)selectorNew dateKey:(NSString *)dateKey refreshMore:(SEL)selectorMore;

/**
 *  手动启动刷新
 */
- (void)beginRefreshNew;
- (void)beginRefreshMore;

/**
 *  手动关闭刷新
 */
- (void)endRefresh;

#pragma mark - 内容

/**
 *  下拉刷新时的文字。如需更改，重写该方法
 */
- (NSString *)headerIdleText;
- (NSString *)headerPullingText;
- (NSString *)headerRefreshingText;

/**
 *  上滑更多时的文字。如需更改，重写该方法
 */
- (NSString *)footerIdleText;
- (NSString *)footerRefreshingText;
- (NSString *)footerNoDataText;

@end
