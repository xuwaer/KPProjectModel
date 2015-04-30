//
//  KPTableViewCell.m
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/5.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPBaseTableViewCell.h"

@implementation KPBaseTableViewCell

- (void)setDatasource:(id)datasource
{
    _datasource = datasource;
}

+ (CGFloat)cellHeight:(id)datasource
{
    return 44;
}

@end
