//
//  UIScrollView+KPRefresh.m
//  KPProjectModel
//
//  Created by xukj on 15/3/24.
//  Copyright (c) 2015年 kp. All rights reserved.
//

#import "UIScrollView+KPRefresh.h"

@implementation UIScrollView (KPRefresh)



#pragma mark - 刷新相关配置



- (void)addRefreshNewBlock:(void (^)(void))newBlock refreshMoreBlock:(void (^)(void))moreBlock
{
    [self addRefreshNewBlock:newBlock dateKey:nil refreshMoreBlock:moreBlock];
}

- (void)addRefreshNewBlock:(void (^)(void))newBlock dateKey:(NSString *)dateKey refreshMoreBlock:(void (^)(void))moreBlock
{
    if (newBlock == nil || moreBlock == NULL) {
        [self removeHeader];
    }
    else {
        [self addLegendHeaderWithRefreshingBlock:newBlock dateKey:dateKey];
        [self.header setTitle:[self headerIdleText] forState:MJRefreshHeaderStateIdle];
        [self.header setTitle:[self headerPullingText] forState:MJRefreshHeaderStatePulling];
        [self.header setTitle:[self headerRefreshingText] forState:MJRefreshHeaderStateRefreshing];
    }
    
    if (moreBlock == nil || moreBlock == NULL) {
        [self removeFooter];
    }
    else {
        [self addLegendFooterWithRefreshingBlock:moreBlock];
        [self.footer setTitle:[self footerIdleText] forState:MJRefreshFooterStateIdle];
        [self.footer setTitle:[self footerRefreshingText] forState:MJRefreshFooterStateRefreshing];
        [self.footer setTitle:[self footerNoDataText] forState:MJRefreshFooterStateNoMoreData];
    }
    
}

- (void)addRefreshTarget:(id)target refreshNew:(SEL)selectorNew refreshMore:(SEL)selectorMore
{
    [self addRefreshTarget:(id)target refreshNew:selectorNew dateKey:nil refreshMore:selectorMore];
}

- (void)addRefreshTarget:(id)target refreshNew:(SEL)selectorNew dateKey:(NSString *)dateKey refreshMore:(SEL)selectorMore
{
    // 新版本MJRefresh移除该功能
    if (selectorNew == nil || selectorNew == NULL) {
        [self removeHeader];
    }
    else {
        [self addLegendHeaderWithRefreshingTarget:target refreshingAction:selectorNew dateKey:dateKey];
        [self.header setTitle:[self headerIdleText] forState:MJRefreshHeaderStateIdle];
        [self.header setTitle:[self headerPullingText] forState:MJRefreshHeaderStatePulling];
        [self.header setTitle:[self headerRefreshingText] forState:MJRefreshHeaderStateRefreshing];
    }
    
    if (selectorMore == nil || selectorMore == NULL) {
        [self removeFooter];
    }
    else {
        [self addLegendFooterWithRefreshingTarget:self refreshingAction:selectorMore];
        [self.footer setTitle:[self footerIdleText] forState:MJRefreshFooterStateIdle];
        [self.footer setTitle:[self footerRefreshingText] forState:MJRefreshFooterStateRefreshing];
        [self.footer setTitle:[self footerNoDataText] forState:MJRefreshFooterStateNoMoreData];
    }
}

- (void)beginRefreshNew
{
    [self.footer endRefreshing];
    
    if (![self.header isRefreshing]) {
        [self.header beginRefreshing];
    }
}

- (void)beginRefreshMore
{
    [self.header endRefreshing];
    
    if (![self.footer isRefreshing]) {
        [self.footer beginRefreshing];
    }
}

- (void)endRefresh
{
    [self.header endRefreshing];
    [self.footer endRefreshing];
}

#pragma mark - 文字相关

- (NSString *)headerIdleText
{
    return MJRefreshHeaderStateIdleText;
}

- (NSString *)headerPullingText
{
    return MJRefreshHeaderStatePullingText;
}

- (NSString *)headerRefreshingText
{
    return MJRefreshHeaderStateRefreshingText;
}

- (NSString *)footerIdleText
{
    return MJRefreshFooterStateIdleText;
}

- (NSString *)footerRefreshingText
{
    return MJRefreshFooterStateRefreshingText;
}

- (NSString *)footerNoDataText
{
    return MJRefreshFooterStateNoMoreDataText;
}

@end
