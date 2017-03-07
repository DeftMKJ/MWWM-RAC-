//
//  MKJHttpHelper.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MKJRequestFinishBlock)(id data);

@interface MKJHttpHelper : NSObject

/**
 网络请求类
 
 @param urlString URL
 @param parametrersDict 参数
 @param entityClass 请求玩之后的返回实体类
 @param completeBlock 回调Block
 */
- (void)getRequestWithUrlString:(NSString *)urlString
            parametersDictonary:(NSDictionary *)parametrersDict
                    entityClass:(Class)entityClass
                  completeBlock:(MKJRequestFinishBlock)completeBlock;


@end
