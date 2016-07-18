//
//  YJProductsCollectionViewCell.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/26.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJProductsCollectionViewCell.h"

#import "YJDetailViewController.h"

@interface YJProductsCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *pic;
@property (nonatomic, weak) IBOutlet UIImageView *yijiaView;
@property (nonatomic, weak) IBOutlet UILabel *titleLb;
@property (nonatomic, weak) IBOutlet UILabel *priceLb;
@property (nonatomic, weak) IBOutlet UILabel *originPriceLb;
@end

@implementation YJProductsCollectionViewCell
- (void)awakeFromNib
{
    self.titleLb.preferredMaxLayoutWidth = self.bounds.size.width-20;
}
#pragma  mark - getter setter
- (void)setProduct:(YJProduct *)product
{
    _product = product;
    NSString *URLString = product.coverurl;
    [self.pic setImageWithURL:[NSURL URLWithString:URLString]];
    self.yijiaView.hidden=product.yijia;
    
    self.titleLb.text = product.name;
    self.priceLb.text = [NSString stringWithFormat:@"%ld",product.price];
    NSAttributedString *attributeString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",product.originprice] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSStrikethroughStyleAttributeName: @1}];
    
    self.originPriceLb.attributedText = attributeString;
}
- (IBAction)touchCell:(id)sender
{
    YJDetailViewController *detail = [[YJDetailViewController alloc] init];
    detail.product = self.product;
    [[self currentViewController].navigationController pushViewController:detail animated:YES];
}


@end
