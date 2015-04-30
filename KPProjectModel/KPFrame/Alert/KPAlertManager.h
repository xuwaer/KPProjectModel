//
//  AlertMananger.h
//  AlertDemo
//
//  Created by xukj on 14-1-20.
//  Copyright (c) 2014年 xukj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPAlertViewExt.h"

typedef void (^ CompletionBlock)();

@interface CustomerAlertView : UIView

-(id)initWithWindow:(UIWindow *)window;
-(void)showAnimate;
-(void)hideAnimate;
-(void)show:(BOOL)animated;
-(void)hide:(BOOL)animated;

@end

/**
 *	@brief	iOS app提示的管理器，实现toast、progress提示
 *
 */
@interface KPAlertManager : NSObject

// app window
@property (nonatomic, strong) UIWindow *window;

+ (KPAlertManager *)defaultManager;

/**
 *	@brief	类似android toast
 *          1.以下方法不会阻塞UI线程，但是会禁止所有的界面触控操作
 *          2.调用该提示，会移除原来存在的等待提示
 *
 *	@param 	content 	提示内容
 *  @param  during      持续时间，默认为1秒
 *  @param  completionBlock 提示结束后需要执行的代码块
 *  @param  whileEexcutingBlock 在提示期间执行的代码(注意，这里的代码不在主线程中执行)
 */
- (void)showToast:(NSString *)content;
- (void)showToast:(NSString *)content during:(int)during;
- (void)showToast:(NSString *)content during:(int)during completionBlock:(CompletionBlock)completion;
- (void)showToast:(NSString *)content whileExecutingBlock:(dispatch_block_t)executing;
- (void)showToast:(NSString *)content whileExecutingBlock:(dispatch_block_t)executing completionBlock:(CompletionBlock)completion;

/**
 *	@brief	等待提示
 *          1.以下方法不会阻塞UI线程，但是会禁止所有的界面触控操作
 *          2.多次调用startProgress时，仅替换提示内容，而不是关闭提示后再重新初始化一个新的提示
 *
 *	@param 	content 	提示内容
 *  @param
 */
- (void)startProgress:(NSString *)content;
- (void)stopProgress;

/**
 *	@brief	对话框提示
 *          1.目前仅支持，1~2个按钮的提示框
 *          2.支持UIAlertView和其子类。
 *
 *	@param 	title 	标题
 *	@param 	message 	内容
 *	@param 	delegate 	委托回调
 *	@param 	userinfo 	自定义内容
 *	@param 	style       类型
 */
- (void)showAlert:(NSString *)title message:(NSString *)message delegate:(id<UIAlertViewDelegate>)delegate;
- (void)showAlert:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other delegate:(id<UIAlertViewDelegate>)delegate;
- (void)showAlert:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other userinfo:(NSDictionary *)userinfo delegate:(id<UIAlertViewDelegate>)delegate;
- (void)showAlert:(NSString *)title message:(NSString *)message cancel:(NSString *)cancel other:(NSString *)other userinfo:(NSDictionary *)userinfo delegate:(id<UIAlertViewDelegate>)delegate style:(UIAlertViewStyle)style;

/**
 *  弹出自定义View。当触控到透明区域，则自动隐藏.
 *
 *  @param customerView 自定义view
 */
- (void)showCustomerView:(UIView *)customerView;

@end
