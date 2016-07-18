//
//  YJCheckOutViewController.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/28.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJCheckOutViewController.h"
#import "YJCheckOutTableViewCell.h"
#import "YJWebViewController.h"


@interface YJCheckOutViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, strong) YJCheckOut *checkOut;

@end


@implementation YJCheckOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib  nibWithNibName:@"YJCheckOutTableViewCell" bundle:nil] forCellReuseIdentifier:@"CheckOutCell"];
    [self requestData];
    [self initNavigationBar];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 30;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.checkOut.validates.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *validateArray = self.checkOut.validates;
    NSError *err = nil;
    YJValidate *validate = [[YJValidate alloc] initWithDictionary:validateArray[indexPath.row] error:&err];
    if(err)
    {
        NSLog(@"%@",err);
    }
    YJCheckOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckOutCell"];
    if(!cell)
    {
        cell = [[YJCheckOutTableViewCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.validate = validate;
    return cell;
}
#pragma mark -Private Methods
- (void)requestData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:CHECKOUT_URL parameters:@{@"validateid" : DEFAULT} progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"正在加载鉴定浏览页面");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *err = nil;
        NSLog(@"加载鉴定界面完成");
         _checkOut = [[YJCheckOut alloc] initWithDictionary:responseObject error:&err];
        if(err)
        {
            NSLog(@"%@",err);
        }
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self initTableAttribute];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

- (void)initNavigationBar
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation-back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backItem.tintColor = [UIColor grayColor];
    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navi_help"] style:UIBarButtonItemStylePlain target:self action:@selector(touchHelp)];
    rightItem.tintColor = [UIColor grayColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIBarButtonItem *verifiedItem = [[UIBarButtonItem alloc] initWithTitle:@"发鉴定" style:UIBarButtonItemStylePlain target:self action:@selector(touchVerified)];
    [verifiedItem setTitle:@"发鉴定"];
    [verifiedItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName : TitleColor} forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItems:@[rightItem,verifiedItem]];

    
}
- (void)initTableAttribute
{
    //设置table的属性
    self.tableView.estimatedRowHeight=300;
    self.tableView.backgroundColor =NavColor;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    //    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"YJCheckOutViewController" owner:self options:nil][1];
    ////    [header addSubview:view];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"countdown_bg"]];
    [header addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header.mas_centerX);
        make.centerY.equalTo(header.mas_centerY);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.height.equalTo(@(header.bounds.size.height*0.8));
    }];

    UILabel *titleLB = [[UILabel alloc] init];
    titleLB.textAlignment = NSTextAlignmentCenter;
    NSString *titleStr = [NSString stringWithFormat:@"%08ld",(long)self.checkOut.totalnum];
    NSAttributedString *titleAttributeStr = [[NSAttributedString alloc] initWithString:titleStr attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:21], NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
    titleLB.attributedText = titleAttributeStr;
    [titleView addSubview:titleLB];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top);
        make.left.equalTo(titleView.mas_left);
        make.right.equalTo(titleView.mas_right);
        make.bottom.equalTo(titleView.mas_bottom);
    }];
    
    UILabel *firstLB = [[UILabel alloc] init];
//    firstLB.textAlignment = NSTextAlignmentLeft;
    NSString *firstStr = @"已鉴定";
    NSAttributedString *firstAttributeStr = [[NSAttributedString alloc] initWithString:firstStr attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
    firstLB.attributedText = firstAttributeStr;
    [header addSubview:firstLB];
    [firstLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleView.mas_left).offset(-pandding);
        make.centerY.equalTo(header.mas_centerY);
        make.width.equalTo(@(titleView.bounds.size.width/2.0));
        make.height.equalTo(@(header.bounds.size.height*.5));
    }];
    
    UILabel *secondLB = [[UILabel alloc] init];
//    secondLB.textAlignment = NSTextAlignmentLeft;
    NSString *secondStr = @"件物品";
    NSAttributedString *secondAttributeStr = [[NSAttributedString alloc] initWithString:secondStr attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:17], NSForegroundColorAttributeName : [UIColor darkGrayColor]}];
    secondLB.attributedText = secondAttributeStr;
    [header addSubview:secondLB];
    [secondLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView.mas_right).offset(pandding);
        make.centerY.equalTo(header.mas_centerY);
        make.width.equalTo(@(titleView.bounds.size.width/2.0));
        make.height.equalTo(@(header.bounds.size.height*.5));
    }];
    
    
    
    self.tableView.tableHeaderView = header;
}
#pragma mark Event Responder
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchHelp
{
    YJWebViewController *verifiedHelp = [[YJWebViewController alloc] init];
    verifiedHelp.name = @"鉴定必读";
    verifiedHelp.url = VERIFIEDQUSTION_URL;
    [self.navigationController pushViewController:verifiedHelp animated:YES];
}
- (void)touchVerified
{
    
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
