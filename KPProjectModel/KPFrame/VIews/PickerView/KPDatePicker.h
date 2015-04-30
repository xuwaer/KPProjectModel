//
//  SQDatePicker.h
//  ZhuangXiuShenQi
//
//  Created by test on 15/2/13.
//  Copyright (c) 2015年 LiYongyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KPDatePickerDelegate;

@interface KPDatePicker : UIView

@property (nonatomic, strong) id<KPDatePickerDelegate>delegate;

/**
 *  时间显示模式
 */
@property (nonatomic, assign) UIDatePickerMode mode;

/**
 * 请使用该方法创建选择器
 */
- (instancetype)initWithDate:(NSDate *)date delegate:(id<KPDatePickerDelegate>)delegate;

/**
 * 显示
 */
- (void)show;

/**
 *  隐藏
 */
- (void)dismiss;

@end

// 选择委托
@protocol KPDatePickerDelegate <NSObject>

@optional;
- (void)datePicker:(KPDatePicker *)datePicker didSelectDate:(NSDate *)date;
- (void)datePickerDidCancel:(KPDatePicker *)datePicker;

@end