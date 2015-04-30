//
//  SQDatePicker.m
//  ZhuangXiuShenQi
//
//  Created by test on 15/2/13.
//  Copyright (c) 2015年 LiYongyi. All rights reserved.
//

#import "KPDatePicker.h"

@interface KPDatePicker ()

@property (nonatomic, strong) UIDatePicker* datePicker;     //

@property (nonatomic, strong) UIView *containerView;

@end


@implementation KPDatePicker

- (instancetype)initWithDate:(NSDate *)date delegate:(id<KPDatePickerDelegate>)inDelegate;
{
    self = [self initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.delegate = inDelegate;
        self.mode = UIDatePickerModeDate;
        
        [self initPicker:date];
        self.backgroundColor = [UIColor clearColor];
        
        UIView *coverView = [[UIView alloc] init];
        coverView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 260);
        coverView.backgroundColor = [UIColor clearColor];
        [self addSubview:coverView];
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCancelClick:)];
        [coverView addGestureRecognizer:recognizer];
    }
    
    return self;
}

/*
 * 选择器初始化
 */
- (void)initPicker:(NSDate *)defaultDate
{
    CGRect containerFrame = [UIScreen mainScreen].bounds;
    containerFrame.origin.y = containerFrame.size.height;
    containerFrame.size.height = 260;
    
    self.containerView = [[UIView alloc] initWithFrame:containerFrame];
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.userInteractionEnabled = YES;
    
    // 创建 toolBar & hintsLabel & enter button
    UIToolbar* toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    toolBar.barStyle = UIBarStyleDefault;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"  取消  " style:UIBarButtonItemStyleDone target:self action:@selector(onCancelClick:)];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"  确定  " style:UIBarButtonItemStyleDone target:self action:@selector(onSubmitClick:)];
    UIBarButtonItem *fixItem  = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target: nil action: nil];
    [toolBar setItems:@[backItem, fixItem, doneItem]];
    [self.containerView addSubview:toolBar];

    self.datePicker = [[UIDatePicker alloc] init];
    CGRect dateFrame = self.datePicker.bounds;
    dateFrame.origin.y = 44;
    self.datePicker.frame = dateFrame;
    
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    
    if (defaultDate) {
        [self.datePicker setDate:defaultDate];
    }
    
    [self.containerView addSubview:self.datePicker];
    [self addSubview:self.containerView];
}

- (void)setMode:(UIDatePickerMode)mode
{
    _mode = mode;
    self.datePicker.datePickerMode = mode;
}

- (void)show
{
    id<UIApplicationDelegate> appDelegete = [UIApplication sharedApplication].delegate;
    [[appDelegete window] addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect showFrame = self.containerView.frame;
        showFrame.origin.y = showFrame.origin.y - 260;
        self.containerView.frame = showFrame;
        [self layoutIfNeeded];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect showFrame = self.containerView.frame;
        showFrame.origin.y = showFrame.origin.y + 260;
        self.containerView.frame = showFrame;
        [self layoutIfNeeded];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

#pragma mark - 事件

- (void)onCancelClick:(id)sender
{
    [self dismiss];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerDidCancel:)]) {
        [self.delegate datePickerDidCancel:self];
    }
}

- (void)onSubmitClick:(id)sender
{
    [self dismiss];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:didSelectDate:)]) {
        [self.delegate datePicker:self didSelectDate:self.datePicker.date];
    }
}

@end
