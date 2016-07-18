//
//  WZQuanBuPinPaiViewController.m
//  SheJiaApp
//
//  Created by Mac on 16/6/28.
//  Copyright © 2016年 Mac. All rights reserved.
//
#import <AFNetworking.h>
#import "WZQuanBuPinPaiViewController.h"
#import "WZQuanBuPinPaiTableViewCell.h"
#import <UIKit+AFNetworking.h>
#import "WZTag.h"
#import "WZResultViewController.h"
@interface WZQuanBuPinPaiViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic,strong)NSMutableArray *PinPaiarr,*PinPaiImageArr;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic ,strong)NSString *keyWord;

@end

@implementation WZQuanBuPinPaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.keyWord=@"0";
    [self requestData];
    self.navigationController.navigationBarHidden=YES;
    // Do any additional setup after loading the view from its nib.
    self.PinPaiarr = [[NSMutableArray alloc]init];
    self.PinPaiImageArr= [[NSMutableArray alloc]init];
    [_PinPaiarr addObject:@"其他品牌"];
    for (int i=32; i>0; i--) {
        NSString *str=[NSString stringWithFormat:@"brandicon_%d",i];
        [_PinPaiarr addObject:str];
    }

    NSLog(@"%@",_TagArr);
    _tab.rowHeight=100;

    
    
    
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden=NO;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_TagArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSError *err = nil;
    WZTag *tag = [[WZTag alloc] initWithDictionary:_TagArr[indexPath.row] error:&err];
    NSLog(@"%@",err);
    WZQuanBuPinPaiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"QuanBuPinPaiCell"];
    if(!cell){
        cell=[[NSBundle mainBundle]loadNibNamed:@"WZQuanBuPinPaiTableViewCell" owner:nil options:nil][0];
    }
   
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue:tag.name forKey:tag.id];
    [defaults synchronize];
    [cell.imaView setImageWithURL:[NSURL URLWithString:tag.picurl]];
    cell.MyLab.text=tag.name;
    //[cell.imaView setImageWithURL:self.dic]
    return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WZTag *tag = [[WZTag alloc] initWithDictionary:_TagArr[indexPath.row] error:nil];
    self.block(tag.id);
    self.block2 (tag.name);
    NSLog(@"tag.id======%@",tag.id);
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)requestData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *dic = @{@"keyword" : self.keyWord};
    [manager POST:TAGS_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"正在加载");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"加载成功");
        _TagArr = [[NSMutableArray alloc] init];
        _TagArr = responseObject[@"tags"];
        [self.tab reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - searchbar Delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.keyWord=searchText;
    [self requestData];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)GoBackBtn:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
