//
//  UIView+YJView.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/29.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "UIView+YJView.h"

@implementation UIView (YJView)
- (UIViewController *)currentViewController//获取当前view的viewcontroller
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
@end
