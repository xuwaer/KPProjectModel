//
//  ViewController2ViewController.m
//  KPProjectModel
//
//  Created by xukj on 15-3-8.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@property (weak, nonatomic) IBOutlet UITableView *table;
@end

@implementation ViewController2

- (void)viewDidLoad
{
    self.useLeftItem = KPNavigationLeftItem_Pop;
    [super viewDidLoad];
    
    [self.table addRefreshTarget:self refreshNew:@selector(requestNew) refreshMore:@selector(requestMore)];
}

- (void)requestNew
{
    [self performSelector:@selector(end) withObject:nil afterDelay:5];
}

- (void)end
{
    [self.table endRefresh];
}

- (void)requestMore
{
    [self performSelector:@selector(end) withObject:nil afterDelay:5];
}

@end
