//
//  MKJBaseEntity.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseEntity.h"
#import <YYModel.h>

@implementation MKJBaseEntity

+ (instancetype)parserEntityWithDictionary:(NSDictionary *)dictionary
{
    if (!dictionary || ![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return [self yy_modelWithDictionary:dictionary];
}

@end
