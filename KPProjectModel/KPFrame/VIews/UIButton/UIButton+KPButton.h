//
//  UIButton+KPButton.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/4.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (KPButton)

/**
 *  设置按钮边框
 *
 *  @param width
 *  @param color
 *  @param radius
 */
- (void)setBorderWidth:(CGFloat)width color:(CGColorRef)color cornerRadius:(CGFloat)radius;

@end
