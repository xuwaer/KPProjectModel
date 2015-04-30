//
//  KPBaseViewController.h
//  KPProjectModel
//
//  ViewController父类，根据不同项目可作不同的调整。
//  注意：如果子类调用了生命周期中的方法，则必须首先调用父类对应的生命周期方法
//
//  基本功能：
//  1.提供storyboard初始化方法
//  2.设置导航栏颜色或图片
//  3.导航栏适配iOS7
//  4.设置导航栏按钮
//
//  Created by xukj on 15-3-8.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航栏左边按钮功能。如需要设置样式，请重写方法
 *  - (UIBarButtonItem *)navigationLeftPopItem;
 *  - (UIBarButtonItem *)navigationLeftDismissItem;
 *  - (UIBarButtonItem *)navigationLeftCustomerItem;
 */
typedef NS_ENUM(NSUInteger, KPNavigationLeftItem){
    /**
     *  无左边item
     */
    KPNavigationLeftItem_None = 0,
    /**
     *  返回按钮
     */
    KPNavigationLeftItem_Pop,
    /**
     *  关闭按钮
     */
    KPNavigationLeftItem_Dismiss,
    /**
     *  用户自定义
     */
    KPNavigationLeftItem_Customer
};




@interface KPBaseViewController : UIViewController




#pragma mark - 初始化




/**
 *  如果该ViewController是通过Storyboard创建的。请使用该方法初始化ViewController
 *
 *
 *  @param storyboard   storyboard名称
 *  @param identifier   viewController名称
 *  @param bundle       stoaryboard所在bundle。(MainBundle请传nil)
 *
 *  @return
 */
- (instancetype)initFromStoryboard:(NSString *)storyboard identifier:(NSString *)identifier bundle:(NSBundle *)bundle;




#pragma mark - 导航栏相关




/**
 *  导航栏标题样式。如果需要请重写该方法
 *  默认为黑色，18size
 *
 *  @return
 */
- (NSDictionary *)navigationTitleStyle;

/**
 *  导航栏背景图片或颜色。如果需要请重写该方法
 *  优先使用背景图片
 *
 *  @param image
 *
 *  @return
 */
- (UIImage *)navigationBackgroundImage;
- (UIColor *)navigationBackgroundColor;

/**
 *  导航栏左方按钮样式
 */
@property (nonatomic, assign) KPNavigationLeftItem useLeftItem;

/**
 *  更改导航栏按钮。(每当该ViewController显示时调用)
 *  注:
 *  1.如果无特殊需求，请勿重写该方法
 *  2.如果需要重写该方法，请判断useLeftItem并调用以下方法，以保证左方按钮功能的完整
 *      - (UIBarButtonItem *)navigationLeftPopItem;
 *      - (UIBarButtonItem *)navigationLeftDismissItem;
 *      - (UIBarButtonItem *)navigationLeftCustomerItem;
 *
 */
- (void)changeNavigationItem;

/**
 *  导航栏左方pop按钮样式。如果有修改，请重写该方法。否则生成默认pop按钮
 *  该按钮功能仅对push后的ViewController有效
 *
 *  @return
 */
- (UIBarButtonItem *)navigationLeftPopItem;

/**
 *  导航栏左方dismiss按钮样式。如果有修改，请重写该方法。否则生成默认dismiss按钮
 *  该按钮功能仅对present后的ViewController有效
 *
 *  @return
 */
- (UIBarButtonItem *)navigationLeftDismissItem;

/**
 *  导航栏左方用户自定义按钮。如果需要，请重写该方法。否则不生成按钮
 *
 *  @return
 */
- (UIBarButtonItem *)navigationLeftCustomerItem;

/**
 *  设置导航栏右方按钮。如果需要，请重写该方法。否则不生成按钮
 *
 *  @return 
 */
- (NSArray *)navigationRightCustomerItems;




#pragma mark - 数据覆盖页

/**
 *  提高用户体验的覆盖页，一般在请求网络展示数据时使用。（非强制使用）
 */

/**
 *  显示覆盖页
 *
 *  @param  title    文本
 *  @param  view     用户自定义view。该view会替换掉coverPage中已存在的customerView
 */
- (void)showCoverPageWithTitle:(NSString *)title;
- (void)showCoverPageWithCustomerView:(UIView *)view;

/**
 *  隐藏覆盖页
 */
- (void)hideCoverPage;

/**
 *  当覆盖页被点击时调用,如果需要请重写该方法。
 *
 *  @param coverPage
 */
- (void)onTapedCoverPage:(UITapGestureRecognizer *)recognizer;

@end
