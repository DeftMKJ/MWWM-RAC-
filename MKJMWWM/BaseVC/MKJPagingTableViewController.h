//
//  MKJPagingTableViewController.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJTableViewController.h"
#import "MKJPagingTableViewModel.h"

@interface MKJPagingTableViewController : MKJTableViewController

@property (nonatomic,strong,readonly) MKJPagingTableViewModel *viewModel;

- (instancetype)initWithViewModel:(MKJPagingTableViewModel *)viewModel;

- (void)hideLoadingViewFooter;

@end
