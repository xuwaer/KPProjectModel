//
//  BaiduMapDef.m
//  EEWClient
//
//  Created by xukj on 15-1-2.
//  Copyright (c) 2015年 yangcz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPBaiduMapDef.h"

#warning 需要设置百度appid
NSString * const kBaiDuMapAppID = @"";

@implementation KPBaiduMapDef

+ (CLLocationCoordinate2D)convertGpsToBaiduLocation:(CLLocationCoordinate2D)oldLocation
{
    //转换 google地图、soso地图、aliyun地图、mapabc地图和amap地图所用坐标至百度坐标
    NSDictionary* locDic = BMKConvertBaiduCoorFrom(oldLocation, BMK_COORDTYPE_COMMON);
    return BMKCoorDictionaryDecode(locDic);
}

+ (CLLocationCoordinate2D)convertBMKToGpsLocation:(CLLocationCoordinate2D)oldLocation
{
    return CLLocationCoordinate2DMake(0, 0);
}

+ (CLLocationDistance)caculateDistanceFromLocation:(CLLocationCoordinate2D)fromLocation toLocation:(CLLocationCoordinate2D)toLocation
{
    BMKMapPoint point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(fromLocation.latitude, fromLocation.longitude));
    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(toLocation.latitude, toLocation.longitude));
    return BMKMetersBetweenMapPoints(point1,point2);
}

@end
