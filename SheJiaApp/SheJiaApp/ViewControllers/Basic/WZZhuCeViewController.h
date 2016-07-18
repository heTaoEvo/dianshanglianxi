//
//  WZZhuCeViewController.h
//  SheJiaApp
//
//  Created by peace on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZZhuCeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tab;
- (IBAction)WanchengZhuceBtn:(UIButton *)sender;
- (IBAction)LijiDengluBtn:(UIButton *)sender;
- (IBAction)gouBtn:(UIButton *)sender;

@end
