//
//  MKJTableViewCellViewModel.h
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseViewModel.h"
#import <ReactiveCocoa.h>
typedef NSNumber * _Nonnull (^MKJTableCellViewModelCalculateBlock)();

@interface MKJTableViewCellViewModel : MKJBaseViewModel

@property (nonatomic,strong,readonly,nullable) id entity; // cellViewModel会绑定一个entity实例对象

@property (nonatomic,strong,nullable) NSNumber *rowHeight; // 每个cellViewModel里面有一个实体，然后还有一个字段计算高度，缓存


/**
 cell点击的信号量监听
 */
@property (nonatomic,strong,nullable) RACSubject *cellSelectedSignal;

// cellViewModel的初始化
- (nullable instancetype)initWithEntity:(nullable id)entity;

- (NSNumber *_Nonnull)cacheCellHeightWithCalculateBlock:(_Nonnull MKJTableCellViewModelCalculateBlock)calculateHeightBlock;

@end
