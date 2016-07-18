//
//  YJLoginViewController.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJLoginViewController.h"

#import "WZZhuCeViewController.h"

@interface YJLoginViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *bgImgView;

@end

@implementation YJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initBgImg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Delegate

#pragma mark -Private Methods

- (void)initBgImg
{
    CGRect bounds = self.view.bounds;
    if(CGRectEqualToRect(bounds, IPHONE4))
    {
        [self.bgImgView setImage:[UIImage imageNamed:@"loginbg4"]];
    }
    else
        [self.bgImgView setImage:[UIImage imageNamed:@"loginbg6"]];
}


#pragma mark - Event Responder

- (IBAction)zhuce:(id)sender
{
    WZZhuCeViewController *zhuce = [[WZZhuCeViewController alloc] init];
    [self.navigationController pushViewController:zhuce animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
}
- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Getter


@end
