//
//  WZZhuCeSecondTableViewCell.m
//  SheJiaApp
//
//  Created by peace on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "WZZhuCeSecondTableViewCell.h"

@implementation WZZhuCeSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)SecBtn:(UIButton *)sender {
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"(╯‵□′)╯︵┻━┻" message:@"敬请期待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alt show];
}
@end
