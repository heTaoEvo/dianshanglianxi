//
//  WZTuiJianPaiXuViewController.h
//  SheJiaApp
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZTuiJianPaiXuViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tab;
@property (nonatomic,copy)void(^block)(NSInteger);

@end
