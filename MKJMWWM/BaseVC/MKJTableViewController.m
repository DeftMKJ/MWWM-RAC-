//
//  MKJTableViewController.m
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJTableViewController.h"
#import <Masonry.h>
#import <ReactiveCocoa.h>
#import <MJRefresh.h>
#import "MKJBaseTableViewCell.h"

@interface MKJTableViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView; // 实例化的tableView
@property (nonatomic,assign) BOOL isRefresh;


@end

@implementation MKJTableViewController
@dynamic viewModel;

// 调用父类的方法进行初始化ViewModel的传递
- (instancetype)initWithViewModel:(MKJBaseViewModel *)viewModel
{
    return [super initWithViewModel:viewModel];
}

// tableViewController setupLayout进行UI布局，继承他的子类再调用
- (void)setupLayout
{
    [super setupLayout];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:[self.viewModel tableViewStyle]];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    @weakify(self);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.edges.equalTo(self.view);
    }];
    
    
    // 添加头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.isRefresh = YES;
        [self pullTableViewRequestData:self.isRefresh];
    }];
    
    
    // 添加尾部刷新控件
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.isRefresh = NO;
        [self pullTableViewRequestData:self.isRefresh];
    }];
    
    self.tableView.mj_header.hidden = NO;
    self.tableView.mj_footer.hidden = YES;
}

- (void)setupBinding
{
    [super setupBinding];
}


/**
 刷新的时候调用该方法，子类实现，进行重写
 */
- (void)pullTableViewRequestData:(BOOL)isRefresh
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (Class)cellClassForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @throw [NSException exceptionWithName:@"抽象方法未实现"
                                   reason:[NSString stringWithFormat:@"%@ 必须实现抽象方法 %@",[self class],NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}


#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel numberOfRowInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self.viewModel heightForHeaderInSection:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [self.viewModel viewForHeaderInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKJBaseTableViewCell *cell = [[self cellClassForRowAtIndexPath:indexPath] cellForTableView:tableView viewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    cell.selectionStyle = [self.viewModel tableViewCellSelectionStyle];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = tableView.rowHeight;
    NSNumber *calculateHeight = [[self cellClassForRowAtIndexPath:indexPath] calculateRowHeightWithViewModel:[self.viewModel cellViewModelForRowAtIndexPath:indexPath]];
    if (calculateHeight) {
        height = calculateHeight.floatValue;
    }
    return height;
    
}



- (void)setHideFooterLoadingMore:(BOOL)hideFooterLoadingMore
{
    _hideFooterLoadingMore = hideFooterLoadingMore;
    self.tableView.mj_footer.hidden = hideFooterLoadingMore;
}


- (void)endFooterRefresh
{
    [self.tableView.mj_footer endRefreshing];
}

- (void)endHeaderRefresh
{
    [self.tableView.mj_header endRefreshing];
}


@end



































