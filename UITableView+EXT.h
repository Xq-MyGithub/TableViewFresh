//
//  UITableView+EXT.h
//  TableViewFresh
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 xq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EXT)
-(void)addFooterFreshViewWithBeginRefresh:(void(^)())beginrefresh;
-(void)addHeaderFreshViewWithBeginRefresh:(void(^)())beginrefresh;

-(void)stopHeaderRefresh;
-(void)stopFooterRefresh;
@end
