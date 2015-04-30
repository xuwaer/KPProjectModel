//
//  KPNetwork(Constant).h
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//


/**
 引用头
 */
#import "KPBaseRequest.h"
#import "KPBaseModel.h"
#import "KPBaseResponse.h"
#import "KPNetworkEngine.h"
#import "KPError.h"

#import "NSDictionary+KPValidate.h"
#import "NSArray+KPValidate.h"

//------------------------------------------------------------------




/**
 服务器环境
 */
#define ServerType_Develop          0       //开发环境
#define ServerType_Test             1       //测试环境
#define ServerType_Production       2       //生产环境


/**
 *  指定使用的服务器环境
 */
#define ServerRoot                  ServerType_Production

#if     ServerRoot == ServerType_Developer
#define BaseURL         @""

#elif   ServerRoot == ServerType_Test
#define BaseURL         @""

#elif   ServerRoot == ServerType_Production
#define BaseURL         @"www.gegejiadao.com:7001/CD"

#endif



//------------------------------------------------------------------



/**
 *  接口定义
 */
#define GETCASES        @"Case/GetCases"



//------------------------------------------------------------------



/**
 *  网络请求返回码
 */
typedef NS_ENUM(int, KP_NETWORK_CODE) {
    //网络错误
    KP_NETWORK_CODE_NETERROR = -1,
    
    //数据错误，一般为解析错误
    KP_NETWORK_CODE_DATAERROR = -2,
    
    //业务相关
    //成功
    KP_NETWORK_CODE_SUCCESS = 0,
};