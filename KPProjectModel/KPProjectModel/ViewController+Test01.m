//
//  ViewController+Test01.m
//  KPProjectModel
//
//  Created by yiqijiao_xukaijun on 15/4/30.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "ViewController+Test01.h"

@interface ViewController () <KPQRCodeViewDelegate, KPStarViewDelegate>

@end

@implementation ViewController (Test01)


#pragma mark - 测试二维码扫描

-(void)testScan:(UIView *)superView
{
    KPQRCodeView * qrView=[[KPQRCodeView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    qrView.delegate=self;
    [superView addSubview:qrView];
    [qrView startScan];
}

-(void)kpQRCodeView:(KPQRCodeView *)qrView scanFinishedWithValue:(NSString *)qrContent
{
    NSLog(@"%@",qrContent);
}

#pragma mark - 测试评分控件

- (void)testStarView:(UIView *)superView
{
    KPStarView *s = [[KPStarView alloc] initWithFrame:superView.bounds defaultImage:[UIImage imageNamed:@"star"] highlightImage:[UIImage imageNamed:@"star_highlighted"] numberOfStar:5 padding:0];
    s.delegate = self;
    
    [superView addSubview:s];
}


- (void)starView:(KPStarView *)starView didChangeScore:(CGFloat)score
{
    NSLog(@"%.1f", score);
}


#pragma mark - 测试自定义提示view

- (void)testCustomerAlert
{
    UIView *view = [[UIView alloc] initWithFrame:Rect(0, 0, 300, 100)];
    view.backgroundColor = [UIColor blueColor];
    
    [[KPAlertManager defaultManager] showCustomerView:view];
}

@end
