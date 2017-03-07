//
//  MKJBaseEntity.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface MKJBaseEntity : NSObject <YYModel>

+ (instancetype)parserEntityWithDictionary:(NSDictionary *)dictionary;

@end
