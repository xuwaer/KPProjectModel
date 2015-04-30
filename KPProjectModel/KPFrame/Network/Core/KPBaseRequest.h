//
//  KPBaseRequest.h
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KPNetworkEngine.h"


enum HttpRequestType {
    HttpRequestTypeGet          = 0,
    HttpRequestTypePost         = 1,    // 默认使用Post上传
    HttpRequestTypePostWithFile = 2,    // post上传文件
    HttpRequestTypePostWithData = 3,    // post上传二进制bytes
#warning not test yet
    HttpRequestDownloadFile     = 4
};

@interface KPBaseRequest : NSObject


#pragma mark - 网络请求基本参数及方法

/**
 *  请求的该接口的地址
 */
@property (nonatomic, strong) NSString *apiURL;

/**
 *  请求参数
 */
@property (nonatomic, strong, readonly) NSDictionary *params;

/**
 *  POST/GET
 */
@property (nonatomic, assign) enum HttpRequestType requestType;

/**
 *  用户自定义数据，不作任何变动。在请求完成、失败、错误、进度block调用时，返回
 */
@property (nonatomic, strong) id userinfo;

/**
 *  初始化请求
 *
 *  @param apiURL 接口地址（相对地址）
 *  @param type   请求类型
 *
 *  @return
 */
- (instancetype)initWithApiURL:(NSString *)apiURL type:(enum HttpRequestType)type;

/**
 *  添加基础参数（如果有基础参数需要添加，请重写该方法）
 */
- (NSDictionary *)baseParams;

/**
 *  需要映射的key
 *  格式{@"":@""}
 *  {映射前:映射后}
 *
 *  @return
 */
- (NSDictionary *)mappingKeys;

/**
 *  需要忽略掉的key，不参与生成请求参数。如果要添加新的忽略项，请重写该方法
 *  重写的方法中，必须把base基础参数加入
 *
 *  @return
 */
- (NSArray *)ignoreKeys;

/**
 *  网络请求
 *
 *  @param success      应答
 *  @param fail         失败
 *  @param upload       上传进度
 *  @param download     下载进度
 */
- (void)requestWithSuccess:(SuccessBlock)success fail:(FailBlock)fail;
- (void)requestWithSuccess:(SuccessBlock)success fail:(FailBlock)fail upload:(UploadBlock)upload;
- (void)requestWithSuccess:(SuccessBlock)success fail:(FailBlock)fail download:(DownloadBlock)download;




//----------------------------------------------------------------------




#pragma mark - 文件上传相关

/**
 *  文件名
 */
@property (nonatomic, strong) NSString *fileName;

/**
 *  文件路径，当fileData为nil时，有效
 */
@property (nonatomic, strong) NSString *filePath;

/**
 *  文件data
 */
@property (nonatomic, strong) NSData *fileData;



@end