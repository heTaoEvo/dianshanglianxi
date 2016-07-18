//
//  YJSaleShadow.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/30.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJSaleShadow.h"

#import "YJSaleViewController.h"

@interface  YJSaleShadow ()

@property (nonatomic, weak) IBOutlet UIView *actionView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *actionHeight;


@end
@implementation YJSaleShadow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
    self.actionHeight.constant = 0;

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self removeFromSuperview];
}
@end
