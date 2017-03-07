//
//  NSObject+CustomButton.m
//  MKJMWWM
//
//  Created by mintou on 2017/3/2.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "NSObject+CustomButton.h"


@implementation NSObject (CustomButton)

- (UIButton *)creatButtonWithTitle:(NSString *)title
                             image:(UIImage *)image
                               gap:(CGFloat)gap
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -gap / 2, 0, gap / 2);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, gap / 2, 0 , - gap / 2);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, gap / 2, 0, gap / 2);
    return button;
}
@end
