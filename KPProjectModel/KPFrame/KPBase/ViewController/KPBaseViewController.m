//
//  KPBaseViewController.m
//  KPProjectModel
//
//  Created by xukj on 15-3-8.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPBaseViewController.h"

NSUInteger const KPCoverPageTag         = 0x10000;      // 覆盖页view tag
NSUInteger const KPCoverPageLabelTag    = 0x10001;      // 覆盖页标题 tag
NSUInteger const KPCoverPageCustomerTag = 0x10002;      // 覆盖页自定义 tag

typedef void(^OnTouchBlock)(void);


@interface KPBaseViewController ()
{
    UITapGestureRecognizer *tapGesture;
}

@end

@implementation KPBaseViewController




#pragma mark - 生命周期相关




- (instancetype)initFromStoryboard:(NSString *)storyboard identifier:(NSString *)identifier bundle:(NSBundle *)bundle
{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:storyboard bundle:bundle];
    return [sb instantiateViewControllerWithIdentifier:identifier];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 导航栏适配iOS7
    [self adjustIOS7];
    // 设置状态栏文字
    [self setStatusBarStyle:UIStatusBarStyleLightContent];
    // 设置导航栏背景
    [self setNavigationBackground];
    // 设置导航栏标题文字
    [self setNavigationTitleAttribute:[self navigationTitleStyle]];
    // 使用导航栏按钮
    [self setNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 更改导航栏按钮
    [self changeNavigationItem];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}




#pragma mark - 导航栏相关




- (NSDictionary *)navigationTitleStyle
{
    // 子类如需修改，请重写
    return @{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]};
}

- (UIColor *)navigationBackgroundColor
{
    // 子类如需修改，请重写
    return nil;
}

- (UIImage *)navigationBackgroundImage
{
    // 子类如需修改，请重写
    return nil;
}

- (void)changeNavigationItem
{
    // 子类如需修改，请重写
}

- (UIBarButtonItem *)navigationLeftPopItem
{
    // 子类如需修改，请重写
    return [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(pop)];
}

- (UIBarButtonItem *)navigationLeftDismissItem
{
    // 子类如需修改，请重写
    return [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}

- (UIBarButtonItem *)navigationLeftCustomerItem
{
    // 子类如需修改，请重写
    return nil;
}

- (NSArray *)navigationRightCustomerItems
{
    // 子类如需修改，请重写
    return nil;
}

/**
 *  私有方法，设置导航栏背景
 */
- (void)setNavigationBackground
{
    [self setNavigationBackgroundColor:[self navigationBackgroundColor]];
    [self setNavigationBackgroundImage:[self navigationBackgroundImage]];
}

/**
 *  私有方法，设置导航栏按钮
 */
- (void)setNavigationItem
{
    // 左方按钮
    UIBarButtonItem *leftItem = nil;
    switch (self.useLeftItem) {
        case KPNavigationLeftItem_Pop:
            leftItem = [self navigationLeftPopItem];
            break;
        case KPNavigationLeftItem_Dismiss:
            leftItem = [self navigationLeftDismissItem];
            break;
        case KPNavigationLeftItem_Customer:
            leftItem = [self navigationLeftCustomerItem];
            break;
        case KPNavigationLeftItem_None:
            break;
        default:
            break;
    }
    [self setNavigationLeftItem:leftItem];
    
    // 右方按钮
    [self setNavigationRightItems:[self navigationRightCustomerItems]];
}




#pragma mark - 覆盖页



- (void)showCoverPageWithTitle:(NSString *)title
{
    UIView *coverPage = [self createCoverPage];
    
    UILabel *label = (UILabel *)[coverPage viewWithTag:KPCoverPageLabelTag];
    if (label == nil) {
        label = [[UILabel alloc] initWithFrame:Rect(0, 0, ScreenWidth, 40)];
        label.font = [UIFont systemFontOfSize:18];
        label.textColor = [UIColor blackColor];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.center = Point(ScreenWidth / 2, RectHeight(coverPage.bounds) / 2 - 64);
        [coverPage addSubview:label];
    }
    
    label.text = title;
    
    [self.view bringSubviewToFront:coverPage];
}

- (void)showCoverPageWithCustomerView:(UIView *)view
{
    UIView *coverPage = [self createCoverPage];
    
    UILabel *label = (UILabel *)[coverPage viewWithTag:KPCoverPageLabelTag];
    if (label) {
        [label removeFromSuperview];
    }
    
    UIView *customerView = [coverPage viewWithTag:KPCoverPageCustomerTag];
    if (customerView) {
        [customerView removeFromSuperview];
    }
    
    customerView = view;
    customerView.tag = KPCoverPageCustomerTag;
    customerView.center = Point(RectWidth(coverPage.bounds) / 2, RectHeight(coverPage.bounds) / 2 - 64);
    [coverPage addSubview:customerView];
    
    [self.view bringSubviewToFront:coverPage];
}

- (void)hideCoverPage
{
    UIView *coverPage = [self.view viewWithTag:KPCoverPageTag];
    if (coverPage) {
        [coverPage removeFromSuperview];
    }
}

- (void)onTapedCoverPage:(UITapGestureRecognizer *)recognizer
{
    // 子类重写
}

/**
 *  私有方法，创建覆盖页
 *
 *  @return
 */
- (UIView *)createCoverPage
{
    UIView *coverPage = [self.view viewWithTag:KPCoverPageTag];
    if (coverPage == nil) {
        coverPage = [[UIView alloc] initWithFrame:Rect(0, 64, ScreenWidth, ScreenHeight - 64)];
        coverPage.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapedCoverPage:)];
        gesture.numberOfTapsRequired = 1;
        [coverPage addGestureRecognizer:gesture];
        [self.view addSubview:coverPage];
    }
    
    return coverPage;
}


@end
