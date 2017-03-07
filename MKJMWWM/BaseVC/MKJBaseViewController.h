//
//  MKJBaseViewController.h
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKJBaseViewModel.h"

@interface MKJBaseViewController : UIViewController

// baseVC的基础ViewModel
@property (nonatomic,strong,readonly) MKJBaseViewModel *viewModel;

/**
 唯一初始化方法

 @param viewModel 传入ViewModel
 @return 实例化控制器对象
 */
- (instancetype)initWithViewModel:(MKJBaseViewModel *)viewModel;

/**
 布局UI
 */
- (void)setupLayout;

/**
 请求网络数据 绑定数据
 */
- (void)setupBinding;

/**
 设置数据回调，点击事件处理
 */
- (void)setupData;

@end
