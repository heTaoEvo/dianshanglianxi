//
//  WZPinPaiViewController.m
//  SheJiaApp
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "WZPinPaiViewController.h"
#import "WZCollectionViewCell.h"
#import "WZFenLeiXiangQingViewController.h"
@interface WZPinPaiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)NSMutableArray *PingPaiarr;
@end

@implementation WZPinPaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.PingPaiarr=[[NSMutableArray alloc]init];
    for (int i=132; i>=0; i--) {
        NSString *str=[NSString stringWithFormat:@"brandicon_%d",i];
        if ([UIImage imageNamed:str]==nil) {
            continue;
        }
        [_PingPaiarr addObject:str];
    }
    _Collection.backgroundColor = [UIColor whiteColor];
    [_Collection registerNib:[UINib nibWithNibName:@"WZCollectionViewCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:@"GradientCell"];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WZCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GradientCell" forIndexPath:indexPath];
    if(!cell){
        cell=[[NSBundle mainBundle]loadNibNamed:@"WZCollectionViewCell" owner:nil options:nil][0];
    }
    
    cell.imaView.image=[UIImage imageNamed:_PingPaiarr[indexPath.row]];
    
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_PingPaiarr count];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath  {
    self.PPID=[_PingPaiarr [indexPath.row] substringFromIndex:10];
    
    WZFenLeiXiangQingViewController *view=[[WZFenLeiXiangQingViewController alloc]init];
    NSUserDefaults *userDef=[NSUserDefaults standardUserDefaults];
    NSString *userDic=[userDef objectForKey:self.PPID];
    view.QBName=userDic;
    view.brandid=self.PPID;
    
    view.str=@"0";
    NSLog(@"view.id=%@",view.brandid);
   [self.navigationController pushViewController:view animated:YES];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].applicationFrame.size.width/4, [UIScreen mainScreen].applicationFrame.size.height/5);
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
