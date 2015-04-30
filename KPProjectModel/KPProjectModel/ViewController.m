//
//  ViewController.m
//  KPProjectModel
//
//  Created by xukj on 15-2-20.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+Test01.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIView *scoreView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    self.title = @" 界面 01";
    [super viewDidLoad];
    
    [self.btn setBorderWidth:1.0 color:[UIColor blueColor].CGColor cornerRadius:3.0];
    
//    [self testScan:self.view];
//    UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, 100, 200, 200)];
//    imageView.image=[KPQRCodeView createQRImageWithContent:@"http://www.baidu.com" imageSize:200 withRed:0 andGreen:0 andBlue:0];
//    [self.view addSubview:imageView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self testStarView:self.view];
//    
//    [self testCustomerAlert];
}

- (IBAction)onGuideClick:(id)sender
{
    
}




@end
