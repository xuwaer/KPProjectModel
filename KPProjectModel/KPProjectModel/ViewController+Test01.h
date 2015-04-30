//
//  ViewController+Test01.h
//  KPProjectModel
//
//  Created by yiqijiao_xukaijun on 15/4/30.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (Test01)

/**
 *  测试二维码控件
 *
 *  @param superView
 */
- (void)testScan:(UIView *)superView;

/**
 *  测试评分控件
 *
 *  @param superView
 */
- (void)testStarView:(UIView *)superView;

/**
 *  测试弹出提示框
 */
- (void)testCustomerAlert;

@end
