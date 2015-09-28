//
//  XQBaseView.m
//  TableViewFresh
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 xq. All rights reserved.
//

#import "XQBaseView.h"

@interface XQBaseView()


@end



@implementation XQBaseView

-(void)setScrollview:(UIScrollView *)scrollview{
    _scrollview = scrollview;
    [_scrollview addSubview:self];
    [scrollview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

@end
