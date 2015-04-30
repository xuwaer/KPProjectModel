//
//  KPPopView.m
//  Wedding
//
//  Created by 徐恺君 on 15/3/16.
//  Copyright (c) 2015年 7jj. All rights reserved.
//

#import "KPPopView.h"

NSString * const fadeAnimationKey = @"fadeAnimaionKey";
NSString * const bounceAnimationKey = @"bounceAnimationKey";

@interface KPPopView ()
{
    CGRect contentBounds;
}

@property (nonatomic, strong) UIWindow *popViewWindow;

@end

@implementation KPPopView

+ (instancetype)popViewWithCustomerView:(UIView *)content
{
    KPPopView *view = [[KPPopView alloc] init];
    view.contentView = content;
    view.style = KPPopViewStyle_Default;
    
    return view;
}

- (void)setContentView:(UIView *)content
{
    if (_contentView) {
        [_contentView removeFromSuperview];
    }
    
    _contentView = content;
    contentBounds = _contentView.bounds;
    _contentView.layer.cornerRadius = 5;
    _contentView.layer.masksToBounds = YES;
    _contentView.clipsToBounds = YES;
    
    [self addSubview:_contentView];
}

#pragma mark - 界面

- (void)adjustWindow
{
    if (!_popViewWindow) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        window.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        window.opaque = NO;
        window.windowLevel = UIWindowLevelAlert;
        _popViewWindow = window;
    }
    [_popViewWindow makeKeyAndVisible];
    
    self.bounds = [UIScreen mainScreen].bounds;
    
    if (_contentView) {
        _contentView.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
        _contentView.bounds = contentBounds;
    }
    
    self.center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
}

#pragma mark - 动画

- (void)setAnimation
{
    if (_contentView == nil) {
        return;
    }
    
    switch (_style) {
        case KPPopViewStyle_Bounce:
            [self setAnimationBounce];
            break;
        case KPPopViewStyle_Default:
            [self setAnimationFade];
        default:
            break;
    }
}

/**
 *  渐隐动画
 */
- (void)setAnimationFade
{
    
}

/**
 *  弹出动画
 */
- (void)setAnimationBounce
{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [self.contentView.layer addAnimation:animation forKey:bounceAnimationKey];
}

/**
 *  背景动画
 */
- (void)setBackgroundAnimation
{
    self.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    }];
}

/**
 *  触控非展示部分，隐藏view
 *
 *  @param point
 *  @param event
 *
 *  @return
 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    CGPoint p = [_contentView convertPoint:point fromView:self];
    BOOL isInSideContent = [_contentView pointInside:p withEvent:event];
    
    if (isInSideContent) {
        [_popViewWindow endEditing:YES];
        return [_contentView hitTest:p withEvent:event];
    }
    else {
        [self hide];
        return nil;
    }
}

#pragma mark - 显示、隐藏

- (void)show
{
    [self adjustWindow];
    [self setAnimation];
    [self setBackgroundAnimation];
    
    [_popViewWindow addSubview:self];
}

- (void)hide
{
    [self removeFromSuperview];
    _popViewWindow = nil;
}

- (void)dealloc
{

}

@end
