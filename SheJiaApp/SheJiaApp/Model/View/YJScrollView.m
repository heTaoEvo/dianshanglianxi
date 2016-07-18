//
//  YJScrollView.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJScrollView.h"


@implementation YJScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentSize = frame.size;
        //设置缩放最小比例 CGFloat类型 默认为1.0
        self.minimumZoomScale = 0.2;
        //设置缩放最大比例 CGFloat类型 默认为1.0
        self.maximumZoomScale = 2.0;
        
        //点击状态栏时scrollView是否滚动到顶部 默认为YES
        
        self.bounces = NO;
        self.zoomScale = 1.0;

        
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.tapCount==2)
    {
        CGFloat zoomScale = self.zoomScale;
        //三木运算符  <表达式1>?<表达式2>:<表达式3>; "?"运算符的含义是: 先求表达式1的值, 如果为真, 则执行表达式2，并返回表达式2的结果 ; 如果表达式1的值为假, 则执行表达式3 ，并返回表达式3的结果.
        zoomScale = zoomScale==1.0?2.0:1.0;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        //改变缩放比例
        self.zoomScale = zoomScale;
        [UIView commitAnimations];
    }
}
@end
