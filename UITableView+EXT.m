//
//  UITableView+EXT.m
//  TableViewFresh
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 xq. All rights reserved.
//

#import "UITableView+EXT.h"
#import <objc/runtime.h>
#import "XQFooterView.h"
#import "XQHeaderView.h"

@interface UITableView()

@property(nonatomic, weak)XQFooterView *footerView;
@property(nonatomic, weak)XQHeaderView *headerView;

@end

@implementation UITableView (EXT)

static char headerKey;
static char footerKey;

-(void)addFooterFreshViewWithBeginRefresh:(void (^)())beginrefresh{
    self.footerView = nil;
    XQFooterView *footerView = [XQFooterView footerView];
    footerView.scrollview = self;
    footerView.beginRefresh = beginrefresh;
    self.footerView = footerView;
}

-(void)addHeaderFreshViewWithBeginRefresh:(void (^)())beginrefresh{
    XQHeaderView *headerView = [XQHeaderView headerView];
    headerView.scrollview = self;
    headerView.beginRefresh = beginrefresh;
    self.headerView = headerView;
}

-(void)stopHeaderRefresh{
    if (self.headerView == nil) {
        return;
    }
    [self.headerView stopRefresh];
}

-(void)stopFooterRefresh{
    if (self.footerView == nil) {
        return;
    }
    [self.footerView stopRefresh];
}

-(void)setHeaderView:(XQHeaderView *)headerView{
    objc_setAssociatedObject(self, &headerKey, headerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(XQHeaderView *)headerView{
    return objc_getAssociatedObject(self, &headerKey);
}

-(void)setFooterView:(XQFooterView *)footerView{
    objc_setAssociatedObject(self, &footerKey, footerView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(XQFooterView *)footerView{
    return objc_getAssociatedObject(self, &footerKey);
}

@end
