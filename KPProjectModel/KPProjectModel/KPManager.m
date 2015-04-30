//
//  KPManager.m
//  KPProjectModel
//
//  Created by xukj on 15-2-21.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPManager.h"

@interface KPManager () <BMKGeneralDelegate>

@end

@implementation KPManager

+ (void)addLog
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

+ (void)addNetwork
{
    
}

+ (void)addDatabase
{
    
}

+ (BOOL)addBaiduMap
{
    BMKMapManager *mapManager = [[BMKMapManager alloc] init];
    BOOL success = [mapManager start:kBaiDuMapAppID generalDelegate:nil];
    
    return success;
}

+ (void)addAlert:(UIWindow *)window
{
    [KPAlertManager defaultManager].window = window;
}

+ (void)addCommon
{

}

@end
