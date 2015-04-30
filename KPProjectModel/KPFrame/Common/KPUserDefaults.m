//
//  KPUserDefaults.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/5.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPUserDefaults.h"

@implementation KPUserDefaults

- (void)loadDefault
{
    self.startTimes = [self integerForKey:@"startTimes"];
}

- (BOOL)saveDefault
{
    [self setInteger:self.startTimes forKey:@"startTimes"];
    
    return [self synchronize];
}

@end
