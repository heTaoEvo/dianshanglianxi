//
//  WZXiangBaoViewController.m
//  SheJiaApp
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "WZXiangBaoViewController.h"
#import "WZXiangBaoTableViewCell.h"
@interface WZXiangBaoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *FenleiArr;
@end

@implementation WZXiangBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    // Do any additional setup after loading the view from its nib.
    self.FenleiArr=[[NSArray alloc]initWithObjects:@"全部分类",@"箱包",@"鞋履",@"配饰",@"腕表",@"首饰",@"小皮具", nil];
    
};

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_FenleiArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WZXiangBaoTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"XiangBaoCell"];
    if(!cell){
        cell=[[NSBundle mainBundle]loadNibNamed:@"WZXiangBaoTableViewCell" owner:nil options:nil][0];
    }
    cell.textLabel.text=_FenleiArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.block(indexPath.row);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)initNavigationBar
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"全部分类" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : TitleColor}];
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = attributeStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.bounds = CGRectMake(0, 0, 200, 44);
    self.navigationItem.titleView = label;
    
}
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
