//
//  ViewController.m
//  webviewaddview
//
//  Created by joker on 16/7/20.
//  Copyright © 2016年 Evo. All rights reserved.
//

#import "ViewController.h"
#import "people.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0,0 , 320, 568)];
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSURLRequest *reuq = [NSURLRequest requestWithURL:url];
    [web loadRequest:reuq];
    [self.view addSubview:web];
    UIView *redview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    redview.backgroundColor = [UIColor redColor];
   
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    image.image = [UIImage imageNamed:@"icon_my_camera@2x.png"];
    image.layer.cornerRadius = 50;
image.layer.masksToBounds =YES;
    image.clipsToBounds = YES ;
//    web.scrollView.bounces = NO ;
     [web addSubview:image];
    NSLog(@"%@我是",web);
    people *peole = [people new];

    NSLog(@"12222222");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
