//
//  MKJBaseView.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/1.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseView.h"

@interface MKJBaseView ()

@property (nonatomic,strong) MKJBaseViewModel *viewModel;

@end

@implementation MKJBaseView

- (instancetype)initWithFrame:(CGRect)frame viewModel:(MKJBaseViewModel *)viewModel
{
    self = [super initWithFrame:frame];
    if (self) {
        _viewModel = viewModel;
        [self setupLayout];
        [self setupBinding];
        [self setupData];
    }
    return self;
}

- (void)setupLayout{}

- (void)setupData{}

- (void)setupBinding{}

@end
