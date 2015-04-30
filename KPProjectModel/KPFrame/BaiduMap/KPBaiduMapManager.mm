//
//  LocationManager.m
//  ewclient
//
//  Created by bill wang on 12-3-30.
//  Copyright (c) 2012年 uestc. All rights reserved.
//
//  modify by xukj - 20150107

#import "KPBaiduMapManager.h"

@interface KPBaiduMapManager () <BMKGeoCodeSearchDelegate, BMKLocationServiceDelegate>

/**
 *  委托的对象
 */
@property (nonatomic, strong) NSMutableArray *delegates;

/**
 *  位置解析功能
 */
@property (nonatomic, strong) BMKGeoCodeSearch *bmkGeoSearch;

/**
 *  定位功能
 */
@property (nonatomic, strong) BMKLocationService *bmkLocation;

@end

@implementation KPBaiduMapManager

+(KPBaiduMapManager *)defaultManager
{
    static KPBaiduMapManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KPBaiduMapManager alloc] init];
    });
    
    return manager;
}

-(id)init
{
    self = [super init];
    if (self != nil) {
        
        self.delegates = [[NSMutableArray alloc] init];
        
        clLocationManager = [[CLLocationManager alloc] init];
        
        self.bmkGeoSearch = [[BMKGeoCodeSearch alloc] init];
        self.bmkGeoSearch.delegate = self;
        
        self.bmkLocation = [[BMKLocationService alloc] init];
        self.bmkLocation.delegate = self;
        [BMKLocationService setLocationDesiredAccuracy:kCLLocationAccuracyBest];
    }
    
    return self;
}
#pragma mark - user method

+(BOOL)isEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

#pragma mark - 委托相关

- (void)addDelegate:(id<KPBaiduMapDelegate>)delegate
{
    [self.delegates addObject:delegate];
}

- (void)removeDelegate:(id<KPBaiduMapDelegate>)delegate
{
    [self.delegates removeObject:delegate];
}

- (void)removeAllDelegates
{
    [self.delegates removeAllObjects];
}


//---------------------------------------------------------------------------------------

#pragma mark - 地址位置信息相关功能

/**
 *根据地址名称获取地理信息
 *异步函数，返回结果在BMKGeoCodeSearchDelegate的onGetAddrResult通知
 *@param geoCodeOption       geo检索信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)geoCode:(BMKGeoCodeSearchOption *)geoCodeOption
{
    return [self.bmkGeoSearch geoCode:geoCodeOption];
}

/**
 *根据地理坐标获取地址信息
 *异步函数，返回结果在BMKGeoCodeSearchDelegate的onGetAddrResult通知
 *@param reverseGeoCodeOption 反geo检索信息类
 *@return 成功返回YES，否则返回NO
 */
- (BOOL)reverseGeoCode:(BMKReverseGeoCodeOption *)reverseGeoCodeOption
{
    return [self.bmkGeoSearch reverseGeoCode:reverseGeoCodeOption];
}

#pragma mark - BMKGeoCodeSearch delegate

/**
 *返回地址信息搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结BMKGeoCodeSearch果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    for (id<KPBaiduMapDelegate>delegate in self.delegates) {
        
        if ([delegate respondsToSelector:@selector(onGetGeoCodeResult:result:errorCode:)])
        {
            [delegate onGetGeoCodeResult:searcher result:result errorCode:error];
        }
    }
}

/**
 *返回反地理编码搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    for (id<KPBaiduMapDelegate>delegate in self.delegates) {
        
        if ([delegate respondsToSelector:@selector(onGetReverseGeoCodeResult:result:errorCode:)])
        {
            [delegate onGetReverseGeoCodeResult:searcher result:result errorCode:error];
        }
    }
    
    if (error == BMK_SEARCH_NO_ERROR) {
        
    }
}



//---------------------------------------------------------------------------------------

#pragma mark - 定位功能

-(void)startLocationUpdate
{
    [self.bmkLocation startUserLocationService];
}

-(void)stopLocationUpdate
{
    [self.bmkLocation stopUserLocationService];
}


#pragma mark - BMKLocation delegate

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    if (userLocation == nil || userLocation.isUpdating == YES) {
        
    }
    else {
        
        _userLocation = userLocation;
        for (id<KPBaiduMapDelegate>delegate in self.delegates) {
            
            if ([delegate respondsToSelector:@selector(didUpdateBMKUserLocation:)])
            {
                [delegate didUpdateBMKUserLocation:userLocation];
            }
        }
    }
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    for (id<KPBaiduMapDelegate>delegate in self.delegates) {
        
        if ([delegate respondsToSelector:@selector(didFailToLocateUserWithError:)])
        {
            [delegate didFailToLocateUserWithError:error];
        }
    }
}

@end
