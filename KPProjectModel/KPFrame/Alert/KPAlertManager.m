//
//  AlertMananger.m
//  AlertDemo
//
//  Created by xukj on 14-1-20.
//  Copyright (c) 2014年 xukj. All rights reserved.
//

#import "KPAlertManager.h"
#import "MBProgressHUD.h"

static KPAlertManager *mananger = nil;

@interface KPAlertManager ()

// 等待提示
@property (nonatomic, strong) MBProgressHUD *progress;

@end

@implementation KPAlertManager

+(KPAlertManager *)defaultManager
{
    if (mananger == nil) {
        mananger = [[KPAlertManager alloc] init];
    }
    
    return mananger;
}




#pragma mark - toast 方法




-(void)showToast:(NSString *)content
{
    [self showToast:content during:1];
}

-(void)showToast:(NSString *)content during:(int)during
{
    [self showToast:content during:during completionBlock:NULL];
}

-(void)showToast:(NSString *)content during:(int)during completionBlock:(CompletionBlock)completion
{
    dispatch_block_t executingBlock = ^{
        sleep(during);
    };
    
    [self showToast:content whileExecutingBlock:executingBlock completionBlock:completion];
}

-(void)showToast:(NSString *)content whileExecutingBlock:(dispatch_block_t)executing
{
    [self showToast:content whileExecutingBlock:executing completionBlock:NULL];
}

-(void)showToast:(NSString *)content whileExecutingBlock:(dispatch_block_t)executing completionBlock:(CompletionBlock)completion
{
    if (self.window == nil) {
        return;
    }
    
    // 如果存在等待提示，则首先移除
    [self stopProgress];
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:self.window];
    
    hud.detailsLabelText = content;
    hud.mode = MBProgressHUDModeText;
    [self.window addSubview:hud];
    
    [hud showAnimated:YES whileExecutingBlock:executing completionBlock:^{
        [hud removeFromSuperview];
        
        if (completion != NULL) {
            completion();
        }
    }];
}




#pragma mark - progress 方法




-(void)setProgressContent:(NSString *)content
{
    if (self.progress) {
        self.progress.detailsLabelText = content;
    }
}

-(void)startProgress:(NSString *)content
{
    if (self.window == nil)
        return;
    
    if (self.progress) {
        [self setProgressContent:content];
        return;
    }
    
    self.progress = [[MBProgressHUD alloc] initWithWindow:self.window];
    
    self.progress.detailsLabelText = content;
    self.progress.mode = MBProgressHUDModeIndeterminate;
    [self.window addSubview:self.progress];
    [self.progress show:YES];
}

-(void)stopProgress
{
    if (self.progress) {
        [self.progress removeFromSuperview];
    }
    self.progress = nil;
}




#pragma mark - alert 方法




-(void)showAlert:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate
{
    KPAlertViewExt *alert = nil;
    
    // 使用系统默认AlertView
    alert = [[KPAlertViewExt alloc] initWithTitle:title
                                                                 message:message
                                                                delegate:delegate
                                                       cancelButtonTitle:@"取消"
                                                       otherButtonTitles:nil];
    
    [alert show];
}

-(void)showAlert:(NSString *)title
         message:(NSString *)message
          cancel:(NSString *)cancel
           other:(NSString *)other
        delegate:(id<UIAlertViewDelegate>)delegate
{
    [self showAlert:title message:message cancel:cancel other:other userinfo:nil delegate:delegate];
}

-(void)showAlert:(NSString *)title
         message:(NSString *)message
          cancel:(NSString *)cancel
           other:(NSString *)other
        userinfo:(NSDictionary *)userinfo
        delegate:(id<UIAlertViewDelegate>)delegate
{
    KPAlertViewExt *alert = nil;
    
    // 使用系统默认AlertView
    alert = [[KPAlertViewExt alloc] initWithTitle:title
                                           message:message
                                          delegate:delegate
                                 cancelButtonTitle:cancel
                                 otherButtonTitles:other, nil];
    alert.userinfo = userinfo;
    [alert show];
}

- (void)showAlert:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other userinfo:(NSDictionary *)userinfo delegate:(id<UIAlertViewDelegate>)delegate style:(UIAlertViewStyle)style
{
    KPAlertViewExt *alert = nil;
    
    // 使用系统默认AlertView
    alert = [[KPAlertViewExt alloc] initWithTitle:title
                                            message:message
                                           delegate:delegate
                                  cancelButtonTitle:cancel
                                  otherButtonTitles:other, nil];
    alert.userinfo = userinfo;
    
    alert.alertViewStyle = style;
    [alert show];
}



#pragma mark - customer view




- (void)showCustomerView:(UIView *)customerView
{
    if (self.window == nil) {
        return;
    }
    
    if (customerView == nil) {
        return;
    }
    
    // 如果存在等待提示，则首先移除
    [self stopProgress];
    
    KPPopView *popView = [KPPopView popViewWithCustomerView:customerView];
    popView.style = KPPopViewStyle_Bounce;
    [popView show];
}

@end
