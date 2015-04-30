//
//  UITableViewCell+Border.h
//  EEWClient
//
//  Created by xukj on 15-2-8.
//  Copyright (c) 2015年 yangcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Border)

/**
 *  添加边框
 *
 *  @param top    是否使用上边框
 *  @param left   是否使用左边框
 *  @param right  是否使用右边框
 *  @param bottom 是否使用下边框
 *  @param color  边框颜色
 *  @param width  边框宽度
 *  @param edgeInsets  边框间距
 */
- (void)addBorderTop:(BOOL)top
                left:(BOOL)left
               right:(BOOL)right
              bottom:(BOOL)bottom
               color:(UIColor *)color
               width:(CGFloat)width
          edgeInsets:(UIEdgeInsets)edgeInsets;

/**
 *  设置边框
 *
 *  @param width
 *  @param color
 *  @param radius
 */
- (void)setBorderWidth:(CGFloat)width color:(CGColorRef)color cornerRadius:(CGFloat)radius;

@end
