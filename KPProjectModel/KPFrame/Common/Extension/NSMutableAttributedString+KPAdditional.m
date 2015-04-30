//
//  NSMutableString+KPAdditional.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/4.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "NSMutableAttributedString+KPAdditional.h"






@implementation AttributeParam


- (instancetype)initWithText:(NSString *)text attributes:(NSDictionary *)attributes
{
    self = [super init];
    
    if (self) {
        _text = text;
        _attributes = attributes;
    }
    
    return self;
}


- (NSAttributedString *)createAttributeText
{
    if (StringNotEmpty(_text))
        return [[NSAttributedString alloc] initWithString:self.text attributes:_attributes];
    else
        return [[NSAttributedString alloc] initWithString:@""];
}

@end






@implementation NSMutableAttributedString (KPAdditional)


+ (NSMutableAttributedString *)attributeStringWithParams:(NSArray *)params
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@""];

    if (!ArrayNotEmpty(params)) {
        return attributeString;
    }
    
    for (AttributeParam *param in params) {
        NSAttributedString *subString = [param createAttributeText];
        [attributeString appendAttributedString:subString];
    }
    
    return attributeString;
}


@end
