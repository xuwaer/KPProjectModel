//
//  NSArray+KPValidate.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/26.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  处理NSArray中不符合规范的，NSNull类型
 */
@interface NSArray (KPValidate)

/**
 *  不规范的NSNull类型，返回nil
 *
 *  @param index
 *
 *  @return
 */
- (id) objectValidateAtIndex:(NSUInteger)index;

/**
 *  替换不规范的NSNull类型为NSString类型
 *
 *  @return
 */
- (NSArray *)arrayByReplacingNullWithBlank;

@end
