//
//  NSMutableString+KPAdditional.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/4.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 *  封装多样化文本参数。通过封装方式方便的控制多样化文本
 */
@interface AttributeParam : NSObject 

/**
 *  文本内容
 */
@property (nonatomic, strong) NSString *text;

/**
 *  文本样式定义
 */
@property (nonatomic, strong) NSDictionary *attributes;

/**
 *  初始化多样化文本参数
 *
 *  @param text             文本内容
 *  @param attributes       文本样式定义
 *
 *  @return
 */
- (instancetype)initWithText:(NSString *)text attributes:(NSDictionary *)attributes;

/**
 *  根据参数生成多样化文本
 *
 *  @return 
 */
- (NSAttributedString *)createAttributeText;

@end






@interface NSMutableAttributedString (KPAdditional)




/**
 *  生成Attribute文本。按照顺序生成并拼接Attribute文本
 *
 *  @param params @[AttributeParam]
 *
 *  @return
 */
+ (NSMutableAttributedString *)attributeStringWithParams:(NSArray *)params;

@end