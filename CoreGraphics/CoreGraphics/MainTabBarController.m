//
//  MainTabBarController.m
//  CoreGraphics
//
//  Created by Yx on 15/12/28.
//  Copyright © 2015年 WuhanBttenMobileTechnologyCo.,Ltd. All rights reserved.
//

#import "MainTabBarController.h"
#import "XZMTabbarExtension.h"
#import "BaseViewController.h"
#import "ChartViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    /** 设置默认状态 */
    NSMutableDictionary *norDict = @{}.mutableCopy;
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    norDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    [tabBarItem setTitleTextAttributes:norDict forState:UIControlStateNormal];
    
    /** 设置选中状态 */
    NSMutableDictionary *selDict = @{}.mutableCopy;
    selDict[NSFontAttributeName] = norDict[NSFontAttributeName];
    selDict[NSForegroundColorAttributeName] = [UIColor blackColor];
    [tabBarItem setTitleTextAttributes:selDict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*添加子控制器 */
    /** 精华 */
    [self setUpChildControllerWith:[[BaseViewController alloc]init] norImage:[UIImage imageNamed:@"tabBar_essence_icon"] selImage:[UIImage imageNamed:@"tabBar_essence_click_icon"] title:@"精华"];
    
    /** 新帖 */
    [self setUpChildControllerWith:[[ChartViewController alloc] init] norImage:[UIImage imageNamed:@"tabBar_new_icon"] selImage:[UIImage imageNamed:@"tabBar_new_click_icon"]title:@"新帖"];
    
    /** 关注 */
    [self setUpChildControllerWith:[[BaseViewController alloc] init] norImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"] selImage:[UIImage imageNamed:@"tabBar_friendTrends_click_icon"] title:@"关注"];
    
    /** 我的 */
    [self setUpChildControllerWith:[[BaseViewController alloc] init] norImage:[UIImage imageNamed:@"tabBar_me_icon"] selImage:[UIImage imageNamed:@"tabBar_me_click_icon"] title:@"我的"];
    /** 配置中间按钮 */
    [self.tabBar setUpTabBarCenterButton:^(UIButton *centerButton) {
        [centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        
        [centerButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        
        [centerButton addTarget:self action:@selector(chickCenterButton) forControlEvents:UIControlEventTouchUpInside];
    }];
    /** 设置tabar工具条 */
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
}

- (void)chickCenterButton
{
    NSLog(@"点击了中间按钮");
}

- (void)setUpChildControllerWith:(UIViewController *)childVc norImage:(UIImage *)norImage selImage:(UIImage *)selImage title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    childVc.title = title;
    childVc.tabBarItem.image = norImage;
    childVc.tabBarItem.selectedImage = selImage;
    [self addChildViewController:nav];
}


@end
