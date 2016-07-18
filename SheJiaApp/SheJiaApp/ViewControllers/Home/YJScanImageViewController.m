//
//  YJScanImageViewController.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/7/1.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJScanImageViewController.h"

#import "YJScrollView.h"
@interface YJScanImageViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *mainScroll;

@property (nonatomic,weak) NSMutableArray *imageViewArray;

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation YJScanImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _imageViewArray = [[NSMutableArray alloc] init];
    [self addContentScroll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imageViewArray[0];
}



#pragma mark -Private Methods
- (void)addContentScroll
{
    self.mainScroll.contentSize = CGSizeMake(SCREEN_WIDTH*4, SCREEN_HEIGHT);
    for(int i = 0;i<4;i++)
    {
        YJScrollView *scrollView =[[YJScrollView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [self addImageToSroll:scrollView];
        scrollView.delegate = self;
        [self.mainScroll addSubview:scrollView];
    }
}
- (void)addImageToSroll:(UIScrollView *)scrollView
{
     UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_03"]];
    imageView.frame = scrollView.bounds;
    [_imageViewArray addObject:imageView];
    [scrollView addSubview:imageView];
}




#pragma mark - Event Responder

#pragma mark - Getter



@end
