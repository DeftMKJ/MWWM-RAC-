//
//  PopAnimator.m
//  Popping
//
//  Created by André Schneider on 14.05.14.
//  Copyright (c) 2014 André Schneider. All rights reserved.
//

#import "PresentingAnimator.h"
#import <POP/POP.h>

@implementation PresentingAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // fromView
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;

    // 遮罩
    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
    dimmingView.backgroundColor = [UIColor blackColor];
    dimmingView.layer.opacity = 0.0;

    
    // toView
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.layer.cornerRadius = 10;
    toView.layer.masksToBounds = YES;
    toView.frame = CGRectMake(0,
                              0,
                              CGRectGetWidth(transitionContext.containerView.bounds) - 104.f,
                              CGRectGetHeight(transitionContext.containerView.bounds) - 288.f);
    toView.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);

    [transitionContext.containerView addSubview:dimmingView];
    [transitionContext.containerView addSubview:toView];

    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    positionAnimation.beginTime = CACurrentMediaTime() + 2;
    positionAnimation.toValue = @(transitionContext.containerView.center.y);
    positionAnimation.springBounciness = 5;
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];

    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(2, 2)];

    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.3);

    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
