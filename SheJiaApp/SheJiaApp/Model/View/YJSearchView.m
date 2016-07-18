//
//  YJSearchView.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/25.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJSearchView.h"
#import "YJHomeViewController.h"

@implementation YJSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)cancel:(id)sender
{
    if([self.searchBar isFirstResponder])
        
        [self endEditing:YES];
    else
    {
        [self viewController].navigationController.navigationBarHidden = NO;
        [self viewController].tabBarController.tabBar.hidden = NO;
        [self removeFromSuperview];
    }

    

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YJHomeViewController *home=(YJHomeViewController *)[self viewController];
    
    home.navigationController.navigationBarHidden = NO;
    home.tabBarController.tabBar.hidden = NO;
    
    [self removeFromSuperview];

}
- (UIViewController *)viewController//获取当前view的viewcontroller
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
