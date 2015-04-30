//
//  KPQRCodeView.h
//  KPProjectModel
//
//  Created by 白松灵 on 15/3/23.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KPQRCodeView;

@protocol KPQRCodeViewDelegate <NSObject>

@optional
/**
 *  扫描结果回调
 *
 *  @param qrView
 *  @param qrContent 扫描结果
 */
-(void)kpQRCodeView:(KPQRCodeView *) qrView scanFinishedWithValue:(NSString *)qrContent;

@end

@interface KPQRCodeView : UIView
/**
 *  扫描结束播放的声音路径
 */
@property(nonatomic,strong)NSURL * soundUrl;
@property(nonatomic,weak)id<KPQRCodeViewDelegate> delegate;
/**
 *  开始扫描
 *
 *  @return
 */
-(BOOL)startScan;
/**
 *  结束扫描
 *
 *  @return
 */
-(BOOL)stopScan;
/**
 *  生成二维码
 *
 *  @param content   二维码内容
 *  @param imageSize 生成图片大小
 *  @param red       生成图片颜色（红 0-255）
 *  @param green     生成图片颜色（绿 0-255）
 *  @param blue      生成图片颜色（蓝 0-255）
 *
 *  @return 二维码图片
 */
+(UIImage *)createQRImageWithContent:(NSString *)content  imageSize:(CGFloat)imageSize withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;

@end
