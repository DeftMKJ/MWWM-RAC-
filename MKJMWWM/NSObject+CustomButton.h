//
//  NSObject+CustomButton.h
//  MKJMWWM
//
//  Created by mintou on 2017/3/2.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (CustomButton)

- (UIButton *)creatButtonWithTitle:(NSString *)title
                             image:(UIImage *)image
                               gap:(CGFloat)gap;

@end
