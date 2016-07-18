//
//  WZFenLeiViewController.h
//  SheJiaApp
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "WZFenLeiXiangQingViewController.h"
@interface WZFenLeiViewController : ViewController<WZFenLeiXiangQingViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tab;

@end
