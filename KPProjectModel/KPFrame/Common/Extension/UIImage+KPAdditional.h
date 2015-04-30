//
//  UIImage+KPAdditional.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/5.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KPAdditional)




#pragma mark - 图片压缩

/**
 *  图片压缩。如果图片超出指定宽度，则执行
 *
 *  @param maxWidth 图片宽度限制
 *
 *  @return 压缩后的图片
 */
- (UIImage *)zipImageInMaxWidth:(CGFloat)maxWidth;

/**
 *  图片压缩。如果图片文件超出指定大小则执行
 *
 *  @param maxSize  文件大小限制(字节)
 *
 *  @return 压缩后的图片
 */
- (UIImage *)zipImageInMaxSize:(long long)maxSize;

@end
