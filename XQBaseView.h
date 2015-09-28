//
//  XQBaseView.h
//  TableViewFresh
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 xq. All rights reserved.
//

#import <UIKit/UIKit.h>
enum XQFreshViewStatus{
    XQFreshViewStatusBeginDrag,
    XQFreshViewStatusReleseToDrag,
    XQFreshViewStatusFreshing,
};

typedef enum XQFreshViewStatus XQFreshViewStatus;
typedef void(^BeginRefreh)();

@interface XQBaseView : UIView
{
    XQFreshViewStatus _status;
    UIScrollView *_scrollview;
    BeginRefreh _beginRefresh;
    __weak UIButton *_alertButtonView;
    __weak UIView *_loadingView;
}

@property(nonatomic, assign)XQFreshViewStatus status;

@property(nonatomic, strong)UIScrollView *scrollview;

@property(nonatomic, strong)void(^beginRefresh)();

@property(nonatomic,weak)UIButton * alertButtonView;

@property(nonatomic,weak)UIView * loadingView;

@end
