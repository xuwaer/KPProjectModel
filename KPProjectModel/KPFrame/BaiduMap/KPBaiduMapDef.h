//
//  BaiduMapDef.h
//  EEWClient
//
//  Created by xukj on 15-1-2.
//  Copyright (c) 2015年 yangcz. All rights reserved.
//

#import "BMapKit.h"

UIKIT_EXTERN  NSString * const kBaiDuMapAppID;


@interface KPBaiduMapDef : NSObject




//-------------------------------------------------------------------------------

#pragma mark - 坐标转换

/**
 *  gps坐标转化为百度地图显示坐标
 *
 *  @param oldLocation 原gps坐标
 *
 *  @return
 */
+ (CLLocationCoordinate2D)convertGpsToBaiduLocation:(CLLocationCoordinate2D)oldLocation;

/**
 *  百度地图显示坐标经纬度转换为gps坐标。（无效方法）
 *
 *  @param oldLocation
 *
 *  @return
 */
+ (CLLocationCoordinate2D)convertBMKToGpsLocation:(CLLocationCoordinate2D)oldLocation __deprecated;

/**
 *  计算经纬度两点间的距离 (如果需要在百度地图上作处理，请先转换成百度坐标后在使用该方法)
 *
 *  @param fromLocation
 *  @param toLocation
 *
 *  @return 
 */
+ (CLLocationDistance)caculateDistanceFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation;



@end