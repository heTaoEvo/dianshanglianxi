//
//  WZZhuCeViewController.m
//  SheJiaApp
//
//  Created by peace on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "WZZhuCeViewController.h"
#import "WZZhuCeTableViewCell.h"
#import "WZZhuCeSecondTableViewCell.h"
@interface WZZhuCeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WZZhuCeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    // Do any additional setup after loading the view from its nib.
    _tab.rowHeight=80;
    _tab.separatorStyle=NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row!=1) {
        WZZhuCeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ZhuCeCell"];
        if(!cell){
            cell=[[NSBundle mainBundle]loadNibNamed:@"WZZhuCeTableViewCell" owner:nil options:nil][0];
        }
        if (indexPath.row==0) {
            cell.ZhuceLeftImg.image=[UIImage imageNamed:@"login_icon_mobile"];
            cell.ZhuceTF.placeholder=@"请输入手机号码";
        }if (indexPath.row==2) {
            cell.ZhuceLeftImg.image=[UIImage imageNamed:@"login_icon_passwd"];
            cell.ZhuceTF.placeholder=@"6-16位密码";
        }if (indexPath.row==3) {
            cell.ZhuceLeftImg.image=[UIImage imageNamed:@"login_icon_username_selected"];
            cell.ZhuceTF.placeholder=@"昵称（中英文、数字、符号）";
        }
        
        
return cell;
    }
    else{
        WZZhuCeSecondTableViewCell *cell=[[NSBundle mainBundle]loadNibNamed:@"WZZhuCeSecondTableViewCell" owner:nil options:nil][0];
        
return cell;
    }
    
    
}
- (void)initNavigationBar
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"注册" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : TitleColor}];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)WanchengZhuceBtn:(UIButton *)sender {
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"[]~(￣▽￣)~*" message:@"敬请期待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alt show];
}

- (IBAction)LijiDengluBtn:(UIButton *)sender {
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"_(:з」∠)_" message:@"敬请期待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alt show];
}

- (IBAction)gouBtn:(UIButton *)sender {
    UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"(╯‵□′)╯︵┻━┻" message:@"别点了这是个假的" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [alt show];

}
@end
