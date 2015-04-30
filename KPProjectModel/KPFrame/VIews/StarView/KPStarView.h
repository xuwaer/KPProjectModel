//
//  ScoreView.h
//  EnjoyFishing
//
//  Created by 白松灵 on 14-4-11.
//  Copyright (c) 2014年 enjoyfishing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPStarView;

@protocol KPStarViewDelegate <NSObject>

@optional
- (void)starView:(KPStarView *)starView didChangeScore:(CGFloat)score;

@end


@interface KPStarView : UIView

/**
 *  当前得分
 */
@property (nonatomic, assign) CGFloat score;

/**
 *  最低评分
 */
@property (nonatomic, assign) CGFloat minScore;

/**
 *  最高评分
 */
@property (nonatomic, assign) CGFloat maxScore;

/**
 *  是否可编辑
 */
@property (nonatomic, assign) BOOL isEditable;

/**
 *  星级数量
 */
@property (nonatomic, assign, readonly) NSUInteger numberOfStar;

/**
 *  回调委托
 */
@property (nonatomic, assign) id<KPStarViewDelegate>delegate;

/**
 *  未选中和选中星级图标
 */
@property (nonatomic, strong, readonly) UIImage *defaultImage;
@property (nonatomic, strong, readonly) UIImage *hightlightImage;

/**
 *  初始化星级控件
 *
 *  @param frame
 *  @param defaultImage
 *  @param highlightImage
 *  @param numberOfStar
 *  @param padding                  每个星级间距
 *
 *  @return
 */
- (instancetype)initWithFrame:(CGRect)frame
                 defaultImage:(UIImage *)defaultImage
               highlightImage:(UIImage *)highlightImage
                 numberOfStar:(NSUInteger)numberOfStar
                      padding:(CGFloat)padding;

@end
