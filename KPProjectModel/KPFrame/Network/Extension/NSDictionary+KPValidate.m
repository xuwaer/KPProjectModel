//
//  NSDictionary+KPValidate.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/26.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "NSDictionary+KPValidate.h"

@implementation NSDictionary (KPValidate)

- (id)objectValidateForKey:(NSString *)key
{
    const id null = [NSNull null];
    id value = [self objectForKey:key];
    
    if (value == nil || value == null)
        return nil;
    else
        return value;
}

- (NSDictionary *)dictionaryByReplacingNullWithBlank
{
    NSMutableDictionary *replaced = [self mutableCopy];
    const id null = [NSNull null];
    const NSString *blank = @"";
    
    for (NSString *key in self.allKeys) {
        
        id value = [self objectForKey:key];
        
        if ([value isEqual:null]) {
            [replaced setObject:blank forKey:key];
        }
        else if ([value isKindOfClass:[NSDictionary class]]) {
            [replaced setObject:[value dictionaryByReplacingNullWithBlank] forKey:key];
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            [replaced setObject:[value arrayByReplacingNullWithBlank] forKey:key];
        }
    }
    
    return [[NSDictionary alloc] initWithDictionary:replaced];
}

@end
