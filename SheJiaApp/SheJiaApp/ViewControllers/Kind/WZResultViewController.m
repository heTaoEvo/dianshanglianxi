//
//  WZResultViewController.m
//  SheJiaApp
//
//  Created by peace on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "WZResultViewController.h"
#import "YJProduct.h"
#import "YJProductsCollectionViewCell.h"
@interface WZResultViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate>
@property (nonatomic,strong)NSArray *productArray;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,strong)NSString *order,*index;

@end

@implementation WZResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
self.order=@"1";
    NSLog(@"%@",self.order);
    self.dic=@{@"page":@"0",@"keyword":self.searchStr,@"order":self.order};
    _Collection.backgroundColor = [UIColor whiteColor];
    [_Collection registerNib:[UINib nibWithNibName:@"YJProductsCollectionViewCell" bundle:[NSBundle mainBundle]]forCellWithReuseIdentifier:@"ProductsCell"];
    self.navigationController.navigationBarHidden=NO;
    
   
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%d",self.order);
    [self initNavigationBar];
    [self requestData];
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
- (void)sheetView{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"推荐",@"最新发布",@"价格最低",@"价格最高", nil];
    [actionSheet showInView:self.view];
    
};
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex<4) {
        self.order=[NSString stringWithFormat:@"%d",buttonIndex];
    }
    
    NSLog(@"%@",self.order);
   self.dic=@{@"page":@"0",@"keyword":self.searchStr,@"order":self.order};
    [self requestData];
}
- (void)initNavigationBar
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = backItem;
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_order"] style:UIBarButtonItemStylePlain target:self action:@selector(sheetView)];
    searchItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    self.automaticallyAdjustsScrollViewInsets =NO;

    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"搜索结果" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : TitleColor}];
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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Cell_Width, Cell_Height);
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
