//
//  ViewController.m
//  SheJiaApp
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "WZResultViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
//    _muarr =[[NSMutableArray alloc]init];
//    [_muarr addObject:@"1"];
//    NSLog(@"%d",[_muarr count]);
//    ResultViewController *resultview=[[ResultViewController alloc]init];
//     _searchCon=[[UISearchController alloc]initWithSearchResultsController:resultview];
//    _searchCon .searchResultsUpdater=self;
//    _searchCon.searchBar.delegate=self;
//    _searchCon.searchBar.frame=CGRectMake(0, 0, 320, 44);
//    resultview.block=^{
//        [_searchCon.searchBar resignFirstResponder];
//    };
//    
//    _tab.tableHeaderView=_searchCon.searchBar;
//    NSLog(@"%@",_searchCon.searchBar.frame);
//
//}
//- (void)filterData:(NSString *)text{
//    ResultViewController *result=(ResultViewController *)_searchCon.searchResultsController;
//    if (text.length!=0) {
////        NSPredicate *pre=[NSPredicate predicateWithFormat:@"name contains [cd]%@",text];
////        result.resultMuArr=[_muarr filteredArrayUsingPredicate:pre];
//        result.resultMuArr=_muarr;
//        
//    }else{
//        result.resultMuArr=_muarr;
//        result.view.hidden=YES;
//        
//        
//    }
//    [result.tab reloadData];
//}
//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//    [self filterData:searchController.searchBar.text];
//    
//}
//- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
//    [self filterData:searchBar.text];
//    
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    
//    return [_muarr count];
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"myCell"];
//    if(!cell){
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
//    }
//    cell.textLabel.text=_muarr[indexPath.row];
//    return cell;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
