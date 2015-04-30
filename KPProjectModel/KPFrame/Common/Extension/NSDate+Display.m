//
//  NSDate+Display.m
//  KPProjectModel
//
//  Created by xukj on 15-2-21.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "NSDate+Display.h"

@implementation NSDate (Display)

- (NSString *)displayByFromateString:(NSString *)formateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = formateString;
    return [formatter stringFromDate:self];
}

- (NSString *)displayShortTime
{
    NSDate *now = [NSDate date];
    NSDateComponents *comp = [self lapse:(NSCalendarUnitYear|
                                          NSCalendarUnitMonth|
                                          NSCalendarUnitDay|
                                          NSCalendarUnitHour|
                                          NSCalendarUnitMinute|
                                          NSCalendarUnitSecond)
                                fromDate:now];

    
    
    if (comp.year > 0) {
        
        return [NSString stringWithFormat:@"%ld年前", comp.year];
    }
    else if (comp.month > 0) {
        return [NSString stringWithFormat:@"%ld月前", comp.month];
    }
    else if (comp.day > 0) {
        return [NSString stringWithFormat:@"%ld小时前", comp.day];
    }
    else if (comp.hour > 0) {
        return [NSString stringWithFormat:@"%ld分钟前", comp.hour];
    }
    else if (comp.minute > 0) {
        return [NSString stringWithFormat:@"%ld分钟前", comp.minute];
    }
    else {
        return @"刚刚";
    }
}

@end



@implementation NSNumber (Display)

- (NSString *)displayByFromateString:(NSString *)formateString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    formatter.dateFormat = formateString;
    return [formatter stringFromDate:date];
}

- (NSString *)displayShortTime
{
    NSDate *now = [NSDate date];
    NSDate *showDate = [NSDate dateWithTimeIntervalSince1970:self.doubleValue];
    
    NSDateComponents *comp = [showDate lapse:(NSCalendarUnitYear|
                                              NSCalendarUnitMonth|
                                              NSCalendarUnitDay|
                                              NSCalendarUnitHour|
                                              NSCalendarUnitMinute|
                                              NSCalendarUnitSecond)
                                    fromDate:now];
    
    
    if (comp.year > 0) {
        
        return [NSString stringWithFormat:@"%ld年前", comp.year];
    }
    else if (comp.month > 0) {
        return [NSString stringWithFormat:@"%ld月前", comp.month];
    }
    else if (comp.day > 0) {
        return [NSString stringWithFormat:@"%ld小时前", comp.day];
    }
    else if (comp.hour > 0) {
        return [NSString stringWithFormat:@"%ld分钟前", comp.hour];
    }
    else if (comp.minute > 0) {
        return [NSString stringWithFormat:@"%ld分钟前", comp.minute];
    }
    else {
        return @"刚刚";
    }
}

@end