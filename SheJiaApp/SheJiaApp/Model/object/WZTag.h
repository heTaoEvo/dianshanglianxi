//
//  WZTag.h
//  SheJiaApp
//
//  Created by peace on 16/6/30.
//  Copyright © 2016年 lxy . All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZTag : JSONModel
@property (nonatomic,strong)NSString *id;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *picurl;
@property (nonatomic,assign)NSInteger isfollowing;
@end
