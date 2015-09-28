//
//  XQFooterView.m
//  TableViewFresh
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 xq. All rights reserved.
//

#import "XQFooterView.h"
@interface XQFooterView()

//@property(nonatomic,weak)UIButton * alertButtonView;
//@property(nonatomic,weak)UIView * loadingView;
@end

@implementation XQFooterView


-(void)stopRefresh{
    if(self.status != XQFreshViewStatusFreshing){
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        _scrollview.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }];
}


- (UIButton *)alertButtonView
{
    if (_alertButtonView == nil)
    {
        //1.创建对象
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //2.建立父子关系
        [self addSubview:btn];
        //3.Frame
        btn.frame = self.bounds;
        //4.保存成员变量值
        _alertButtonView = btn;
        //5.其他属性设置
        //btn setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    }
    return _alertButtonView;
}


- (UIView *)loadingView
{
    if (_loadingView == nil)
    {
        //1.
        UIView * loadingView = [UIView new];//[[UIView alloc] init];
        //2.
        [self addSubview:loadingView];
        _loadingView = loadingView;
        loadingView.frame = self.bounds;
        
        
        //创建子控件
        UILabel * labelTitle = [UILabel new];
        [loadingView addSubview:labelTitle];
        labelTitle.text = @"正在读取";
        labelTitle.frame = loadingView.bounds;
        labelTitle.textColor = [UIColor blackColor];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView addSubview:activity];
        activity.frame = CGRectMake(50, 20, 40, 40);
        [activity startAnimating];
    }
    return _loadingView;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    
    [self willMoveToSuperview:_scrollview];
    if (_scrollview.isDragging) {
        
        CGFloat maxY  = _scrollview.contentSize.height - _scrollview.frame.size.height;
        CGFloat footerViewHeight = self.frame.size.height;
        
        if (_scrollview.contentOffset.y >= maxY && _scrollview.contentOffset.y < maxY + footerViewHeight)
        {
            [self setStatus:XQFreshViewStatusBeginDrag];
        }
        else if(_scrollview.contentOffset.y > maxY + footerViewHeight)
        {
            [self setStatus:XQFreshViewStatusReleseToDrag];
        }
    }
    else{
        if (self.status == XQFreshViewStatusReleseToDrag)
        {
            [self setStatus:XQFreshViewStatusFreshing];
            _scrollview.contentInset = UIEdgeInsetsMake(0, 0, self.frame.size.height, 0);
        }
    }
}


-(void)setStatus:(XQFreshViewStatus)status{
    
    _status = status;
    switch (status) {
        case XQFreshViewStatusBeginDrag:
            self.alertButtonView.hidden = NO;
            self.loadingView.hidden = YES;
            [self.alertButtonView setTitle:@"拖拽读取更多" forState:UIControlStateNormal];
            NSLog(@"上拉加载更多");
            break;
        case XQFreshViewStatusReleseToDrag:
            NSLog(@"松开读取更多");
            [self.alertButtonView setTitle:@"松开读取更多" forState:UIControlStateNormal];
            break;
        case XQFreshViewStatusFreshing:
            self.loadingView.hidden = NO;
            self.alertButtonView.hidden = YES;
            self.beginRefresh();
            NSLog(@"加载中");
            break;
            
        default:
            break;
    }

}

+(id)footerView{
    
    return [[self alloc]init];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
    UITableView * tableView = (UITableView *)newSuperview;
    CGFloat selfX = 0;
    CGFloat selfY = tableView.contentSize.height;
    CGFloat selfW = tableView.frame.size.width;
    CGFloat selfH = 60;
    self.frame = CGRectMake(selfX, selfY, selfW, selfH);
    self.backgroundColor = [UIColor yellowColor];

}
@end
