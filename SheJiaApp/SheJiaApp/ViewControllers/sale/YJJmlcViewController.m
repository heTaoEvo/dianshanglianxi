//
//  YJJmlcViewController.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/30.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJJmlcViewController.h"
#import "YJWebViewController.h"
#import "YJSaleViewController.h"

@interface YJJmlcViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *bgImg;

@property (nonatomic, weak) IBOutlet UIButton *saleBtn;

@property (nonatomic, weak) IBOutlet UIView *actionView;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *actionHeight;

@property (nonatomic,weak) IBOutlet UIButton *alreadyBtn;

@property (nonatomic,weak) IBOutlet UIButton *ptxyBtn;



@property (nonatomic, strong) IBOutlet UIView *shadowView;

@end

@implementation YJJmlcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavigationBar];
    [self initTabBar];
    [self initbgImg];
    [self initSaletn];
    [self initAlreadyBtn];
    [self initPtxyBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Methods
- (void)initNavigationBar
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_yongjin"] style:UIBarButtonItemStylePlain target:self action:@selector(touchRightItem:)];
    rightItem.tintColor = [UIColor grayColor];
    
    self.navigationItem.rightBarButtonItem = rightItem;

    self.navigationController.navigationBar.backgroundColor = NavColor;
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:@"寄卖流程" attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20], NSForegroundColorAttributeName : TitleColor}];
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = attributeStr;
    label.textAlignment = NSTextAlignmentCenter;
    label.bounds = CGRectMake(0, 0, 200, 44);
    self.navigationItem.titleView = label;
}
- (void)initTabBar
{
    [self.tabBarController.tabBar hiddenTabBarWithAnimation];
}
- (void)initbgImg
{
    [self currentDeviceVerssion];
}
- (void)initSaletn
{
    self.saleBtn.layer.cornerRadius = 5;
    [self.saleBtn addTarget:self action:@selector(touchSaleBtn) forControlEvents:UIControlEventTouchUpInside];
}
- (void)initAlreadyBtn
{
    self.alreadyBtn.tag = 1;
    [self.alreadyBtn setImage:[UIImage imageNamed:@"check_active"] forState:UIControlStateNormal];
    [self.alreadyBtn addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)initPtxyBtn
{
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:@"平台寄卖协议" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:9],NSUnderlineStyleAttributeName : @1, NSForegroundColorAttributeName : TitleColor}];
    [self.ptxyBtn setAttributedTitle:attribute forState:UIControlStateNormal];
    [self.ptxyBtn addTarget:self action:@selector(touchPtxyBtn) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark Event Responder
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)touchRightItem:(id)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"您的专属推荐码为(%@)",@"NULL"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        YJWebViewController *tuijianVC = [[YJWebViewController alloc] init];
        tuijianVC.name = @"佣金规则";
        tuijianVC.url = YONGJIN_URL;
        [self.navigationController pushViewController:tuijianVC animated:YES];
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)touchSaleBtn
{
    [self addSaleView];
    [self.actionView setNeedsUpdateConstraints];
    [self.actionView updateConstraintsIfNeeded];
    [UIView animateWithDuration:.5 animations:^{
        self.actionHeight.constant = -80;
        [self.actionView layoutIfNeeded];
    }];
}
- (void)changeState:(UIButton *)btn
{
    if(btn.tag)
    {
        btn.tag = 0;
        [self.alreadyBtn setImage:[UIImage imageNamed:@"check_icon"] forState:UIControlStateNormal];
    }
    else
        [self initAlreadyBtn];
}
- (void)touchPtxyBtn
{
    YJWebViewController *ptxyVC = [[YJWebViewController alloc] init];
    ptxyVC.name = @"平台寄卖协议";
    ptxyVC.url = PTXY_URL;
    [self.navigationController pushViewController:ptxyVC animated:YES];
}
- (void)addSaleView
{
    [self.actionView  setNeedsUpdateConstraints];
    [self.actionView updateConstraintsIfNeeded];
    self.actionHeight.constant = 0;
    [self.actionView layoutIfNeeded];

    self.shadowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.shadowView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.85];
    [self.view addSubview:self.shadowView];
}
- (IBAction)touchCatagory:(UIButton *)btn
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    YJSaleViewController *sale = [storyboard instantiateViewControllerWithIdentifier:@"YJSaleViewController"];
    
    sale.catagory = btn.tag;
    
    [self.navigationController pushViewController:sale animated:YES];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)gue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)currentDeviceVerssion
{
    CGRect rect = self.view.bounds;
    if( CGRectEqualToRect(rect, IPHONE4))
        {
            [self.bgImg setImage:[UIImage imageNamed:@"sale_process_iphone4"]];
            return 4;
        }
        else if(    CGRectEqualToRect(rect, IPHONE5))
        {
            [self.bgImg setImage:[UIImage imageNamed:@"sale_process_iphone5"]];
            return 5;
        }
        else
        {
            [self.bgImg setImage:[UIImage imageNamed:@"sale_process"]];
            return 6;
        }
}

@end
