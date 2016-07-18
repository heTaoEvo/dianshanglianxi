//
//  YJValidate.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/28.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJUser.h"
@interface YJValidate : JSONModel

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) YJUser *user;

@property (nonatomic, strong) NSArray *photourls;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) NSString *commentnum;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *shareurl;

@end
