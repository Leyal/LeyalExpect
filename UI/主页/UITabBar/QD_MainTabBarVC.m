//
//  QD_MainTabBarVC.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/11/15.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "QD_MainTabBarVC.h"
#import "QD_TabBar.h"
#import "QD_HomeViewController.h"
#import "QD_SettingVC.h"

@interface QD_MainTabBarVC ()

@end

@implementation QD_MainTabBarVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    // 利用KVO来使用自定义的tabBar
    [self setValue:[[QD_TabBar alloc] init] forKey:@"tabBar"];
    [self addAllChildViewController];
//    self.tabBar.tintColor = [UIColor blueColor];
//    self.tabBar.backgroundColor = [UIColor RGB:10 andG:10 andB:10 alpha:1];
    self.tabBar.barTintColor =titleColor;
    
    self.tabBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

// 添加全部的 childViewcontroller
- (void)addAllChildViewController
{

    QD_HomeViewController * vc1 = [[QD_HomeViewController alloc]init];
    [self addChildViewController:vc1 title:@"广场" imageNamed:@"home"];
    
    QD_SettingVC * vc2 = [[QD_SettingVC alloc]init];
    [self addChildViewController:vc2 title:@"设置" imageNamed:@"setting_button"];
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
    
    [self addChildViewController:nav];
}
@end
