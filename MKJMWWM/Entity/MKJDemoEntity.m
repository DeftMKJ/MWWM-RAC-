//
//  MKJDemoEntity.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJDemoEntity.h"

@implementation MKJTopicRoot

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"list" : MKJTopicModel.class
             };
}


@end

@implementation MKJTopicInfo


@end

@implementation MKJTopicModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"top_cmt" : MKJHotCommnetModel.class
                 };
}

@end

@implementation MKJHotCommnetModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{
             @"username":@"user.username"
             };
}

@end


