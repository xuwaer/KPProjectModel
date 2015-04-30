//
//  AdView.h
//  广告view
//
//  Created by 徐恺君 on 15/3/10.
//  Copyright (c) 2015年 7jj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdView;

@protocol AdViewDelegate <NSObject>

@optional;
/**
 *  广告位点击委托
 *
 *  @param adView
 *  @param index
 */
- (void)adView:(AdView *)adView didSelectedIndex:(NSUInteger)index;

@end

/**
 *  广告位控件（scrollView + pageControl）
 */
@interface AdView : UIView

/**
 *  委托
 */
@property (nonatomic, assign) id<AdViewDelegate>delegate;

/**
 *  当前显示广告的index
 */
@property (nonatomic, assign) NSUInteger index;

/**
 *  总广告数量
 */
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 *  添加广告
 *
 *  @param ads view数组
 */
- (void)addAds:(NSArray *)ads;

/**
 *  启动自动滚动
 *
 *  @param time 间隔时间
 */
- (void)startAutoScrollWithTime:(NSTimeInterval)time;

/**
 *  关闭自动滚动
 */
- (void)stopAutoScroll;

/**
 *  设置pageControl颜色
 *
 *  @param currentColor 选中颜色（默认红色）
 *  @param tintColor    未选中颜色（默认白色）
 */
- (void)setCurrentPageColor:(UIColor *)currentColor tintColor:(UIColor *)tintColor;

@end
