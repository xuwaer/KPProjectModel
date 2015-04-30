//
//  VerticalTopLabel.h
//  Cicada
//
//  Created by 白松灵 on 14/7/31.
//  Copyright (c) 2014年 7jj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VerticalAlignment) {
    VerticalAlignmentTop        = 0,                    // 顶部对齐
    VerticalAlignmentMiddle,                            // 居中对齐
    VerticalAlignmentBottom,                            // 底部对齐
};

@interface KPLabel : UILabel
{
@private
    VerticalAlignment verticalAlignment_;
}

/**
 *  对齐方式
 */
@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end
