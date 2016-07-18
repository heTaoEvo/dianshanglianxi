//
//  YJHomeViewController.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/24.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJHomeViewController.h"
#import "YJProductsCollectionViewCell.h"
#import "YJSpecialViewController.h"
#import "YJCheckOutViewController.h"
#import "YJDetailViewController.h"
#import "YJWebViewController.h"


#import "YJSearchView.h"
#import "YJHomePage.h"
#import <math.h>



@interface YJHomeViewController () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) YJHomePage *homePageData;


@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *heightContraint;

@property (nonatomic,weak) IBOutlet UIView *nilView;

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (weak, nonatomic) IBOutlet UIScrollView *bannerScroll;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;

@property (weak, nonatomic) IBOutlet UIImageView *actionImg;

@property (weak, nonatomic) IBOutlet UIScrollView *tagScroll;

@property (weak, nonatomic) IBOutlet UICollectionView *productView;

@property (nonatomic, strong) NSDictionary *responseObject;

@property (nonatomic, strong) MJRefreshNormalHeader *header;


@end

@implementation YJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timer=[NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(repeatBanner) userInfo:nil repeats:YES];
    _products = [[NSMutableArray alloc] init];
    _page = 0;
    __weak typeof(self) ws = self;
    
    _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSLog(@"下拉刷新了");
        ws.page = 0;

        [ws requstData];
    }];
    // 此行代码就是添加下拉刷新 下拉刷新时会执行blcok
    [_header setTitle:@"下拉" forState:MJRefreshStateIdle];
    [_header setTitle:@"松手刷新" forState:MJRefreshStatePulling];
    [_header setTitle:@"刷新中" forState:MJRefreshStateRefreshing];
    
    self.scroll.mj_header = _header;
    self.scroll.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉加载了");
        ws.page ++;
        [ws requstData];
    }];
    [self initNavigation];
    [ws requestFrontPageData];

    [self requstData];
}
- (void)setConstainsInCollectionView
{
    self.heightContraint.constant = ([self.products count]+1)/2*Cell_Height+64+39;
    [self.productView setNeedsUpdateConstraints];
    // update constraints now so we can animate the change
    [self.productView updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.4 animations:^{
        [self.productView layoutIfNeeded];
    }];
}
- (void)viewWillLayoutSubviews
{
    //因为从searchview出来的时候让scrollerview的拖动属性改变了，不然不能拖动了。
    self.productView.alwaysBounceVertical = YES;
    self.scroll.alwaysBounceVertical =YES;
//    self.scroll.contentSize = CGSizeMake(SCREEN_WIDTH, 5*SCREEN_WIDTH);
    [self.productView registerNib:[UINib nibWithNibName:@"YJProductsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductsCell"];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
    [self actionImgLoad];
    [self initTabBar];

    [self bannerScrollLoad];
    [self tagScrollLoad];
    [_header beginRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Methods
- (void)initNavigation
{
    //设置navigation的右边item为搜索框，并添加事件
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_search"] style:UIBarButtonItemStylePlain target:self action:@selector(searchView)];
    searchItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = searchItem;
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_title"]];
    [self.navigationItem setTitleView:titleView];
}
- (void)initTabBar
{
    [self.tabBarController.tabBar displayTabBarWithAnimation];
}
//弹出搜索框
- (void)searchView
{
    YJSearchView *searchView = [[NSBundle mainBundle] loadNibNamed:@"YJHomeViewController" owner:self options:nil][1];//从xib文件获取searchView
    [self.view addSubview:searchView];//添加到父视图上
    
    //添加约束,显示满屏
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    //隐藏导航条。tabbar
    self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
- (void)requstData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:PRODUCT_URL parameters:@{@"page" : [NSString stringWithFormat:@"%ld",(long)_page] , @"sectorid" : @"0"} progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"加载中");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *result = responseObject[@"products"];

        [_header endRefreshing];
        if(_page==0)
        {
            self.products = [NSMutableArray arrayWithArray:result];
            // 结束下拉刷新状态
            [self.productView.mj_header endRefreshing];
        }
        else
        {
            [self.products addObjectsFromArray:result];
            [self.productView.mj_footer endRefreshing];
        }
        [self setConstainsInCollectionView];
        [self.productView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
- (void)requestFrontPageData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"app" : @"0"};
    [manager POST:HOME_URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"正在加载");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"加载成功");
        [_header endRefreshing];
        [self.scroll.mj_footer endRefreshing];
        NSError* err = nil;
        self.homePageData = [[YJHomePage alloc] initWithDictionary:responseObject
                                                             error:&err];
        if(err)
        {
            NSLog(@"%@",err);
        }
        _products = [NSMutableArray arrayWithArray:self.homePageData.products];
        [self bannerScrollLoad];
        
        [self actionImgLoad];
        
        [self tagScrollLoad];
        
 
        [_header endRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];

}

- (void)bannerScrollLoad
{
    NSArray *bannerArray = self.homePageData.banners;
    
    
    self.bannerScroll.pagingEnabled = YES;

    self.bannerScroll.showsVerticalScrollIndicator = NO;
    self.bannerScroll.showsHorizontalScrollIndicator = NO;
    
    self.bannerScroll.delegate = self;
    
    self.bannerScroll.contentSize = CGSizeMake(bannerArray.count*SCREEN_WIDTH,self.bannerScroll.frame.size.height );
    for(int i =0; i < bannerArray.count; i++)
    {
        
        NSError* err = nil;
        YJBanner *banner = [[YJBanner alloc] initWithDictionary:bannerArray[i] error:&err];
        if(err)
        {
            NSLog(@"%@",err);
        }
        
        CGRect imageFrame = CGRectMake(i*SCREEN_WIDTH, 0, self.bannerScroll.frame.size.width, self.bannerScroll.frame.size.height);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        
        NSString *imageURL = banner.picurl;

        [imageView setImageWithURL:[NSURL URLWithString:imageURL]];
        
        [self.bannerScroll addSubview:imageView];
        
        //在上面放透明按钮
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.backgroundColor = [UIColor clearColor];
        
        btn.frame = imageFrame;
        
        btn.tag = [banner.sectorid integerValue];
        
        [btn addTarget:self action:@selector(touchBanner:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bannerScroll addSubview:btn];
        
    }
    //放入一个pagecontroll
    self.pageControll.numberOfPages = bannerArray.count;
    self.pageControll.backgroundColor = [UIColor clearColor];
    
    [self.scroll bringSubviewToFront:self.pageControll];
    
}
- (void)repeatBanner
{
    CGFloat x = _bannerScroll.contentOffset.x;
    x+=SCREEN_WIDTH;
    if(x>=self.bannerScroll.contentSize.width)
    {
        x=0;
    }
    [self.bannerScroll setContentOffset:CGPointMake(x, 0) animated:YES];
    self.pageControll.currentPage =x/SCREEN_WIDTH ;
}
- (void)actionImgLoad
{
    NSArray *imageArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"frontpage_icon_1"],
                           [UIImage imageNamed:@"frontpage_icon_2"],
                           [UIImage imageNamed:@"frontpage_icon_3"],
                           [UIImage imageNamed:@"frontpage_icon_2"],nil];
    [self.actionImg setAnimationImages:imageArray];
    [self.actionImg setAnimationDuration:1];
    [self.actionImg setAnimationRepeatCount:NSIntegerMax];
    [self.actionImg startAnimating];
}
- (void)tagScrollLoad
{
    NSArray *tagArray = self.homePageData.tags;
    self.tagScroll.showsVerticalScrollIndicator = NO;
    self.tagScroll.showsHorizontalScrollIndicator = NO;
    CGFloat imageWidth = 1.0/3*SCREEN_WIDTH;
    self.tagScroll.contentSize = CGSizeMake(pandding +(imageWidth+pandding)*tagArray.count, self.tagScroll.bounds.size.height);
    
    for(int i = 0;i < tagArray.count; i++)
    {
        NSError* err = nil;
        YJTag *tag = [[YJTag alloc] initWithDictionary:tagArray[i] error:&err];
        if(err)
        {
            NSLog(@"%@",err);
        }
        CGRect imageFrame = CGRectMake(pandding+i*(imageWidth+pandding), 0, imageWidth, self.tagScroll.bounds.size.height);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
        
        NSString *imageURL = tag.bannerurl;
        
        [imageView setImageWithURL:[NSURL URLWithString:imageURL]];
        
        [self.tagScroll addSubview:imageView];
        
        //添加lbael
        CGFloat titleHeigh=20;
        UILabel *titleLb = [[UILabel alloc] init];
        titleLb.frame = CGRectMake(0, imageFrame.size.height-titleHeigh, imageFrame.size.width,titleHeigh);
        titleLb.backgroundColor = ShadowColor;
        [titleLb setTextAlignment:NSTextAlignmentCenter];
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:tag.name attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSBackgroundColorAttributeName:[UIColor clearColor],NSForegroundColorAttributeName : [UIColor whiteColor]}];
        titleLb.attributedText = attributeStr;
        [imageView addSubview:titleLb];
        
        //在上面放透明按钮
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.backgroundColor = [UIColor clearColor];
        
        btn.frame = imageFrame;
        
        btn.tag = [tag.id integerValue];
        
        btn.titleLabel.text = tag.name;
        
        [btn addTarget:self action:@selector(touchBanner:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tagScroll addSubview:btn];
    }
}
- (void)productViewLoad
{
    [self.productView registerNib:[UINib nibWithNibName:@"YJProductsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ProductsCell"];
}

- (void)refresh
{



}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YJDetailViewController *detail = [[YJDetailViewController alloc] init];
    detail.product = [[YJProduct alloc] initWithDictionary:_products[indexPath.row] error:nil];
    [self.navigationController pushViewController:detail animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Cell_Width, Cell_Height);
}


