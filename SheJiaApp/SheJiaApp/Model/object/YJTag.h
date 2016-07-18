//
//  YJTag.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/27.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJTag : JSONModel

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *bannerurl;

@property (nonatomic, assign) NSInteger starttime;

@property (nonatomic, assign) NSInteger endtime;

@property (nonatomic, assign) NSInteger currenttime;

@end
