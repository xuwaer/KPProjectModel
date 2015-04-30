//
//  UITableViewCell+Border.m
//  EEWClient
//
//  Created by xukj on 15-2-8.
//  Copyright (c) 2015年 yangcz. All rights reserved.
//

#import "UIView+Border.h"

@interface UIView ()
{
    CALayer *topLayer, *leftLayer, *rightLayer, *bottomLayer;
}

@end

@implementation UIView (Border)

- (void)addBorderTop:(BOOL)top left:(BOOL)left right:(BOOL)right bottom:(BOOL)bottom color:(UIColor *)color width:(CGFloat)width frame:(CGRect)frame
{
    if (top) {
        CALayer *layer = [CALayer layer];
        CGRect rect = CGRectMake(frame.origin.x, 0, frame.size.width, width);
        layer.frame = rect;
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    
    if (left) {
        CALayer *layer = [CALayer layer];
        CGRect rect = CGRectMake(0, frame.origin.y, width, frame.size.height);
        layer.frame = rect;
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    
    if (right) {
        CALayer *layer = [CALayer layer];
        CGRect rect = CGRectMake(frame.size.width, frame.origin.y, width, frame.size.height);
        layer.frame = rect;
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    
    if (bottom) {
        CALayer *layer = [CALayer layer];
        CGRect rect = CGRectMake(frame.origin.x, frame.size.height, frame.size.width, width);
        layer.frame = rect;
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

- (void)addBorderTop:(BOOL)top left:(BOOL)left right:(BOOL)right bottom:(BOOL)bottom color:(UIColor *)color width:(CGFloat)width edgeInsets:(UIEdgeInsets)edgeInsets
{
    if (top) {
        CALayer *layer = [CALayer layer];
        CGRect rect = UIEdgeInsetsInsetRect(self.bounds, edgeInsets);
        rect.size.height = width;
        layer.frame = rect;
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    
    if (left) {
        CALayer *layer = [CALayer layer];
        CGRect rect = UIEdgeInsetsInsetRect(self.bounds, edgeInsets);
        rect.size.width = width;
        layer.frame = rect;
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    
    if (right) {
        CALayer *layer = [CALayer layer];
        CGRect rect = UIEdgeInsetsInsetRect(self.bounds, edgeInsets);
        rect.origin.x = rect.origin.x + rect.size.width;
        rect.size.width = width;
        layer.frame = rect;
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
    
    if (bottom) {
        CALayer *layer = [CALayer layer];
        CGRect rect = UIEdgeInsetsInsetRect(self.bounds, edgeInsets);
        rect.origin.y = rect.origin.y + rect.size.height;
        rect.size.height = width;
        layer.frame = rect;
        layer.backgroundColor = color.CGColor;
        [self.layer addSublayer:layer];
    }
}

- (void)setBorderWidth:(CGFloat)width color:(CGColorRef)color cornerRadius:(CGFloat)radius
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color;
    self.layer.cornerRadius = radius;
    
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

@end
