//
//  YJSpecialViewController.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/27.
//  Copyright © 2016年 阳剑. All rights reserved.
//
#import "YJSpecialViewController.h"
#import "YJProductsCollectionViewCell.h"

@interface YJSpecialViewController () <UICollectionViewDelegate,UICollectionViewDataSource>


@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong)  NSArray *productArray;

@end

@implementation YJSpecialViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"YJProductsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductsCell"];
    [self initNavigationBar];
    [self hiddenTabBarItems];
    [self requestData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Methods
- (void)requestData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:SPECIAL_URL parameters:@{@"sectorid" : _sectorid, @"page" : PAGE} progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"正在加载special页面");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        _productArray = responseObject[@"products"];
        [self.collectionView reloadData];
 
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载成功");
    }];
}
- (void)initNavigationBar
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:self.name attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : TitleColor}];
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = attributeStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.bounds = CGRectMake(0, 0, 200, 44);
    self.navigationItem.titleView = label;

}
- (void)hiddenTabBarItems
{
    [self.tabBarController.tabBar hiddenTabBarWithAnimation];
}
#pragma mark Event Responder
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - UICollectionViewDataSource 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _productArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YJProductsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductsCell" forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[YJProductsCollectionViewCell alloc] init];
    }
    NSError* err = nil;
    YJProduct *product = [[YJProduct alloc] initWithDictionary:_productArray[indexPath.row] error:&err];
    if(err)
    {
        NSLog(@"ddd%@",err);
    }
    
    cell.product = product;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Cell_Width, Cell_Height);
}



#pragma mark - getter setter
- (void)setSectorid:(NSString *)sectorid
{
    _sectorid = sectorid;
}
- (void)setName:(NSString *)name
{
    _name = name;
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
