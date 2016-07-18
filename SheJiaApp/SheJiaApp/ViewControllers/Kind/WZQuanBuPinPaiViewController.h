//
//  WZQuanBuPinPaiViewController.h
//  SheJiaApp
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZQuanBuPinPaiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tab;
- (IBAction)GoBackBtn:(UIButton *)sender;
@property (nonatomic,strong)NSMutableArray *TagArr;
@property (nonatomic,copy)void(^block)(NSString *);
@property (nonatomic,copy)void(^block2)(NSString *);

@property (weak, nonatomic) IBOutlet UISearchBar *PinPaiSearchBar;

@end
