//
//  KPBaseModel.m
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPBaseModel.h"

@implementation KPBaseModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return nil;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        
        _jsonData = dictionary;
        
    }
    
    return self;
}

// 赋值
- (void)initValues
{
    if (_jsonData == nil || ![_jsonData isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    [self setValuesForKeysWithDictionary:_jsonData];
}

/**
 *  忽略不需要的json key
 */
-(id)valueForUndefinedKey:(NSString *)key
{
    DDLogVerbose(@"undefinedKey:%@", key);
    return nil;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DDLogVerbose(@"undefinedKey:%@", key);
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    NSDictionary *mapping = [KPBaseModel JSONKeyPathsByPropertyKey];
    if (DictionaryNotEmpty(mapping)) {
        
        NSString *propertyName = mapping[key];
        if (StringNotEmpty(propertyName)) {
            key = propertyName;
        }
    }
    
    [self setValue:value forKey:key];
}

@end
