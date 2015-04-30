//
//  UIViewController+KPAdditional.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/3.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "UIViewController+KPAdditional.h"

@implementation UIViewController (KPAdditional)





#pragma mark - 适配

- (void)adjustIOS7
{
    // 适配iOS7
    if (IOS7_OR_LATER) {
        self.automaticallyAdjustsScrollViewInsets = NO;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
        
        // 设置内容页不被导航栏覆盖
        self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    }
}






#pragma mark - 样式

- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle];
}

- (void)setNavigationTitleAttribute:(NSDictionary *)attribute
{
    self.navigationController.navigationBar.titleTextAttributes = attribute;
}

- (void)setNavigationBackgroundImage:(UIImage *)backgroundImage
{
    // 禁止导航栏透明
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
}

- (void)setNavigationBackgroundColor:(UIColor *)color
{
    // 禁止导航栏透明
    self.navigationController.navigationBar.translucent = NO;

    if (IOS7_OR_LATER)
        [self.navigationController.navigationBar setBarTintColor:color];
    else
        [self.navigationController.navigationBar setTintColor:color];
}

- (void)setNavigationLeftItem:(UIBarButtonItem *)item
{
    if (item == nil) {
        return;
    }
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (IOS7_OR_LATER)
        negativeSpacer.width = 5;
    
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, item];
}

- (void)setNavigationBackItem:(UIBarButtonItem *)item
{
    if (item == nil) {
        return;
    }

    self.navigationItem.backBarButtonItem = item;
}

- (void)setNavigationRightItem:(UIBarButtonItem *)item
{
    if (item == nil) {
        return;
    }
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if (IOS7_OR_LATER)
        negativeSpacer.width = 5;
    
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, item];
}

- (void)setNavigationRightItems:(NSArray *)items
{
    self.navigationItem.rightBarButtonItems = items;
}

- (void)setTransparentNavigation
{
    // 设置导航栏透明
    self.navigationController.navigationBar.translucent = YES;
    
    // 去掉系统默认导航栏样式
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    
    // 设置内容页全屏
    self.edgesForExtendedLayout = UIRectEdgeAll;
}




#pragma mark - 页面跳转

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)dismissBlock:(void (^)(void))block
{
    [self dismissViewControllerAnimated:YES completion:block];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToViewControllerClass:(Class)targetClass
{
    if (targetClass == NULL || targetClass == nil) {
        [self pop];
        return;
    }
    
    NSArray *controllers = self.navigationController.viewControllers;
    
    if (!ArrayNotEmpty(controllers)) {
        [self pop];
        return;
    }
    
    for (UIViewController *controller in controllers) {
        
        if ([controller isKindOfClass:targetClass]) {
            [self.navigationController popToViewController:controller animated:YES];
            break;
        }
    }
}

- (void)popToViewControllerObject:(UIViewController *)targetController
{
    if (targetController == nil) {
        [self pop];
        return;
    }
    
    [self.navigationController popToViewControllerObject:targetController];
}

@end
