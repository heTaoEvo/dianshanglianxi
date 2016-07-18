//
//  WZFenLeiXiangQingViewController.h
//  SheJiaApp
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "WZFenLeiXiangQingViewController.h"
@protocol WZFenLeiXiangQingViewControllerDelegate <NSObject>
@end

@interface WZFenLeiXiangQingViewController : ViewController
@property (weak, nonatomic) IBOutlet UIButton *QuanBuPinPaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *TuiJianPaiXuBtn;
@property (nonatomic,strong)NSString *str,*order;
@property (weak, nonatomic) IBOutlet UIButton *XiangBaoBtn;
@property (weak, nonatomic) IBOutlet UICollectionView *Collection;
- (IBAction)QuanBuPinPaiBtn:(UIButton *)sender;
- (IBAction)XiangBaoBtn:(UIButton *)sender;
- (IBAction)TuiJianPaiXuBtn:(UIButton *)sender;
@property (weak, nonatomic)id<WZFenLeiXiangQingViewControllerDelegate>delegate;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,strong)NSString *brandid;
@property (nonatomic,strong)NSString *QBName;
@end
