//
//  MKJTableViewCellViewModel.m
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJTableViewCellViewModel.h"

@interface MKJTableViewCellViewModel ()

@property (nonatomic,strong,nullable) id entity;

@end

@implementation MKJTableViewCellViewModel

- (instancetype)initWithEntity:(nullable id)entity
{
    self = [super init];
    if (self) {
        _entity = entity;
        _cellSelectedSignal = [RACSubject subject];
    }
    return self;
}

// cellViewModel来计算高度，通过带返回值的Block，从上层数据拿高度
- (NSNumber *)cacheCellHeightWithCalculateBlock:(MKJTableCellViewModelCalculateBlock)calculateHeightBlock
{
    if (!self.rowHeight) {
        self.rowHeight = calculateHeightBlock();
    }
    return self.rowHeight;
}


@end
