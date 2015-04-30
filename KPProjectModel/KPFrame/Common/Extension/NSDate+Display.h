//
//  NSDate+Display.h
//  KPProjectModel
//
//  Created by xukj on 15-2-21.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Display)

/**
 *  根据制定格式显示日期
 *
 *  @param formateString 格式字符串
 *
 *  @return
 */
- (NSString *)displayByFromateString:(NSString *)formateString;

/**
 *  显示短时间(相对系统当前时间)
 *  1分钟内显示刚刚
 *  1小时内显示xx分钟前
 *  1天内显示xx小时前
 *  1月内显示xx天前
 *  1年内显示xx月前
 *  其他显示yyyy年MM月dd日
 *
 *  @return
 */
- (NSString *)displayShortTime;

@end



@interface NSNumber (Display)

/**
 *  根据制定格式显示日期
 *
 *  @param formateString 格式字符串
 *
 *  @return
 */
- (NSString *)displayByFromateString:(NSString *)formateString;

/**
 *  显示短时间(相对系统当前时间)
 *  1分钟内显示刚刚
 *  1小时内显示xx分钟前
 *  1天内显示xx小时前
 *  1月内显示xx天前
 *  1年内显示xx月前
 *  其他显示yyyy年MM月dd日
 *
 *  @return
 */
- (NSString *)displayShortTime;

@end