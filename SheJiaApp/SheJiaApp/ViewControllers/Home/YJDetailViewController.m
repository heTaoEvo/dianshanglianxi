//
//  YJDetailViewController.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/29.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJDetailViewController.h"

#import "YJScanImageViewController.h"
@interface YJDetailViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *detailImgScroll;

@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, weak) IBOutlet UILabel *chengse;

@property (nonatomic ,weak) IBOutlet UILabel *name;

@property (nonatomic, weak) IBOutlet UILabel *productID;

@property (nonatomic, weak) IBOutlet UILabel *price;

@property (nonatomic, weak) IBOutlet UILabel *originPrice;

@property (nonatomic, weak) IBOutlet UILabel *descripe;

@property (nonatomic ,weak) IBOutlet NSLayoutConstraint *pageControlWidth;

@end

@implementation YJDetailViewController

#pragma  mark -lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = NavColor;
    [self layoutSubViews];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)layoutSubViews
{
    [self initNavigationBar];
    [self.tabBarController.tabBar hiddenTabBarWithAnimation];
    [self loadDetailimgScroll];
    [self loadDetailView];
}
#pragma mark - Private Methods
- (void)initNavigationBar
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"contact_service"] style:UIBarButtonItemStylePlain target:self action:@selector(touchRightItem)];
    rightItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"商品详情" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : TitleColor}];
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = attributeStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.bounds = CGRectMake(0, 0, 200, 44);
    self.navigationItem.titleView = label;
}
- (void)loadDetailimgScroll
{
    CGFloat width = SCREEN_WIDTH-2*pandding;
    CGFloat height = SCREEN_WIDTH-2*pandding;
    
    self.detailImgScroll.contentSize = CGSizeMake(width*(_product.pictures.count), height);
    for(int i = 0;i < _product.pictures.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] init];
        [imgView setImageWithURL:[NSURL URLWithString:_product.pictures[i]]];
        imgView.frame = CGRectMake(i*width, 0, width, width);
        [self.detailImgScroll addSubview:imgView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = imgView.frame;
        btn.tag = i;
        [btn addTarget:self action:@selector(touchImg:) forControlEvents:UIControlEventTouchUpInside];
        [self.detailImgScroll addSubview:btn];
    }
    self.pageControl.numberOfPages = _product.pictures.count;
    [self.pageControl setNeedsUpdateConstraints];
    [self.pageControl updateConstraintsIfNeeded];
    self.pageControlWidth.constant = 40/3.0 * _pageControl.numberOfPages;
    [self.pageControl layoutIfNeeded];
}
- (void)loadDetailView
{
    self.chengse.text =@"9成新";
    
    self.name.text = self.product.name;
    
    self.productID.text = [NSString stringWithFormat:@"商品号：%@",self.product.id];
    
    self.price.text = [NSString stringWithFormat:@"%ld",(long)self.product.price];
    
    self.originPrice.text = [NSString stringWithFormat:@"%ld",(long)self.product.originprice];
    
    self.descripe.text = self.product.intro;
    
    self.descripe.preferredMaxLayoutWidth = SCREEN_WIDTH-4*pandding;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%ld",(long)self.detailImgScroll.contentOffset.x);
    self.pageControl.currentPage = self.detailImgScroll.contentOffset.x/(SCREEN_WIDTH-2*pandding);
}



