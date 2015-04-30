//
//  LocationManager.h
//  ewclient
//
//  Created by bill wang on 12-3-30.
//  Copyright (c) 2012年 uestc. All rights reserved.
//
//  modify by xukj - 20150107
//  修正为百度地图

#import "KPBaiduMapDef.h"

#define kLocationManagerTypeSuccess 0 //获取成功
#define kLocationManagerTypeCannotUseGPS 1  //gps不可用
#define kLocationManagerTypeFail 2  //获取失败


/**
 *  地图管理器委托
 */
@protocol KPBaiduMapDelegate <BMKLocationServiceDelegate, BMKGeoCodeSearchDelegate>

@end






/**
 *  地图管理器
 */
@interface KPBaiduMapManager : NSObject<CLLocationManagerDelegate>
{
    CLLocationManager *clLocationManager;
}

/**
 *  用户当前位置
 */
@property (nonatomic, strong, readonly) BMKUserLocation *userLocation;

+(KPBaiduMapManager *)defaultManager;

+(BOOL) isEnabled;




//---------------------------------------------------------------------------------------

#pragma mark - 委托相关

/**
 *  添加委托
 *
 *  @param delegate
 */
- (void)addDelegate:(id<KPBaiduMapDelegate>)delegate;

/**
 *  移除委托
 *
 *  @param delegate
 */
- (void)removeDelegate:(id<KPBaiduMapDelegate>)delegate;

/**
 *  移除所有委托
 */
- (void)removeAllDelegates;





//---------------------------------------------------------------------------------------

#pragma mark - 定位

/**
 *  启动定位，使用百度的@see BMKLocationService
 */
-(void) startLocationUpdate;

/**
 *  关闭定位，使用百度的@see BMKLocationService
 */
-(void) stopLocationUpdate;





//---------------------------------------------------------------------------------------

#pragma mark - 地址位置信息相关功能

/**
 *根据地址名称获取地理信息
 *异步函数，返回结果在BMKGeoCodeSearchDelegate的onGetAddrResult通知
 *@param geoCodeOption       geo检索信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)geoCode:(BMKGeoCodeSearchOption*)geoCodeOption;
/**
 *根据地理坐标获取地址信息
 *异步函数，返回结果在BMKGeoCodeSearchDelegate的onGetAddrResult通知
 *@param reverseGeoCodeOption 反geo检索信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)reverseGeoCode:(BMKReverseGeoCodeOption*)reverseGeoCodeOption;

@end
