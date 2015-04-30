//
//  NSArray+KPValidate.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/26.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "NSArray+KPValidate.h"

@implementation NSArray (KPValidate)

- (id)objectValidateAtIndex:(NSUInteger)index
{
    id value = [self objectAtIndex:index];
    const id null = [NSNull null];
    
    if (value == nil || value == null)
        return nil;
    else
        return value;
}

- (NSArray *)arrayByReplacingNullWithBlank
{
    NSMutableArray *replaced = [self mutableCopy];
    const id null = [NSNull null];
    const NSString *blank = @"";
    
    for (int i = 0; i < replaced.count; i++) {
        
        id value = replaced[i];
        if (value == null) {
            [replaced replaceObjectAtIndex:i withObject:blank];
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            [replaced replaceObjectAtIndex:i withObject:[value arrayByReplacingNullWithBlank]];
        }
        else if ([value isKindOfClass:[NSDictionary class]]) {
            [replaced replaceObjectAtIndex:i withObject:[value dictionaryByReplacingNullWithBlank]];
        }
    }
    
    return [[NSArray alloc] initWithArray:replaced];
}

@end
