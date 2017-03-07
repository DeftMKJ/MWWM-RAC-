//
//  MKJDemoModel.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJDemoModel.h"
#import "MKJDemoEntity.h"

@implementation MKJDemoModel

- (RACSignal *)requestDemoDatasWithPage:(NSInteger)pageNum maxTime:(NSString *)maxTime
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"list" forKey:@"a"];
    [dict setValue:@"data" forKey:@"c"];
    [dict setValue:@(29) forKey:@"type"];
    if (pageNum > 0) {
        [dict setValue:maxTime forKey:@"maxtime"];
        [dict setValue:@(pageNum) forKey:@"page"];
    }
    return [self getRequestWithURLString:@"http://api.budejie.com/api/api_open.php"
                    parametersDictionary:dict
                       parserEntityClass:[MKJTopicRoot class]];
}

@end
