//
//  MKJDemoTableViewCellViewModel.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJTableViewCellViewModel.h"
#import "MKJDemoEntity.h"

@interface MKJDemoTableViewCellViewModel : MKJTableViewCellViewModel

@property (nonatomic,strong,readonly) MKJTopicModel *entity;

// 返回发布文本
- (NSString *)publishTopicContent;

- (NSString *)headerImageURL;

- (NSString *)name;

- (NSString *)createTime;

- (NSNumber *)hotCommnetHeight;

- (NSNumber *)totalHeight;

@end
