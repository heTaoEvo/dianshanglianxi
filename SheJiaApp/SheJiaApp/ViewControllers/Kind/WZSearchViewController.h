//
//  WZSearchViewController.h
//  SheJiaApp
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface WZSearchViewController : ViewController
@property (weak, nonatomic) IBOutlet UITableView *tab;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)LeftBtn:(UIButton *)sender;
- (IBAction)RightBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;


@end
