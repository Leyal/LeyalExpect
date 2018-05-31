//
//  AppDelegate.m
//  Masonry_Leyal
//
//  Created by 雷源 on 2017/10/30.
//  Copyright © 2017年 Yuanjihua. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "QD_HomeViewController.h"
#import "QD_MainTabBarVC.h"
#import "LoginViewController.h"
#import "LoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AVOSCloud setApplicationId:@"BA69fJYBSxVp9ty8eiWHg9f0-gzGzoHsz" clientKey:@"6cOvO8wLMOJIOtk5kEfyazUz"];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];

    self.tabBarController = [[QD_MainTabBarVC alloc]init];

    self.window.rootViewController = self.tabBarController;

    [self.window makeKeyAndVisible];
    
    
//    LoginVC * loginVC = [[LoginVC alloc]init];
//    self.window.rootViewController = loginVC;
//    [self.window makeKeyAndVisible];
    
    
    
//    if(![[NSUserDefaults standardUserDefaults] valueForKey:@"isFirst"])
//    {
//        //第一次登录
//        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isFirst"];
//        LoginViewController * loginVC = [[LoginViewController alloc]init];
//        self.window.rootViewController = loginVC;
//        [self.window makeKeyAndVisible];
//    }
//    else
//    {
//        self.tabBarController = [[QD_MainTabBarVC alloc]init];
//
//        self.window.rootViewController = self.tabBarController;
//
//        [self.window makeKeyAndVisible];
//        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"isFirst"];
//    }
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
