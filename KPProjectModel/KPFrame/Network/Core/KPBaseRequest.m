//
//  KPBaseRequest.m
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPBaseRequest.h"
#import "KPNetworkEngine.h"
#import <objc/runtime.h>

@interface KPBaseRequest ()
{
    NSDictionary *_params;
}

@property (nonatomic, strong) KPNetworkEngine *networkEngine;

@end

@implementation KPBaseRequest

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        static KPNetworkEngine *networkEngine = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            networkEngine = [[KPNetworkEngine alloc] initWithHostName:BaseURL];
        });
        
        _networkEngine = networkEngine;
        // 默认使用post
        _requestType = HttpRequestTypePost;
    }
    
    return self;
}

- (instancetype)initWithApiURL:(NSString *)apiURL type:(enum HttpRequestType)type
{
    self = [super init];
    
    if (self) {
        
        static KPNetworkEngine *networkEngine = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            networkEngine = [[KPNetworkEngine alloc] initWithHostName:BaseURL];
        });
        
        _networkEngine = networkEngine;
        // 默认使用post
        _requestType = type;
        _apiURL = apiURL;
    }
    
    return self;
}

- (NSDictionary *)params
{
    return _params;
}

/**
 *  添加基础param
 */
- (NSDictionary *)baseParams
{
    return nil;
}

- (NSDictionary *)mappingKeys
{
    return nil;
}

- (NSArray *)ignoreKeys
{
    return @[@"url",
             @"params",
             @"requestType",
             @"userinfo",
             @"fileName",
             @"filePath",
             @"fileData"];
}

/**
 *	@brief	反射方式生成http请求param
 *
 *	@return
 */
- (NSDictionary *)generatorRequestParams
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    unsigned int propertyCount, i;
    
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    // 忽略项
    NSArray *ignoreArray = [self ignoreKeys];
    // 映射项
    NSDictionary *mappingDic = [self mappingKeys];
    
    for (i = 0; i < propertyCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        // 忽略项
        if ([ignoreArray containsObject:key]) {
            continue;
        }
        
        id value = [self valueForKey:key];
        
        if (value == nil) {
            continue;
        }
        
        // 映射项
        NSString *mappingValue = [mappingDic objectForKey:key];
        if (!StringNotEmpty(mappingValue)) {
            [params setValue:value forKey:key];
        }
        else {
            [params setValue:value forKey:mappingValue];
        }
    }
    
    free(properties);
    
    return params;
}

//------------------------------------------------------

#pragma mark - 网络请求调用

//------------------------------------------------------

- (void)requestWithSuccess:(SuccessBlock)success fail:(FailBlock)fail
{
    [self requestWithSuccess:success fail:fail upload:nil download:nil];
}

- (void)requestWithSuccess:(SuccessBlock)success fail:(FailBlock)fail download:(DownloadBlock)download
{
    [self requestWithSuccess:success fail:fail upload:nil download:download];
}

- (void)requestWithSuccess:(SuccessBlock)success fail:(FailBlock)fail upload:(UploadBlock)upload
{
    [self requestWithSuccess:success fail:fail upload:upload download:nil];
}

- (void)requestWithSuccess:(SuccessBlock)success fail:(FailBlock)fail upload:(UploadBlock)upload download:(DownloadBlock)download
{    
    // 重置参数
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    // 请求参数
    NSDictionary *param = [self generatorRequestParams];
    if (DictionaryNotEmpty(param)) {
        [params setValuesForKeysWithDictionary:param];
    }
    
    // 基本参数
    NSDictionary *baseParam = [self baseParams];
    if (DictionaryNotEmpty(baseParam)) {
        [params setValuesForKeysWithDictionary:baseParam];
    }
    
    _params = params;
    
    [self.networkEngine request:self success:^(KPBaseResponse *response, id userinfo)
    {
        // 验证数据合法性，剔除NSNull类型
        if (response.code.intValue == KP_NETWORK_CODE_SUCCESS) {
            if ([response.data isKindOfClass:[NSDictionary class]]) {
                response.data = [response.data dictionaryByReplacingNullWithBlank];
            }
            else if ([response.data isKindOfClass:[NSArray class]]) {
                response.data = [response.data arrayByReplacingNullWithBlank];
            }
        }
        
    } fail:fail upload:upload download:download];
}


@end