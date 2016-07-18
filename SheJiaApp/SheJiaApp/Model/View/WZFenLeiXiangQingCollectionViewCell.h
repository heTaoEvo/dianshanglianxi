//
//  WZFenLeiXiangQingCollectionViewCell.h
//  SheJiaApp
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJProduct.h"
@interface WZFenLeiXiangQingCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imaView;
@property (nonatomic, strong) YJProduct *product;

@end
