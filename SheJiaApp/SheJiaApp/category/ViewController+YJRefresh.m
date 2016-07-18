//
//  ViewController+YJRefresh.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "ViewController+YJRefresh.h"

@implementation ViewController (YJRefresh)
- (void)refresh:(UITableView *)tableView
{
//    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        NSLog(@"下拉刷新了");
//            }];
//    // 此行代码就是添加下拉刷新 下拉刷新时会执行blcok
//    self.tableView.mj_header = header;
//    
//#pragma mark - 下拉刷新header的一些属性设置
//    // 设置自动切换透明度(在导航栏下面自动隐藏)
//    //header.automaticallyChangeAlpha = YES;
//    // 隐藏时间
//    //header.lastUpdatedTimeLabel.hidden = YES;
//    // 隐藏状态
//    //header.stateLabel.hidden = YES;
//    
//    //    [header setTitle:@"使劲拉" forState:MJRefreshStateIdle];
//    //    [header setTitle:@"该放手了" forState:MJRefreshStatePulling];
//    //    [header setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
//    
//    //状态label
//    //    header.stateLabel
//    
//    //更新时间label
//    //    header.lastUpdatedTimeLabel

}
- (void)gotoLogin
{
    YJLoginViewController *login = [[YJLoginViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
    
}
@end
