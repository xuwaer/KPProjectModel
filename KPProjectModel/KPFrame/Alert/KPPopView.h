//
//  KPPopView.h
//  弹出界面View
//
//  Created by 徐恺君 on 15/3/16.
//  Copyright (c) 2015年 7jj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KPPopViewStyle) {
    KPPopViewStyle_Default = 0,
    KPPopViewStyle_Bounce = 1
};

/**
 *  弹出View。该View会作为最上级，覆盖掉所有界面控件，包括AlertView和StatusBar
 *  当点击View外部半透明区域，会隐藏该view并恢复其他的界面操作
 */
@interface KPPopView : UIView

/**
 *  view加载动画样式
 */
@property (nonatomic, assign) KPPopViewStyle style;

/**
 *  内容view
 */
@property (nonatomic, strong) UIView *contentView;

/**
 *  popview初始化
 *
 *  @param content
 *
 *  @return
 */
+ (instancetype)popViewWithCustomerView:(UIView *)content;

/**
 *  显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)hide;

@end
