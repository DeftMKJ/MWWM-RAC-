//
//  MKJBaseViewModel.m
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseViewModel.h"

@interface MKJBaseViewModel ()

@property (nonatomic,assign) BOOL isSucceed;
@property (nonatomic,copy) NSString *messgae;
@property (nonatomic,copy) NSString *resultCode;
@property (nonatomic,copy) NSString *title;

@end

@implementation MKJBaseViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupData];
    }
    return self;
}


- (void)setupData
{
    // 默认给个成功  demo效果
    _isSucceed = YES;
    _messgae = @"宓珂璟的MWWM+RAC Demo";
}

- (void)setupBinding{}

- (NSString *)title
{
    return nil;
}

- (void)sendRequest:(MKJRequestSucceed)succeedBlock failure:(MKJRequestFailure)failBlock
{
    // 子类自己实现数据请求
}

@end
