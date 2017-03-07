//
//  MKJTableViewModel.m
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJTableViewModel.h"

@interface MKJTableViewModel ()

@property (nonatomic,strong) NSMutableArray *cellViewModels;

@end

@implementation MKJTableViewModel

- (UITableViewStyle)tableViewStyle
{
    return UITableViewStylePlain;
}

- (UITableViewCellSelectionStyle)tableViewCellSelectionStyle
{
    return UITableViewCellSelectionStyleNone;
}

- (void)handleMutableArrayEntites:(NSArray *)entities cellViewModelClass:(Class)cellViewModelClass
{
    NSMutableArray *cellViewModes = [NSMutableArray array];
    [entities enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [cellViewModes addObject:[[cellViewModelClass alloc] initWithEntity:obj]];
    }];
    [self.cellViewModels addObjectsFromArray:cellViewModes];
}


/**
 调用下父类的方法
 */
- (void)setupData
{
    [super setupData];
}


#pragma mark - tableView的代理方法实现
// 默认是一个section
- (NSInteger)numberOfSections
{
    return 1;
}

/**
 子类必须实现（每个section多少rows）
 */
- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    @throw [NSException exceptionWithName:@"抽象方法未实现"
                                   reason:[NSString stringWithFormat:@"%@ 必须实现抽象方法 %@",[self class],NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

/**
 headerView的默认是没有的
 */
- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UIView *)viewForHeaderInSection:(NSInteger)section
{
    return nil;
}


/**
 子类必须实现（返回数据请求回来之后放在cellViewModels数组里面的每个cell对应的cellViewModel）
 */
- (MKJTableViewCellViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    @throw [NSException exceptionWithName:@"抽象方法未实现"
                                   reason:[NSString stringWithFormat:@"%@ 必须实现抽象方法 %@",[self class],NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSMutableArray *)cellViewModels
{
    if (_cellViewModels == nil) {
        _cellViewModels = [[NSMutableArray alloc] init];
    }
    return _cellViewModels;
}
























@end
