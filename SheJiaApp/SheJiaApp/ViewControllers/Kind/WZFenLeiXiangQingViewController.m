//
//  WZFenLeiXiangQingViewController.m
//  SheJiaApp
//
//  Created by Mac on 16/6/27.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "WZFenLeiXiangQingViewController.h"
#import "WZFenLeiXiangQingCollectionViewCell.h"
#import "WZQuanBuPinPaiViewController.h"
#import "WZXiangBaoViewController.h"
#import "WZTuiJianPaiXuViewController.h"
#import "YJProduct.h"
#import "YJProductsCollectionViewCell.h"
@interface WZFenLeiXiangQingViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *productArray,*arr,*paixuArr;
@property (nonatomic,strong)NSMutableArray *PingPaiarr;

@end

@implementation WZFenLeiXiangQingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self requestData];
    self.PingPaiarr=[[NSMutableArray alloc]init];
    self.arr = [[NSArray alloc]initWithObjects:@"全部分类",@"箱包",@"鞋履",@"配饰",@"腕表",@"首饰",@"小皮具" ,nil];
    self.paixuArr=[[NSArray alloc]initWithObjects:@"推荐排序",@"最新发布",@"价格最低",@"价格最高", nil];
    if (!_QBName) {
        _QBName = @"全部品牌";
    }
        _order = @"0";
    _Collection.backgroundColor = [UIColor whiteColor];
    [_Collection registerNib:[UINib nibWithNibName:@"YJProductsCollectionViewCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:@"ProductsCell"];
    self.navigationController.navigationBarHidden=NO;
    
    
    int num=[self.str intValue];
    [self.XiangBaoBtn setTitle:_arr[num] forState:UIControlStateNormal];
    
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"--------%@----------",self.str);
    NSLog(@"%@",self.brandid);
//    if (self.brandid!=nil) {
//        self.dic = @{@"page" : DEFAULT,@"catagory":self.str,@"order":self.order,@"brandid":self.brandid};
//        
//    }else{
//        self.dic = @{@"page" : DEFAULT,@"catagory":self.str,@"order":self.order};
//    }
    if ([self.str intValue]==0&&[self.brandid intValue]!=0) {
        self.dic=@{@"page" : DEFAULT,@"order":self.order,@"brandid":self.brandid};
    }
    if ([self.brandid intValue]==0&&[self.str intValue]!=0) {
        self.dic=@{@"page" : DEFAULT,@"order":self.order,@"catagory":self.str};
    }
    if ([self.str intValue]==0&&
        [self.brandid intValue]==0) {
        self.dic = @{@"page" : DEFAULT,@"order":self.order};
    }
    if([self.str intValue]!=0&&
       [self.brandid intValue]!=0){
        self.dic=@{@"page" : DEFAULT,@"catagory":self.str,@"order":self.order,@"brandid":self.brandid};
    }
//    if ([self.str intValue]==0) {
//        self.dic = @{@"page" : DEFAULT,@"order":self.order};
//    }
    
    
    
    [self initNavigationBar];
    [self.XiangBaoBtn setTitle:_arr[[self.str intValue]] forState:UIControlStateNormal];
    [self.TuiJianPaiXuBtn setTitle:_paixuArr[[self.order intValue]] forState:0];
    [self.QuanBuPinPaiBtn setTitle:_QBName forState:UIControlStateNormal];
    [self requestData];
    
    NSLog(@"%@",self.str);
    [self.Collection reloadData];
    
}


- (void)initNavigationBar
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:_arr[[self.str intValue]] attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : TitleColor}];
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
#pragma mark - UICollectionViewDataSource
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YJProduct *product = [[YJProduct alloc] initWithDictionary:_productArray[indexPath.row] error:nil];
    
    YJProductsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProductsCell" forIndexPath:indexPath];
    if(!cell){
        cell=[[NSBundle mainBundle]loadNibNamed:@"WZCollectionViewCell" owner:nil options:nil][0];
    }
    cell.product = product;
    return cell;

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _productArray.count;
}
#pragma UICollectionDelegate 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Cell_Width, Cell_Height);
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
#pragma mark - Event Respoder

- (IBAction)QuanBuPinPaiBtn:(UIButton *)sender {
    WZQuanBuPinPaiViewController *view=[[WZQuanBuPinPaiViewController alloc]init];
    view.block= ^(NSString *str){
        self.brandid=str;
    };
    view.block2 = ^(NSString *str){
        self.QBName=str;
    };
    [self.navigationController pushViewController:view animated:YES];
    
}

- (IBAction)XiangBaoBtn:(UIButton *)sender {
    WZXiangBaoViewController *view=[[WZXiangBaoViewController alloc]init];
    view.block=^(NSInteger num){
        self.str=[NSString stringWithFormat:@"%ld",(long)num];
    };
    [self.navigationController pushViewController:view animated:YES];
    
}

- (IBAction)TuiJianPaiXuBtn:(UIButton *)sender {
    WZTuiJianPaiXuViewController *view=[[WZTuiJianPaiXuViewController alloc]init];
    view.block=^(NSInteger num){
        self.order=[NSString stringWithFormat:@"%ld",(long)num];
    };
    [self.navigationController pushViewController:view animated:YES];
    
}
- (void)requestData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
        [manager POST:PRODUCT_URL parameters:_dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"正在加载");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"加载成功");
        _productArray = responseObject[@"products"];
        [self.Collection reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}



@end
