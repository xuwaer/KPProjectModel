//
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#ifndef KPFrame_Header_h
#define KPFrame_Header_h




#ifdef __OBJC__

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
// 日志
//#import <DDLog.h>
//#import <DDTTYLogger.h>
//#import <DDASLLogger.h>
//#import <DDFileLogger.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

// 工具
#import "KPConstant(Macro).h"
#import "KPConstant(String).h"

#import "NSString+Additional.h"
#import "NSMutableAttributedString+KPAdditional.h"
#import "UIColor+Additional.h"
#import <NSDate-Extension/NSDate+Extension.h>
#import "NSDate+Display.h"
#import "UIImage+KPAdditional.h"

// 数据库
#import <CoreData/CoreData.h>
#import "CoreDataStorage.h"
#import "CoreDataStorageProtected.h"

// 网络及解析
#import <MKNetworkKit.h>
#import "KPNetworkDef.h"

// 位置
#import <CoreLocation/CoreLocation.h>
#import "KPBaiduMapManager.h"

// 提示
#import <MBProgressHUD.h>
#import "KPAlertViewExt.h"
#import "KPAlertManager.h"
	
// 自定义控件和扩展
#import "KPTextField.h"
#import "KPDatePicker.h"
#import "KPLabel.h"
#import "GCPlaceholderTextView.h"
#import "KPStarView.h"
#import "MJRefresh.h"
#import "KPBaseTableViewCell.h"
#import "AdView.h"
#import "KPPopView.h"
#import "KPQRCodeView.h"

#import "UIButton+KPButton.h"
#import "UIViewController+KPAdditional.h"
#import "UIScrollView+KPRefresh.h"

#import "KPLaunchController.h"

// 父类
#import "KPBaseViewController.h"

#endif





#if DEBUG
static const DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static const DDLogLevel ddLogLevel = DDLogLevelInfo;
#endif

#endif
