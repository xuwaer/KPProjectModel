//
//  KPBaseResponse.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/26.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPBaseModel.h"

/**
 *  基本请求返回。如无必要，请勿继承该类。
 *  json子结构的封装，请继承KPBaseModel
 */
@interface KPBaseResponse : KPBaseModel

/**
 *  错误号
 */
@property (nonatomic, strong) NSNumber *code;

/**
 *  错误内容
 */
@property (nonatomic, strong) NSString *msg;

/**
 *  数据
 */
@property (nonatomic, strong) id data;

@end
