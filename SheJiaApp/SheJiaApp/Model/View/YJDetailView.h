//
//  YJDetailView.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/29.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YJDetailViewController.h"

@interface YJDetailView : UIView

@property (nonatomic, weak) IBOutlet UIScrollView *detailImgScroll;

@property (nonatomic, strong) YJProduct *product;

@end
