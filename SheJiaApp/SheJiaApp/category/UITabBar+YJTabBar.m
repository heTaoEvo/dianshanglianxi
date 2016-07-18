//
//  UITabBar+YJTabBar.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/29.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "UITabBar+YJTabBar.h"

@implementation UITabBar (YJTabBar)
- (void)hiddenTabBarWithAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, -78);
    [UIView commitAnimations];
}
- (void)displayTabBarWithAnimation
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.5];
    self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    [UIView commitAnimations];
}
@end
