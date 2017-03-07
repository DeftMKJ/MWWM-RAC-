//
//  MKJHttpHelper.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJHttpHelper.h"
#import <AFNetworking.h>

@implementation MKJHttpHelper

- (void)getRequestWithUrlString:(NSString *)urlString
            parametersDictonary:(NSDictionary *)parametrersDict
                    entityClass:(Class)entityClass
                  completeBlock:(MKJRequestFinishBlock)completeBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", nil];
    [manager GET:urlString parameters:parametrersDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        id obj = nil;
        SEL sel = NSSelectorFromString(@"parserEntityWithDictionary:");
        if ([entityClass respondsToSelector:sel]) {
            obj = [entityClass performSelector:sel withObject:responseObject];
        }
        !completeBlock ? : completeBlock(obj);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
}


@end
