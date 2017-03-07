//
//  MKJTableViewController.h
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseViewController.h"
#import "MKJTableViewModel.h"

@interface MKJTableViewController : MKJBaseViewController
// 每个VC对应的ViewModel
@property (nonatomic,strong,readonly) MKJTableViewModel *viewModel;
@property (nonatomic,strong,readonly) UITableView *tableView;


@property (nonatomic,assign,readonly) BOOL isRefresh;



@property (nonatomic,assign) BOOL hideFooterLoadingMore;

- (void)endHeaderRefresh;
- (void)endFooterRefresh;


/**
 子类实现，进行数据的请求  binding
 */
- (void)pullTableViewRequestData:(BOOL)isRefresh;


- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
