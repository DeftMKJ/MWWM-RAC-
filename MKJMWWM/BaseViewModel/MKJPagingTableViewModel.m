//

//  MKJPagingTableViewModel.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJPagingTableViewModel.h"

@interface MKJPagingTableViewModel ()

@property (nonatomic,strong) NSNumber *currentPage; // 当前页面
@property (nonatomic,strong) NSString *currentMaxTime; // 加载下一页需要的字段
@property (nonatomic,assign) BOOL isNeedHiddenFooter; // 根据totalcount判断是否需要进行footer的隐藏

@end


@implementation MKJPagingTableViewModel

- (void)setupData
{
    [super setupData];
    [self initRequestPullPage];
}

- (void)initRequestPullPage{
    self.currentPage = @(0);
    self.currentMaxTime = @"";
}

- (void)handlePagingEntities:(NSArray *)entities totalCount:(NSNumber *)totalCount cellViewModelClass:(Class)cellViewModelClass maxTime:(NSString *)maxTime;
{
    if ([self.currentPage isEqualToNumber:@0]) {
        [self.cellViewModels removeAllObjects];
    }
    [self handleMutableArrayEntites:entities cellViewModelClass:cellViewModelClass];
    self.isNeedHiddenFooter = !(totalCount.integerValue > self.cellViewModels.count);
    self.currentPage = @(self.currentPage.integerValue + 1);
    self.currentMaxTime = maxTime;
}


@end
