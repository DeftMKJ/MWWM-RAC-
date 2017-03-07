//
//  MKJBaseModel.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseModel.h"

@interface MKJBaseModel ()

@property (nonatomic,strong) MKJHttpHelper *httpHelper; // 网络请求对象，每个Model有拥有一个

@end

@implementation MKJBaseModel

- (RACSignal *)getRequestWithURLString:(NSString *)URLString
                  parametersDictionary:(NSDictionary *)paraterDictionary
                     parserEntityClass:(Class)parseEntityClass
{
    // 根据异步请求创建一个新的RACSinal
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        
        [self.httpHelper getRequestWithUrlString:URLString
                             parametersDictonary:paraterDictionary
                                     entityClass:parseEntityClass
                                   completeBlock:^(id data) {
                                       [subscriber sendNext:data];
                                       [subscriber sendCompleted];
        }];
        
        return nil;
    }];
}

- (MKJHttpHelper *)httpHelper
{
    if (_httpHelper == nil) {
        _httpHelper = [[MKJHttpHelper alloc] init];
    }
    return _httpHelper;
}


@end
