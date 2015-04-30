//
//  KPBaseResponse.h
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络请求返回对象。必须为json格式
 *  把json数据封装为model
 */
@interface KPBaseModel : NSObject 

/**
 *  json数据
 */
@property (nonatomic, strong, readonly) NSDictionary *jsonData;

/**
 *  初始化，然后赋值封装
 *
 *  @param dictionary
 *
 *  @return
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  对象封装赋值，使用KeyPath方式，如果property name 与 json key不一致（大小写敏感），需要设置赋值映射。重写该方法，达到赋值映射。key为json key，value为property name
 *
 *  @return
 */
+ (NSDictionary *)JSONKeyPathsByPropertyKey;

@end
