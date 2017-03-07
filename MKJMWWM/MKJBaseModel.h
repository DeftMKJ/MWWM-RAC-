//
//  MKJBaseModel.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKJHttpHelper.h"
#import <ReactiveCocoa.h>

@interface MKJBaseModel : NSObject

- (RACSignal *)getRequestWithURLString:(NSString *)URLString
                  parametersDictionary:(NSDictionary *)paraterDictionary
                     parserEntityClass:(Class)parseEntityClass;

@end
