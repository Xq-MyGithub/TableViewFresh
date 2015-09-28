//
//  ViewController.m
//  TableViewFresh
//
//  Created by qianfeng on 15/9/26.
//  Copyright (c) 2015年 xq. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+EXT.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *testTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.testTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

    [self.testTableView addHeaderFreshViewWithBeginRefresh:^{
        NSLog(@"下拉刷新数据  下载中。。。。。");
    }];
    [self.testTableView addFooterFreshViewWithBeginRefresh:^{
        NSLog(@"上拉加载更多   下载中。。。。。");
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"标题";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((int)indexPath.row%2 == 1) {
        [tableView stopFooterRefresh];
    }
    else{
        [tableView stopHeaderRefresh];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
