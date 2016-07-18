//
//  WZZhuCeSecondTableViewCell.h
//  SheJiaApp
//
//  Created by peace on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZZhuCeSecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *SecTF;
@property (weak, nonatomic) IBOutlet UIImageView *SecLeftImg;
@property (weak, nonatomic) IBOutlet UIImageView *SecRightImg;
@property (weak, nonatomic) IBOutlet UIButton *SecBtn;
- (IBAction)SecBtn:(UIButton *)sender;

@end
