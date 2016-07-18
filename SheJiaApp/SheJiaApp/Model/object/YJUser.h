//
//  YJUser.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/28.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YJUser : JSONModel

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *nickname;

@property (nonatomic, strong) NSString *likenum;

@property (nonatomic, strong) NSString *follownum;

@property (nonatomic, strong) NSString *followednum;

@property (nonatomic, strong) NSString *photo;

@property (nonatomic, strong) NSString *isfriend;

@end
