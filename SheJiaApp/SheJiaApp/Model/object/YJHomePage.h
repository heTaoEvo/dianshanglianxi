//
//  YJHomePage.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/27.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJBanner.h"
#import "YJSector.h"
#import "YJTag.h"
#import "YJProduct.h"

@interface YJHomePage : JSONModel

@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSArray *sectors;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSArray *products;

@end
