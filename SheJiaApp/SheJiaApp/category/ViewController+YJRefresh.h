//
//  ViewController+YJRefresh.h
//  SheJiaApp
//
//  Created by 阳剑 on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "ViewController.h"
#import "YJLoginViewController.h"


@interface ViewController (YJRefresh)

- (void)refresh:(UITableView *)tableView;

- (void)gotoLogin;

@end
