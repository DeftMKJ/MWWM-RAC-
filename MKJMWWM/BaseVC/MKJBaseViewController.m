//
//  MKJBaseViewController.m
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "MKJBaseViewController.h"

@interface MKJBaseViewController ()

/**
 baseVC的BviewModel，外部只是暴露getter属性
 */
@property (nonatomic,strong) MKJBaseViewModel *viewModel;

@end

@implementation MKJBaseViewController

- (instancetype)initWithViewModel:(MKJBaseViewModel *)viewModel
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // 这里的基类ViewModel实现的title是nil，如果子类实现，就能获取到对应的子类控制器标题
    self.title = self.viewModel.title;
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setupLayout
{
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)setupBinding
{
    
}

- (void)setupData
{
    
}

- (void)dealloc
{
    NSLog(@"%s---dealloc",object_getClassName(self));
}


@end
