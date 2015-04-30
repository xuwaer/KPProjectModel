//
//  NSDictionary+KPValidate.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/26.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  处理dictionary中不符合规范的NSNull类型
 */
@interface NSDictionary (KPValidate)

/**
 *  不规范的NSNull类型，返回nil
 */
- (id)objectValidateForKey:(NSString *)key;

/**
 *  替换不规范的NSNull类型为NSString类型
 *
 *  @return
 */
- (NSDictionary *)dictionaryByReplacingNullWithBlank;

@end
