//
//  KPNetworkEngine.h
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KPBaseRequest, KPBaseResponse, KPError;

/**
 *  请求成功
 *
 *  @param response
 *  @param userinfo 用户自定义数据(不作任何变动)
 */
typedef void(^SuccessBlock)(KPBaseResponse *response, id userinfo);

/**
 *  请求失败
 *
 *  @param error
 *  @param userinfo 用户自定义数据(不作任何变动)
 */
typedef void(^FailBlock)(KPError *error, id userinfo);

/**
 *  上传进度
 *
 *  @param progress
 *  @param userinfo 用户自定义数据(不作任何变动)
 */
typedef void(^UploadBlock)(double progress, id userinfo);

/**
 *  下载进度
 *
 *  @param progress
 *  @param userinfo 用户自定义数据(不作任何变动)
 */
typedef void(^DownloadBlock)(double progress, id userinfo);





//-----------------------------------------------------------------------------------------





@interface KPNetworkEngine : MKNetworkEngine

/**
 *  网络请求
 *
 *  @param request
 *  @param success
 *  @param fail
 *  @param download
 */
- (void)request:(KPBaseRequest *)request success:(SuccessBlock)success fail:(FailBlock)fail upload:(UploadBlock)upload download:(UploadBlock)download;

@end
