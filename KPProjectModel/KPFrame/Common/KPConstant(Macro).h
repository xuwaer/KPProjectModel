//
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#ifndef KPConstant_Marco_h
#define KPConstant_Marco_h

/**
 *  日志相关
 */
#if DEBUG

#define DDLogRange(range)                   DDLogVerbose(@"%@", NSStringFromRange(range))
#define DDLogPoint(pt)                      DDLogVerbose(@"%@", NSStringFromCGPoint(pt))
#define DDLogRect(rect)                     DDLogVerbose(@"%@", NSStringFromCGRect(rect))
#define DDLogSize(size)                     DDLogVerbose(@"%@", NSStringFromCGSize(size))
#define DDLogEdgeInsets(inset)              DDLogVerbose(@"%@", NSStringFromUIEdgeInsets(inset))
#define DDLogOffset(offset)                 DDLogVerbose(@"%@", NSStringFromUIOffset(offset))
#define DDLogCoordinate2D(coord)            DDLogVerbose(@"%ld,%ld", coord.latitude, coord.longitude)

#endif

/**
 *  系统相关
 */
#define IOS8_OR_LATER                       ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER                       ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS6_OR_LATER                       ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS5_OR_LATER                       ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )

#define ISIPHONE4                           [[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 480
#define ISIPHONE5                           [[UIScreen mainScreen] bounds].size.width == 320 && [[UIScreen mainScreen] bounds].size.height == 568
#define ISIPHONE6                           [[UIScreen mainScreen] bounds].size.width == 375 && [[UIScreen mainScreen] bounds].size.height == 667
#define ISIPHONE6P                          [[UIScreen mainScreen] bounds].size.width == 414 && [[UIScreen mainScreen] bounds].size.height == 736


/**
 *  系统信息
 */
#define AppVersionNumber                    [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]
#define AppName                             [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]
#define IOSVersion                          [[[UIDevice currentDevice] systemVersion] floatValue]

/**
 *  屏幕信息
 */
#define ScreenRect                          [[UIScreen mainScreen] bounds]
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height

/**
 *  view操作
 */
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        ceilf(f.size.width)
#define RectHeight(f)                       ceilf(f.size.height)
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define Rect(x, y, w, h)                    CGRectMake(x, y, w, h)
#define RectFrame(f)                        CGRectMake(RectX(f), RectY(f), RectWidth(f), RectHeight(f))
#define Point(x, y)                         CGPointMake(x, y)
#define Center(b)                           CGPointMake(b.size.width / 2, b.size.height / 2)

/**
 *  颜色操作
 */
#define RGB(r, g, b)                        [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HexRGB(rgbValue)                    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a)             [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

/**
 *  有效性
 */

// 集合
#define StringNotEmpty(str)                 (str && (str.length > 0))
#define ArrayNotEmpty(arr)                  (arr && (arr.count > 0))
#define DictionaryNotEmpty(dic)             (dic && (dic.count > 0))

// 数字
#define StringValueFromNumber(num)          (num ? num.stringValue : @"0")
#define IntValueFromNumber(num)             (num ? num.intValue : 0)
#define LongValueFromNumber(num)            (num ? num.longValue : 0)
#define LongLongValueFromNumber(num)        (num ? num.longLongValue : 0)
#define FloatValueFromNumber(num)           (num ? num.floatValue : 0.0)
#define DoubleValueFromNumber(num)          (num ? num.doubleValue : 0.0)

#endif