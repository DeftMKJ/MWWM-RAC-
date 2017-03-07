//
//  MKJDemoViewModel.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJDemoViewModel.h"
#import "MKJDemoModel.h"
#import "MKJDemoEntity.h"
#import "MKJDemoTableViewCellViewModel.h"
#import <FBShimmeringView.h>

@interface MKJDemoViewModel ()

/**
 每个ViewModel都有一个Model用来请求输出   请求的数据通过带过去的class生成对应的模型返回，组装给entity（完整的模型数据赋值）
 */
@property (nonatomic,strong) MKJDemoModel *model;
@property (nonatomic,strong) MKJTopicRoot *entity;

@end

@implementation MKJDemoViewModel


- (void)setupData
{
    [super setupData];
    _model = [[MKJDemoModel alloc] init];
}


- (void)sendRequest:(MKJRequestSucceed)succeedBlock failure:(MKJRequestFailure)failBlock
{
    [[self.model requestDemoDatasWithPage:[self.currentPage integerValue] maxTime:self.currentMaxTime] subscribeNext:^(id data) {
        if (data) {
            self.entity = data;
            [self handlePagingEntities:self.entity.list
                            totalCount:@(self.entity.info.count)
                    cellViewModelClass:[MKJDemoTableViewCellViewModel class]
                               maxTime:self.entity.info.maxtime];
        }
        !succeedBlock ? : succeedBlock(data);
    }];
}


- (NSInteger)numberOfRowInSection:(NSInteger)section
{
    return self.cellViewModels.count;
}

- (MKJTableViewCellViewModel *)cellViewModelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellViewModels[indexPath.row];
}

- (CGFloat)heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)viewForHeaderInSection:(NSInteger)section
{
    
    FBShimmeringView *fbView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    fbView.shimmering = YES;
    fbView.shimmeringOpacity = 0;
    fbView.shimmeringBeginFadeDuration = 0.3;
    fbView.shimmeringEndFadeDuration = 2;
    fbView.shimmeringAnimationOpacity = 0.6;
    fbView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:fbView.bounds];
    label.text = @"MVVM & RAC";
    label.textColor = [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:25];
    label.backgroundColor = [UIColor clearColor];
    fbView.contentView = label;
    
    
    return fbView;
}


- (MKJBaseViewController *)tableViewDidSelectedRowAtIndexPath:(NSIndexPath *)indexPath
{
    MKJDemoTableViewCellViewModel *cellViewModel = self.cellViewModels[indexPath.row];
    cellViewModel.entity.love += 1;
    cellViewModel.entity.cai += 1;
    cellViewModel.entity.repost += 1;
    cellViewModel.entity.comment += 1;
    // 调用setter，RAC外部能监听到并刷新tableView
    self.isNeedRefresh = YES;
    return nil;
}


@end