#pragma mark - Event Responder
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchRightItem
{
    CGFloat width = self.detailImgScroll.bounds.size.width;
    CGFloat height = self.detailImgScroll.bounds.size.height;
    self.detailImgScroll.contentSize = CGSizeMake(width*(_product.pictures.count+1), height);
    for(int i = 0;i < _product.pictures.count; i++)
    {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_product.pictures[i]]];
        imgView.frame = CGRectMake(i*width, 0, width, height);
        [self.detailImgScroll addSubview:imgView];
    }
}
//- (void)touchImg:(UIButton *)btn
//{
//    YJScanImageViewController *scanImg =[[YJScanImageViewController alloc] init];
//    [self presentViewController:scanImg animated:YES completion:nil];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*
 - (void)addSubViews
 {
 self.view.backgroundColor = NavColor;
 UIScrollView *mainScroll = [[UIScrollView alloc] init];
 mainScroll.showsHorizontalScrollIndicator = NO;
 mainScroll.showsVerticalScrollIndicator = NO;
 mainScroll.backgroundColor = [UIColor greenColor];
 [self.view addSubview:mainScroll];
 
 UIButton *buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
 buyBtn.backgroundColor = TitleColor;
 [self.view addSubview:buyBtn];
 
 [mainScroll mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.equalTo(self.view.mas_top);
 make.left.equalTo(self.view.mas_left).offset(pandding);
 make.right.equalTo(self.view.mas_right).offset(-pandding);
 make.bottom.equalTo(buyBtn.mas_top);
 }];
 [buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.equalTo(mainScroll.mas_bottom);
 make.left.equalTo(self.view.mas_left).offset(pandding);
 make.right.equalTo(self.view.mas_right).offset(-pandding);
 make.bottom.equalTo(self.view.mas_bottom).offset(-pandding);
 }];
 UIView *showView = [[UIView alloc] init];
 showView.backgroundColor = [UIColor redColor];
 [mainScroll addSubview:showView];
 
 UIView *detailView = [[UIView alloc] init];
 detailView.backgroundColor = [UIColor blackColor];
 [mainScroll addSubview:detailView];
 
 UIImageView *flowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gouwuliucheng"]];
 [mainScroll addSubview:flowImg];
 
 [showView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.equalTo(mainScroll.mas_top);
 make.left.equalTo(mainScroll.mas_left);
 make.right.equalTo(mainScroll.mas_right);
 make.bottom.equalTo(detailView.mas_top).offset(-pandding);
 make.width.equalTo(@(SCREEN_WIDTH-2*pandding));
 make.height.equalTo(showView.mas_width).multipliedBy(1.5);
 }];
 [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
 make.top.equalTo(showView.mas_bottom).offset(pandding);
 make.left.equalTo(mainScroll.mas_left);
 make.right.equalTo(mainScroll.mas_right);
 make.bottom.equalTo(flowImg.mas_top).offset(-pandding);
 make.width.equalTo(@(SCREEN_WIDTH-2*pandding));
 make.height.equalTo(@170);
 }];
 [flowImg mas_makeConstraints:^(MASConstraintMaker *make) {
 
 make.top.equalTo(detailView.mas_bottom).offset(pandding);
 make.left.equalTo(mainScroll.mas_left);
 make.right.equalTo(mainScroll.mas_right);
 make.bottom.equalTo(mainScroll.mas_bottom).offset(78);
 make.width.equalTo(@(SCREEN_WIDTH-2*pandding));
 make.height.equalTo(flowImg.mas_width).multipliedBy(729/1080.0);
 }];
 
 添加展示showview内容约束
UIImageView *titleImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zpbz_header"]];
[showView addSubview:titleImg];
UIScrollView *detailImg = [[UIScrollView alloc] init];
[showView addSubview:detailImg];
UIView *laView = [[UIView alloc] init];
laView.backgroundColor = [UIColor grayColor];
[showView addSubview:laView];
[titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(showView.mas_top);
    make.left.equalTo(showView.mas_left);
    make.right.equalTo(showView.mas_right);
    make.bottom.equalTo(detailImg.mas_top);
    make.width.equalTo(@(SCREEN_WIDTH-pandding*2));
    make.height.equalTo(titleImg.mas_width).multipliedBy(1080/102.0);
}];
[detailImg mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(titleImg.mas_bottom);
    make.left.equalTo(showView.mas_left);
    make.right.equalTo(showView.mas_right);
    make.bottom.equalTo(laView.mas_top);
    make.width.equalTo(@(SCREEN_WIDTH-pandding*2));
    make.height.equalTo(detailImg.mas_width);
}];
[laView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(detailImg.mas_bottom);
    make.left.equalTo(showView.mas_left);
    make.right.equalTo(showView.mas_right);
    make.bottom.equalTo(showView.mas_bottom);
    make.width.equalTo(@(SCREEN_WIDTH-pandding*2));
    make.height.equalTo(laView.mas_width).multipliedBy(5);
}];

}

 */
@end
