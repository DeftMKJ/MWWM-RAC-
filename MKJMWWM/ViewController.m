//
//  ViewController.m
//  MKJMWWM
//
//  Created by mintou on 2017/2/28.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "ViewController.h"
#import "MKJDemoViewController.h"
#import "MKJDemoViewModel.h"
#import <Masonry.h>
#import "MKJShowAnimtorViewController.h"
#import "PresentingAnimator.h"
#import "DismissingAnimator.h"
#import <ReactiveCocoa.h>
#import <PNChart.h>
#import "RACViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic,strong) PNRadarChart *radarChart;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"点进去测试下回调再Push";
}

// mvvm + rac 小Demo
- (IBAction)seeDemo:(id)sender {
    
    [self present:nil];
}


// rac简单演示
- (IBAction)seeRacDemo:(id)sender {
    
    RACViewController *vc = [[RACViewController alloc] initWithViewModel:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [PresentingAnimator new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [DismissingAnimator new];
}

- (void)present:(id)sender
{
    MKJShowAnimtorViewController *modalViewController = [MKJShowAnimtorViewController new];
    modalViewController.transitioningDelegate = self;
    modalViewController.modalPresentationStyle = UIModalPresentationCustom;
    @weakify(self);

    
    [self.navigationController presentViewController:modalViewController
                                            animated:YES
                                          completion:NULL];
    
    [modalViewController.subSignal subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"打印一下传递过来的是什么%@",x);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            MKJDemoViewModel *viewModel = [[MKJDemoViewModel alloc] init];
            MKJDemoViewController *demoVC = [[MKJDemoViewController alloc] initWithViewModel:viewModel];
            [self.navigationController pushViewController:demoVC animated:YES];
        });
        
        
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
