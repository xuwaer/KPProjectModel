//
//  UIButton+KPButton.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/4.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "UIButton+KPButton.h"

@implementation UIButton (KPButton)

- (void)setBorderWidth:(CGFloat)width color:(CGColorRef)color cornerRadius:(CGFloat)radius
{
    self.layer.borderWidth = width;
    self.layer.borderColor = color;
    self.layer.cornerRadius = radius;
    
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
}

@end
