//
//  WZSearchViewController.m
//  SheJiaApp
//
//  Created by Mac on 16/6/24.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "WZSearchViewController.h"
#import "WZFenLeiViewController.h"
#import "WZPinPaiViewController.h"
#import <Masonry.h>
#import "WZResultViewController.h"
@interface WZSearchViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (nonatomic,strong)ViewController *currentViewController;
@property (nonatomic ,strong)WZFenLeiViewController *fenleiViewController;
@property (nonatomic,strong)WZPinPaiViewController *pinpaiViewController;
@property (nonatomic,strong)UIView *biaojiView;
@property (nonatomic,strong)NSArray *arr;
@end

@implementation WZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        self.fenleiViewController=[[WZFenLeiViewController alloc]initWithNibName:@"WZFenLeiViewController" bundle:nil];
    [self addChildViewController:_fenleiViewController];
    _pinpaiViewController=[[WZPinPaiViewController alloc]initWithNibName:@"WZPinPaiViewController" bundle:nil];
    [self addChildViewController:_pinpaiViewController];
    
    [self.view addSubview:_pinpaiViewController.view];
    [self.view addSubview:_fenleiViewController.view];
    //设置约束，约束view的位置
    
    [self showFrame:_fenleiViewController.view];
    [self showFrame:_pinpaiViewController.view];
    _currentViewController=_fenleiViewController;
    self.biaojiView=[[UIView alloc]initWithFrame:CGRectMake(self.leftBtn.frame.origin.x, self.leftBtn.frame.origin.y+25, self.leftBtn.bounds.size.width, 3)];
    self.biaojiView.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:self.biaojiView];
   
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden=YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
WZResultViewController *view=[[WZResultViewController alloc]init];
view.searchStr=searchBar.text;
[self.navigationController pushViewController:view animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)showFrame:(UIView *)view{
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_rightBtn.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
    }];

}
- (IBAction)LeftBtn:(UIButton *)sender {
    if(_currentViewController!=_fenleiViewController){
        
        self.biaojiView.frame=CGRectMake(sender.frame.origin.x, sender.frame.origin.y+25, sender.bounds.size.width, 3);
    [self transitionFromViewController:_currentViewController toViewController:_fenleiViewController duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
        
    } completion:^(BOOL finished) {
        
    }] ;
    _currentViewController=_fenleiViewController;
    [_currentViewController willMoveToParentViewController:self];
    [_currentViewController didMoveToParentViewController:self];
    [self showFrame:_currentViewController.view];
    }
    
    
}
- (IBAction)RightBtn:(UIButton *)sender {
    if(_currentViewController!=_pinpaiViewController){
        
        self.biaojiView.frame=CGRectMake(sender.frame.origin.x, sender.frame.origin.y+25, sender.bounds.size.width, 3);
    [self transitionFromViewController:_currentViewController toViewController:_pinpaiViewController duration:0 options:UIViewAnimationOptionTransitionNone animations:^{
    }  completion:^(BOOL finished) {
        //......
    }];
    _currentViewController=_pinpaiViewController;
    [_currentViewController willMoveToParentViewController:self];
    [_currentViewController didMoveToParentViewController:self];
    [self showFrame:_currentViewController.view];
       
        
    }
    
    
}
@end
