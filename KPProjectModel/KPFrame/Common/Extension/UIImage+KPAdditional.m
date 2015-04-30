//
//  UIImage+KPAdditional.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/5.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "UIImage+KPAdditional.h"

@implementation UIImage (KPAdditional)




#pragma mark - 图片压缩

- (UIImage *)zipImageInMaxWidth:(CGFloat)maxWidth
{
    if (self.size.width <= maxWidth) {
        return self;
    }
    
    UIImage *newImage = [UIImage imageWithCGImage:self.CGImage];
    // 缩放图片
    CGFloat zoomScale = newImage.size.height / newImage.size.width;
    CGAffineTransform  transform=CGAffineTransformIdentity;
    transform=CGAffineTransformRotate(transform, M_PI_2);
    UIGraphicsBeginImageContext(CGSizeMake(maxWidth, maxWidth * zoomScale));
    [newImage drawInRect:CGRectMake(0, 0, maxWidth, maxWidth * zoomScale)];
    CGContextConcatCTM(UIGraphicsGetCurrentContext(), transform);
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)zipImageInMaxSize:(long long)maxSize
{
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    if (data.length <= maxSize) {
        return self;
    }
    
    // 压缩质量
    data = UIImageJPEGRepresentation(self, (double)maxSize / (double)data.length);
    UIImage *newImage = [UIImage imageWithData:data scale:(double)maxSize / (double)data.length];
    
    return  newImage;
}

@end
