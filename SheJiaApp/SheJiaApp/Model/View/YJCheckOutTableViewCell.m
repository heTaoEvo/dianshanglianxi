//
//  YJCheckOutTableViewCell.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/28.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJCheckOutTableViewCell.h"
@interface YJCheckOutTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *pic1;

@property (nonatomic, weak) IBOutlet UIImageView *pic2;

@property (nonatomic, weak) IBOutlet UIImageView *pic3;

@property (nonatomic, weak) IBOutlet UILabel *text;

@property (nonatomic, weak) IBOutlet UILabel *time;

@property (nonatomic, weak) IBOutlet UILabel *comment;

@property (nonatomic, weak) IBOutlet UIImageView *isVerified;





@end


@implementation YJCheckOutTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = NavColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - getter;
- (void)setValidate:(YJValidate *)validate
{
    _validate = validate;
    
    [_pic1 setImageWithURL:[NSURL URLWithString:validate.photourls[0]]];
    
    [_pic2 setImageWithURL:[NSURL URLWithString:validate.photourls[1]]];
    
    [_pic3 setImageWithURL:[NSURL URLWithString:validate.photourls[2]]];
    
    _text.text = validate.text;
    
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    NSInteger currentTime = nowTime - [validate.date integerValue];
    
    
    if(currentTime<3600)
        _time.text = [NSString stringWithFormat:@"%.0f分钟以前",currentTime/60.0];
    else if(currentTime<86400)
        _time.text = [NSString stringWithFormat:@"%.0f小时以前",currentTime/3600.0];
    else
    {
        _time.text = [NSString stringWithFormat:@"%.0f天以前",currentTime/86400.0];
    }
    
    self.isVerified.hidden = validate.status;
    _comment.text = validate.commentnum;

}


@end
