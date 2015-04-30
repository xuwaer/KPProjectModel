//
//  KPTableViewCell.h
//  KPProjectModel
//
//  Created by 徐恺君 on 15/3/5.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPBaseTableViewCell : UITableViewCell

/**
 *  列表项绑定的datasource
 *  子类重写setDatasource方法，即可实现数据绑定以及其他操作
 *  重写时必须调用[super setDatasource:datasource];
 */
@property (nonatomic, strong) id datasource;

/**
 *  重新计算cell高度
 *  根据传入的数据源来计算。需要子类重写该方法。
 *  默认返回44
 *
 *  @params datasource
 *
 *  @return
 */
+ (CGFloat)cellHeight:(id)datasource;

@end
