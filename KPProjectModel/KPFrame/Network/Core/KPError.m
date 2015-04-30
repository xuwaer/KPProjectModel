//
//  KPError.m
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPError.h"

@implementation KPError

+ (instancetype)errorWithCode:(NSInteger)errorCode message:(NSString *)errorMsg
{
    KPError *error = [[KPError alloc] init];
    error.errorCode = errorCode;
    error.errorMsg = errorMsg;
    
    return error;
}

+ (instancetype)errorWithNetError
{
    KPError *error = [[KPError alloc] init];
    error.errorCode = KP_NETWORK_CODE_NETERROR;
    error.errorMsg = KPErrorMsg_Net;
    
    return error;
}

+ (instancetype)errorWithDataError
{
    KPError *error = [[KPError alloc] init];
    error.errorCode = KP_NETWORK_CODE_DATAERROR;
    error.errorMsg = KPErrorMsg_Data;
    
    return error;
}

@end
