//
//  KPQRCodeView.m
//  KPProjectModel
//
//  Created by 白松灵 on 15/3/23.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "KPQRCodeView.h"
#import <AVFoundation/AVFoundation.h>

#define ScanWindowWidth 220
#define ScanWindowHeight ScanWindowWidth

@interface KPQRCodeView()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong)AVCaptureSession * captureSession;
@property(nonatomic,strong)AVCaptureMetadataOutput * captureOutput;
@property(nonatomic,strong)AVCaptureDeviceInput * captureInput;
@property(nonatomic,strong)AVCaptureDevice * captureDevice;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer * captureLayer;

@property(nonatomic,strong)NSTimer * timer;
@property(nonatomic,strong)UIImageView * lineImage;
@property(nonatomic,strong)AVAudioPlayer * audioPlayer;

@end

@implementation KPQRCodeView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(BOOL)startScan{
    self.captureDevice=[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError * error;
    self.captureInput=[AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
    if (!self.captureInput) {
        NSLog(@"%@",error.description);
        return NO;
    }
    self.captureOutput=[[AVCaptureMetadataOutput alloc]init];
    [self.captureOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.captureOutput setRectOfInterest:CGRectMake((CGRectGetHeight(self.frame)-ScanWindowHeight)/2/CGRectGetHeight(self.frame), (CGRectGetWidth(self.frame)-ScanWindowWidth)/2/CGRectGetWidth(self.frame), ScanWindowHeight/CGRectGetHeight(self.frame), ScanWindowWidth/CGRectGetWidth(self.frame))];
    
    self.captureSession=[[AVCaptureSession alloc]init];
    [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    [self.captureSession addInput:self.captureInput];
    [self.captureSession addOutput:self.captureOutput];
    
    self.captureOutput.metadataObjectTypes=@[AVMetadataObjectTypeQRCode];
    
    self.captureLayer=[[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    [self.captureLayer setFrame:self.bounds];
    self.captureLayer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    
    [self.layer addSublayer:self.captureLayer];
    
    UIImageView * view=[[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-ScanWindowWidth)/2, (CGRectGetHeight(self.frame)-ScanWindowHeight)/2, ScanWindowWidth, ScanWindowHeight)];
    view.backgroundColor=[UIColor clearColor];
    view.layer.borderColor=[UIColor whiteColor].CGColor;
    view.layer.borderWidth=1;
    view.layer.masksToBounds=YES;
    [self addSubview:view];
    
    self.lineImage=[[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-ScanWindowWidth)/2, (CGRectGetHeight(self.frame)-ScanWindowHeight)/2, ScanWindowWidth, 2)];
    self.lineImage.backgroundColor=[UIColor redColor];
    [self addSubview:self.lineImage];
    
    self.timer=[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateScanLine) userInfo:nil repeats:YES];
    
    
    [self.captureSession startRunning];
    
    self.audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:self.soundUrl error:nil];
    [self.audioPlayer prepareToPlay];

    
    return YES;
}

-(BOOL)stopScan{
    if (self.captureSession) {
        [self.captureSession stopRunning];
        self.captureSession=nil;
    }
    self.captureInput=nil;
    self.captureOutput=nil;
    self.captureDevice=nil;
    [self.lineImage removeFromSuperview];
    [self.captureLayer removeFromSuperlayer];
    [self.timer invalidate];
    self.timer=nil;
    [self.audioPlayer stop];
    self.audioPlayer=nil;
    
    return YES;
}

-(void)updateScanLine{
    CGRect lineFrame=self.lineImage.frame;
    lineFrame.origin.y+=1;
    if (lineFrame.origin.y>(CGRectGetHeight(self.frame)-ScanWindowHeight)/2+ScanWindowHeight) {
        lineFrame.origin.y=(CGRectGetHeight(self.frame)-ScanWindowHeight)/2;
    }
    self.lineImage.frame=lineFrame;
}

#pragma mark metadata delegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (metadataObjects&&metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * object=[metadataObjects firstObject];
        if ([[object type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(kpQRCodeView:scanFinishedWithValue:)]) {
                [self.delegate kpQRCodeView:self scanFinishedWithValue:object.stringValue];
                [self.audioPlayer play];
                [self stopScan];
            }
        }
    }
}

#pragma mark create qrcode

+(UIImage *)createQRImageWithContent:(NSString *)content imageSize:(CGFloat)imageSize withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    UIImage * image=[self createNonInterpolatedUIImageFormCIImage:[self createQRForString:content] withSize:imageSize];
    return [self imageBlackToTransparent:image withRed:red andGreen:green andBlue:blue];
}
/**
 *  根据内容生成二维码图片
 *
 *  @param qrString 二维码内容
 *
 *  @return 二维码图片
 */
+ (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    return qrFilter.outputImage;
}
/**
 *  定义二维码图片大小
 *
 *  @param image
 *  @param size
 *
 *  @return
 */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
/**
 *  定义二维码图片颜色
 *
 *  @param image
 *  @param red
 *  @param green
 *  @param blue
 *
 *  @return
 */
+ (UIImage*)imageBlackToTransparent:(UIImage*)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900)
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red;
            ptr[2] = green;
            ptr[1] = blue;
        }
        else
        {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}

@end
