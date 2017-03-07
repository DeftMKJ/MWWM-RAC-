//
//  MKJDemoViewController.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJPagingTableViewController.h"
#import "MKJDemoViewModel.h"
@interface MKJDemoViewController : MKJPagingTableViewController


/**
 每个控制器都有一个ViewModel  用来请求网络，tableview的数据源处理以及cellViewModel的组装
 */
@property (nonatomic,strong,readonly) MKJDemoViewModel *viewModel;

@end
