//
//  WZFenLeiViewController.m
//  SheJiaApp
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "WZFenLeiViewController.h"
#import "WZTableViewCell.h"

@interface WZFenLeiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *muarr;
@property (nonatomic,strong)NSArray *data;
@end

@implementation WZFenLeiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.muarr=[[NSMutableArray alloc]init];
    for (int i=1; i<7; i++) {
        NSString *str=[NSString stringWithFormat:@"iconcatagory_%d",i];
        [_muarr addObject:str];
        
    }
    _tab.rowHeight=SCREEN_HEIGHT/3.8;
    _tab.separatorStyle=NO;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_muarr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WZTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"WZCell"];
    if(!cell){
        cell=[[NSBundle mainBundle]loadNibNamed:@"WZTableViewCell" owner:nil options:nil][0];
    }
    
    cell.imaView.image=[UIImage imageNamed:_muarr[indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WZFenLeiXiangQingViewController *XiangQingView=[[WZFenLeiXiangQingViewController alloc]init];
    
    XiangQingView.str=[NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    XiangQingView.order=@"0";
    XiangQingView.delegate=self;
    [self.navigationController pushViewController:XiangQingView animated:YES];
    
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

@end
