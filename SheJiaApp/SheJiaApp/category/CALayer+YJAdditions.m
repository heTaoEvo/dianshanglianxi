//
//  CALayer+YJAdditions.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "CALayer+YJAdditions.h"

@implementation CALayer (YJAdditions)
-(void)setBorderColorFromUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}
@end
