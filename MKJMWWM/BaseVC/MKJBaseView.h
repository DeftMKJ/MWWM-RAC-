//
//  MKJBaseView.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKJBaseViewModel.h"

@interface MKJBaseView : UIView

@property (nonatomic,strong,readonly) MKJBaseViewModel *viewModel;

- (instancetype)initWithFrame:(CGRect)frame viewModel:(MKJBaseViewModel *)viewModel;

- (void)setupLayout;
- (void)setupBinding;
- (void)setupData;

@end
