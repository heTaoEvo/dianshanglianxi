//
//  YJDetailView.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/29.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJDetailView.h"

@interface YJDetailView ()

@property (nonatomic, strong) YJDetailViewController *detailVC;

@end

@implementation YJDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib
{
   _detailVC=(YJDetailViewController *)[self currentViewController];
    self.product = _detailVC.product;
}
- (void)setProduct:(YJProduct *)product
{
    _product = product;
    
}


@end
