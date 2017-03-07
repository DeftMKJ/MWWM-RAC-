//
//  MKJDemoModel.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseModel.h"
#import <ReactiveCocoa.h>

@interface MKJDemoModel : MKJBaseModel

- (RACSignal *)requestDemoDatasWithPage:(NSInteger)pageNum maxTime:(NSString *)maxTime;
@end
