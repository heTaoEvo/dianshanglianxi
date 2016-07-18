//
//  YJProduct.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/27.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJProduct : JSONModel

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *sector_id;

@property (nonatomic, strong) NSString *coverurl;

@property (nonatomic, strong) NSArray *pictures;

@property (nonatomic, strong) NSString *intro;

@property (nonatomic, strong) NSString *size;

@property (nonatomic, assign) NSInteger originprice;

@property (nonatomic, assign) NSInteger price;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger stock;

@property (nonatomic, assign) NSInteger yijia;

@property (nonatomic, assign) NSInteger iswish;

@property (nonatomic, strong) NSString *chengse;

@property (nonatomic, strong) NSString *channelcode;














@end
