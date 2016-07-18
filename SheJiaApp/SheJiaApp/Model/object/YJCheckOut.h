//
//  YJCheckOut.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/28.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJCheckOut : JSONModel

@property (nonatomic, assign) NSInteger totalnum;

@property (nonatomic, strong) NSArray *validates;

@property (nonatomic, strong) NSString *previous_cursor;

@property (nonatomic, strong) NSString *next_cursor;

@property (nonatomic, strong) NSString *total_number;


@end
