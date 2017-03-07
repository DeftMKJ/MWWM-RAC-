//
//  MKJTableViewModelService.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/2.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKJBaseViewController.h"

@protocol MKJTableViewModelService <NSObject>

- (MKJBaseViewController *)tableViewDidSelectedRowAtIndexPath:(NSIndexPath *)indexPath;

@end
