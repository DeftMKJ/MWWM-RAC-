//
//  MKJPagingTableViewModel.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJTableViewModel.h"

@interface MKJPagingTableViewModel : MKJTableViewModel

@property (nonatomic,strong,readonly) NSNumber *currentPage;
@property (nonatomic,strong,readonly) NSString *currentMaxTime;
@property (nonatomic,assign,readonly) BOOL isNeedHiddenFooter;


/**
 下拉刷新的回调实现在控制器中，判断是否isRefresh来进行是否把currentPage清0
 */
- (void)initRequestPullPage;

/**
 它的父类有一个方法是给cellModels根据entity加载出不同的cellViewModel 这里包装一层再次通过current的page来进行更改

 @param entities 请求回来的实体数组
 @param totalCount 总数量
 @param cellViewModelClass cellViewModel类型 初始化用
 */
- (void)handlePagingEntities:(NSArray *)entities
                  totalCount:(NSNumber *)totalCount
          cellViewModelClass:(Class)cellViewModelClass
                     maxTime:(NSString *)maxTime;


@end
