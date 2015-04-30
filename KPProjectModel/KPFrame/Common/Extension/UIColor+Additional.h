//
//  UIColor+Hex.h
//  SheJiShi
//
//  Created by chen zheng on 12/11/14.
//  Copyright (c) 2014 LiYongyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additional)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
