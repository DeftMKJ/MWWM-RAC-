//
//  MKJDemoViewController.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJDemoViewController.h"
#import "MKJDemoTableViewCell.h"
#import <ReactiveCocoa.h>

@interface MKJDemoViewController ()

@end

@implementation MKJDemoViewController
@dynamic viewModel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLayout];
    [self setupBinding];
    [self setupData];
}

- (void)setupLayout
{
    [super setupLayout];
    @weakify(self);
    [RACObserve(self.viewModel, isNeedRefresh) subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            [self.tableView reloadData];
        }
    }];
    
}

- (void)setupBinding
{
    [super setupBinding];
    @weakify(self)
    [self.viewModel sendRequest:^(id entity) {
        @strongify(self);
        [self hideLoadingViewFooter];
        [self.tableView reloadData];
        
    } failure:^(NSUInteger errCode, NSString *errorMsg) {
        
    }];
}


- (void)setupData
{
    [super setupData];
}

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MKJDemoTableViewCell class];
}


/**
 上下拉刷新的回调， YES是下拉刷新  NO上拉加载更多
 */
- (void)pullTableViewRequestData:(BOOL)isRefresh
{
    // 下拉刷新的额时候重新刷新pagecount为0
    if (isRefresh) {
        [self.viewModel initRequestPullPage];
    }
    [self setupBinding];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel tableViewDidSelectedRowAtIndexPath:indexPath];
}





@end
