//
//  KPNetworkEngine.m
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPNetworkEngine.h"

@interface KPNetworkEngine ()

@end

@implementation KPNetworkEngine

- (void)request:(KPBaseRequest *)request success:(SuccessBlock)success fail:(FailBlock)fail upload:(UploadBlock)upload download:(UploadBlock)download
{
    // 请求类型
    NSString *method = @"";
    switch (request.requestType) {
        case HttpRequestTypeGet:
        case HttpRequestDownloadFile:
            method = @"GET";
            break;
        case HttpRequestTypePost:
        case HttpRequestTypePostWithFile:
        case HttpRequestTypePostWithData:
            method = @"POST";
            break;
    }
    
    MKNetworkOperation *operation = [self operationWithPath:request.apiURL params:request.params httpMethod:method];
    [self addUploadInformationToOperation:operation request:request];
    
    DDLogVerbose(@"\n%@ URL:%@\nparam:%@", method, operation.url, request.params);
    
    __weak typeof(id) userinfo = request.userinfo;
    // 主要功能：请求、应答
    MKNKResponseBlock responseBlock = ^(MKNetworkOperation *operation) {
        
        DDLogVerbose(@"\nResult:%@", operation.responseString);
        
        // 解析错误
        if (!operation.responseJSON) {
            fail([KPError errorWithDataError], userinfo);
            return ;
        }
        
        // 封装返回
        KPBaseResponse *response = [[KPBaseResponse alloc] initWithDictionary:operation.responseJSON];
        
        // 业务错误
        if (response.code.intValue != KP_NETWORK_CODE_SUCCESS) {
            fail([KPError errorWithCode:response.code.intValue message:response.msg], userinfo);
            return;
        }
        
        success(response, userinfo);
    };
    
    MKNKResponseErrorBlock errorBlock = ^(MKNetworkOperation *operation, NSError *error){
        DDLogVerbose(@"\nNetError:%@", error);
        // 网络错误
        fail([KPError errorWithNetError], userinfo);
    };
    
    // 请求、返回结果
    [operation addCompletionHandler:responseBlock errorHandler:errorBlock];
    
    
    // 附加功能
    // 1.上传
    if (upload) {
        
        MKNKProgressBlock progressBlock = ^(double progress) {
            upload(progress, userinfo);
        };
        
        [operation onUploadProgressChanged:progressBlock];
    }
    
    // 2.下载
    if (download) {
        
        MKNKProgressBlock progressBlock = ^(double progress) {
            download(progress, userinfo);
        };
        
        [operation onDownloadProgressChanged:progressBlock];
    }
    
    // 执行网络请求
    [self enqueueOperation:operation];
}

/**
 *  添加上传附件
 *
 *  @param operation
 *  @param request
 */
- (void)addUploadInformationToOperation:(MKNetworkOperation *)operation request:(KPBaseRequest *)request
{
    switch (request.requestType) {
        case HttpRequestTypeGet:
        case HttpRequestTypePost:
        case HttpRequestDownloadFile:
            break;
        case HttpRequestTypePostWithData:
            [operation addData:request.fileData forKey:request.fileName mimeType:@"application/octet-stream" fileName:@"file"];
            break;
        case HttpRequestTypePostWithFile:
            [operation addFile:request.filePath forKey:request.fileName mimeType:@"application/octet-stream"];
            break;
    }
}

@end
