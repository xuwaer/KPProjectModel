//
//  KPManager.h
//  KPProjectModel
//
//  Created by xukj on 15-2-21.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPFrameHeader.h"

@interface KPManager : NSObject

/**
 *  配置日志
 */
+ (void)addLog;

/**
 *  配置网络请求框架
 */
+ (void)addNetwork;

/**
 *  配置数据库框架
 */
+ (void)addDatabase;

/**
 *  配置百度地图框架
 *
 *  @return
 */
+ (BOOL)addBaiduMap;

/**
 *  配置提示框架
 *
 *  @param window
 */
+ (void)addAlert:(UIWindow *)window;

/**
 *  配置通用框架
 */
+ (void)addCommon;

@end
