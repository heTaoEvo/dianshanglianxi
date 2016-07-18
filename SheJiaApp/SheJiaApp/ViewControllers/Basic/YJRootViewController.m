//
//  YJRootViewController.m
//  SheJiaApp
//
//  Created by 阳剑 on 16/6/24.
//  Copyright © 2016年 阳剑. All rights reserved.
//

#import "YJRootViewController.h"

#import "YJLoginViewController.h"
#import "YJHomeNavigationViewController.h"
#import "WZKindNavigationViewController.h"
#import "YJSaleNavigationViewController.h"
#import "WZBasicViewController.h"
#import "YJHomeViewController.h"
#import "WZSearchViewController.h"
#import "YJJmlcViewController.h"

#import "LLTabBar.h"

#import "LLTabBarItem.h"

@interface YJRootViewController () <LLTabBarDelegate>

@end

@implementation YJRootViewController

#pragma mark - 视图控制器方法
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    [self addViewControllers];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Methods
- (void)addViewControllers
{
    YJHomeViewController *home = [[YJHomeViewController alloc] init];

    YJHomeNavigationViewController *homeNavigation = [[YJHomeNavigationViewController alloc] initWithRootViewController:home];
    WZSearchViewController *kind = [[WZSearchViewController alloc] init];
    
    WZKindNavigationViewController *kindNavigation = [[WZKindNavigationViewController alloc] initWithRootViewController:kind];
    
    self.viewControllers = @[homeNavigation,kindNavigation];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:self.tabBar.bounds];
    
    CGFloat normalButtonWidth = (SCREEN_WIDTH * 3 / 4) / 4;
    CGFloat tabBarHeight = CGRectGetHeight(tabBar.frame);
    CGFloat publishItemWidth = (SCREEN_WIDTH / 4);
    
    LLTabBarItem *homeItem = [self tabBarItemWithFrame:CGRectMake(0, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"首页"
                                       normalImageName:@"footer_home_icon"
                                     selectedImageName:@"footer_home_active_icon" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *sameCityItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth, 0, normalButtonWidth, tabBarHeight)
                                                     title:@"分类"
                                           normalImageName:@"footer_shop_icon"
                                         selectedImageName:@"footer_shop_active_icon" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *publishItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2, 0, publishItemWidth, tabBarHeight)
                                                    title:@"寄卖"
                                          normalImageName:@"footer_post_icon"
                                        selectedImageName:@"footer_post_active_icon" tabBarItemType:LLTabBarItemRise];
    LLTabBarItem *messageItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 2 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                    title:@"消息"
                                          normalImageName:@"footer_news_icon"
                                        selectedImageName:@"footer_news_active_icon" tabBarItemType:LLTabBarItemNormal];
    LLTabBarItem *mineItem = [self tabBarItemWithFrame:CGRectMake(normalButtonWidth * 3 + publishItemWidth, 0, normalButtonWidth, tabBarHeight)
                                                 title:@"我的"
                                       normalImageName:@"footer_user_icon"
                                     selectedImageName:@"footer_user_active_icon" tabBarItemType:LLTabBarItemNormal];
    
    tabBar.tabBarItems = @[homeItem,sameCityItem,publishItem,messageItem,mineItem];
    
    tabBar.delegate = self;
    
    [self.tabBar addSubview:tabBar];
    
    
}

- (LLTabBarItem *)tabBarItemWithFrame:(CGRect)frame title:(NSString *)title normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName tabBarItemType:(LLTabBarItemType)tabBarItemType {
    LLTabBarItem *item = [[LLTabBarItem alloc] initWithFrame:frame];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont systemFontOfSize:8];
    UIImage *normalImage = [UIImage imageNamed:normalImageName];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
  
    
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    [item setImage:selectedImage forState:UIControlStateHighlighted];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateNormal];
    [item setTitleColor:[UIColor colorWithWhite:51 / 255.0 alpha:1] forState:UIControlStateSelected];

    item.tabBarItemType = tabBarItemType;
    
    return item;
}
#pragma mark - LLTabBarDelegate

- (void)tabBarDidSelectedRiseButton {
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *viewController = tabBarController.selectedViewController;
    
    YJJmlcViewController *jmlc = [[YJJmlcViewController alloc] init];
    
    YJSaleNavigationViewController *saleNavigation = [[YJSaleNavigationViewController alloc] initWithRootViewController:jmlc];
    [viewController presentViewController:saleNavigation animated:YES completion:nil];
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:.3];
//    [UIView setAnimationTransition:UIViewAnimationOptionCurveEaseInOut forView:[UIApplication sharedApplication].delegate.window cache:YES];
//    [UIView commitAnimations];

}
- (void)tabBarDidSelectedNormalItem:(NSString *)itemTitle
{
    if([itemTitle isEqualToString:@"消息"])
    {
        YJLoginViewController *login = [[YJLoginViewController alloc] init];
        
        WZBasicViewController *basicNavigation = [[WZBasicViewController alloc] initWithRootViewController:login];
        [self presentViewController:basicNavigation animated:YES completion:nil];
    }
    if([itemTitle isEqualToString:@"我的"])
    {
        YJLoginViewController *login = [[YJLoginViewController alloc] init];
        [self presentViewController:login animated:YES completion:nil];
        
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
