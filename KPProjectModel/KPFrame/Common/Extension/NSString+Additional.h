//
//  TestRequest.h
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Additional)






#pragma mark - 基本扩展功能

/**
 *  计算文字大小
 *
 *  @param font
 *  @param size
 *
 *  @return
 */
- (CGSize)sizeWithFont:(UIFont *)font size:(CGSize)size;


/**
 *  子串位置。
 *  如果子串不存在，则返回NSNotFound
 *
 *  @param string
 *
 *  @return
 */
- (NSUInteger)locationOfString:(NSString *)string;



#pragma mark - 有效性验证


/**
 *  验证密码有效性
 *
 *  @return
 */
- (BOOL)validateLoginPassword;

/**
 *  验证邮箱有效性
 *
 *  @return
 */
- (BOOL)validateEmail;

/**
 *  验证手机号码有效性
 *
 *  @return
 */
- (BOOL)validatePhoneNumber;

@end
