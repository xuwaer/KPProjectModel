//
//  ScoreView.m
//  EnjoyFishing
//
//  Created by 白松灵 on 14-4-11.
//  Copyright (c) 2014年 enjoyfishing. All rights reserved.
//

#import "KPStarView.h"

NSUInteger const defaultNumberOfStar = 5;
CGFloat const defaultMinScore = 0;
CGFloat const defaultMaxScore = 5;

@interface KPStarView (){
    CGFloat _padding;
    CGFloat _halfScore;
    UIImage *_halfImage;
    UITapGestureRecognizer *tapGesture;
    UIPanGestureRecognizer *panGesture;
}

@end

@implementation KPStarView

- (instancetype)initWithFrame:(CGRect)frame
                 defaultImage:(UIImage *)defaultImage
               highlightImage:(UIImage *)highlightImage
                 numberOfStar:(NSUInteger)numberOfStar
                      padding:(CGFloat)padding
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _defaultImage = defaultImage;
        _hightlightImage = highlightImage;
        [self createHalfImage];
        _numberOfStar = numberOfStar == 0 ? defaultNumberOfStar : numberOfStar;
        _padding = padding;
        _halfScore = (_maxScore - _minScore) / _numberOfStar * 2;
        
        self.minScore = defaultMinScore;
        self.maxScore = defaultMaxScore;
        
        [self initView];
    }
    return self;
}

-(void)initView
{
    // 计算每个五角星size
    CGSize starSize = _defaultImage.size;
    for (int i = 0; i < _numberOfStar; i++) {
        
        UIImageView *star = [[UIImageView alloc] init];
        star.frame = Rect(i * (starSize.width + _padding), (RectHeight(self.bounds) - starSize.height) / 2.0, starSize.width, starSize.height);
        star.tag = i;
        star.image = _defaultImage;
        [self addSubview:star];
        
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTouch:)];
        tapGesture.numberOfTapsRequired = 1;
        star.userInteractionEnabled = YES;
        [star addGestureRecognizer:tapGesture];
    }
    
    panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:panGesture];
}

- (void)handleTouch:(UIGestureRecognizer *)gesture
{
    UIImageView *touchView = (UIImageView *)gesture.view;
    CGPoint point = [gesture locationInView:touchView];
    
    for (UIImageView *star in self.subviews) {
        
        if (touchView.tag > star.tag) {
            // 整颗星
            _score = (_maxScore - _minScore) / _numberOfStar * (touchView.tag + 1) + _minScore;
            star.image = _hightlightImage;
        }
        else if (touchView.tag == star.tag){
            
            if (point.x < RectWidth(touchView.bounds) / 2.0) {
                // 半颗星
                _score = (_maxScore - _minScore) / _numberOfStar * (touchView.tag + 0.5) + _minScore;
                star.image = _halfImage;
            }
            else {
                // 整颗星
                _score = (_maxScore - _minScore) / _numberOfStar * (touchView.tag + 1) + _minScore;
                star.image = _hightlightImage;
            }
        }
        else {
            // 无星
            star.image = _defaultImage;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(starView:didChangeScore:)]) {
        [self.delegate starView:self didChangeScore:_score];
    }
}

-(void)handlePan:(UIGestureRecognizer *) gesture
{
    CGPoint point=[gesture locationInView:self];
    
    DDLogPoint(point);
    
    for (UIImageView *star in self.subviews) {
        
        if (point.x > RectX(star.frame) && point.x < RectX(star.frame) + RectWidth(star.frame) / 2.0) {
            // 半颗星
            _score = (_maxScore - _minScore) / _numberOfStar * (star.tag + 0.5) + _minScore;
            star.image = _halfImage;
        }
        else if (point.x > RectX(star.frame) + RectWidth(star.frame) / 2.0){
            // 整颗星
            _score = (_maxScore - _minScore) / _numberOfStar * (star.tag + 1) + _minScore;
            star.image = _hightlightImage;
        }
        else {
            // 无星
            star.image = _defaultImage;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(starView:didChangeScore:)]) {
        [self.delegate starView:self didChangeScore:_score];
    }
}

- (void)createHalfImage
{
    // 半颗选中
    CGRect newFrame = Rect(0, 0, _hightlightImage.size.width * _hightlightImage.scale / 2.0, _hightlightImage.size.height * _hightlightImage.scale);
    CGImageRef resultImage = CGImageCreateWithImageInRect([_hightlightImage CGImage], newFrame);
    UIImage *_halfHighlight = [UIImage imageWithCGImage:resultImage scale:_hightlightImage.scale orientation:_hightlightImage.imageOrientation];
    CGImageRelease(resultImage);
    
    // 半颗星
    UIGraphicsBeginImageContext(_defaultImage.size);
    [_defaultImage drawInRect:CGRectMake(0, 0, _defaultImage.size.width, _defaultImage.size.height)];
    [_halfHighlight drawInRect:CGRectMake(0, 0, _halfHighlight.size.width, _halfHighlight.size.height)];
    _halfImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)dealloc
{
    [self removeGestureRecognizer:tapGesture];
    [self removeGestureRecognizer:panGesture];
}

@end
