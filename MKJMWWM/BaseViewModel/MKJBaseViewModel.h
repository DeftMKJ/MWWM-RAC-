//
//  MKJBaseViewModel.h
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MKJRequestSucceed)(id entity);
typedef void(^MKJRequestFailure)(NSUInteger errCode,NSString *errorMsg);

@interface MKJBaseViewModel : NSObject

/**
 请求回调的公共属性
 */
@property (nonatomic,assign,readonly) BOOL isSucceed;
@property (nonatomic,copy,readonly) NSString *messgae;
@property (nonatomic,copy,readonly) NSString *resultCode;


/**
 扩展字段
 */
@property (nonatomic,copy,readonly) NSString *title;

// viewModel初始化的时候默认做一些初始化操作
- (void)setupData;

// 扩展
- (void)setupBinding;

#pragma mark - 请求数据
- (void)sendRequest:(MKJRequestSucceed)succeedBlock failure:(MKJRequestFailure)failBlock;
@end