#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    YJProductsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductsCell" forIndexPath:indexPath];
    if(!cell)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"YJHomeViewController" owner:self options:nil][2];
    }
    NSError* err = nil;
    YJProduct *product = [[YJProduct alloc] initWithDictionary:_products[indexPath.row] error:&err];
    if(err)
    {
        NSLog(@"ddd%@",err);
    }
    
    cell.product = product;
    cell.backgroundColor=[UIColor whiteColor];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.products count];
}


#pragma mark - UIScrollerViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == self.bannerScroll)
        self.pageControll.currentPage = self.bannerScroll.contentOffset.x/SCREEN_WIDTH;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView.tag == 2)
    {
        if(self.scroll.contentOffset.y+SCREEN_HEIGHT-44-20>=self.scroll.contentSize.height)
        {
//            NSLog(@"到底部了");
//            [self.scroll.mj_footer beginRefreshing];
            
        }
        if(self.scroll.contentOffset.y<0)
        {
//            NSLog(@"到顶部了");
            
        }
    }

}


#pragma mark - Getter




#pragma mark - Event Responder
- (void)touchBanner:(UIButton *)btn
{
    YJSpecialViewController *specialVC = [[YJSpecialViewController alloc] init];
    specialVC.sectorid = [NSString stringWithFormat:@"%ld",(long)btn.tag];
    NSString *text = btn.titleLabel.text;
    NSString *title = (btn.tag>=90)?@"专柜商品":text;
    if(btn.tag == 38)
        title = @"卖家急售";
    specialVC.name = title;
    
    [self.navigationController pushViewController:specialVC animated:YES];
}
- (IBAction)touchActionImage:(UIButton *)btn
{
    switch (btn.tag) {
        case 1:
        {
            YJCheckOutViewController *checkOutVC = [[YJCheckOutViewController alloc] init];
            checkOutVC.test = @"ddd";
            [self.navigationController pushViewController:checkOutVC animated:YES];
        }
            break;
        case 38:
        {
            [self touchBanner:btn];
        }
            break;
        case 3:
        {
            YJWebViewController *offlineStore = [[YJWebViewController alloc] init];
            offlineStore.name = @"线下实体";
            offlineStore.url = OFFLINE_URL;
            [self.navigationController pushViewController:offlineStore animated:YES];
        }
            break;
        case 4:
        {
            YJWebViewController *offlineStore = [[YJWebViewController alloc] init];
            offlineStore.name = @"交易帮助";
            offlineStore.url = BUSINESSHELP_URL;
            [self.navigationController pushViewController:offlineStore animated:YES];
        }

            break;
            
        default:
            break;
    }
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
