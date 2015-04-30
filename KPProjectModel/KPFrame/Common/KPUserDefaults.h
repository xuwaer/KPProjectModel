//
//  KPUserDefaults.h
//  KPProjectModel
//
//  该对象记录app通用的简单数据
//
//  Created by 徐恺君 on 15/3/5.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPUserDefaults : NSUserDefaults

/**
 *  启动次数。默认：0
 */
@property (nonatomic, assign) NSUInteger startTimes;



/**
 *  获取数据
 */
- (void)loadDefault;

/**
 *  保存数据
 */
- (BOOL)saveDefault;

@end
