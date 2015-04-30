//
//  KPError.h
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPError : NSError

/**
 *  错误码
 */
@property (nonatomic, assign) NSInteger errorCode;

/**
 *  错误内容
 */
@property (nonatomic, strong) NSString *errorMsg;

/**
 *  初始化错误对象
 *
 *  @param errorCode
 *  @param errorMsg
 *
 *  @return
 */
+ (instancetype)errorWithCode:(NSInteger)errorCode message:(NSString *)errorMsg;

/**
 *  初始化网络错误对象
 *
 *  @return 
 */
+ (instancetype)errorWithNetError;

/**
 *  初始化数据错误对象（一般为解析错误）
 *
 *  @return 
 */
+ (instancetype)errorWithDataError;

@end



//-----------------------------------------------------------------------------



#define KPErrorMsg_Net          @"您的网络不给力"
#define KPErrorMsg_Data         @"数据错误"