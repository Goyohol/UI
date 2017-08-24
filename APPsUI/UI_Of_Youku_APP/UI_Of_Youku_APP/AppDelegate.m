//
//  AppDelegate.m
//  UI_Of_Youku_APP
//
//  Created by goyohol on 15/9/29.
//  Copyright © 2015年 goyohol. All rights reserved.
//

#import "AppDelegate.h"


//视图控制器
#import "GYHNavigationController.h"
#import "FirstViewController.h"
#import "ChannelViewController.h"
#import "DingyuViewController.h"
#import "MyViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    //分栏控制器
    [self creattabBarController];
    //分栏控制器 及 Item
    [self tabBarSetting];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;

}

#pragma mark - 定制分栏控制器
-(void)creattabBarController
{
    UITabBarController * tabBarController = (UITabBarController *)self.window.rootViewController;//分栏控制器 作为根控制器
    [tabBarController.tabBar setBarStyle:UIBarStyleDefault];
    [tabBarController.tabBar setBackgroundColor:[UIColor lightGrayColor]];
    [tabBarController.tabBar setTranslucent:NO];
    [tabBarController.tabBar setTintColor:[UIColor whiteColor]];
    
}
-(void)tabBarSetting
{
    UITabBarController * tabBarController = [[UITabBarController alloc]init];
    self.window.rootViewController = tabBarController;//根视图控制器
    
    FirstViewController * first = [[FirstViewController alloc]init];
    GYHNavigationController * nav1 = [[GYHNavigationController alloc]initWithRootViewController:first];
    //    first.title = @"首页";
    
    ChannelViewController * channel = [[ChannelViewController alloc]init];
    GYHNavigationController * nav2 = [[GYHNavigationController alloc]initWithRootViewController:channel];
    //    channel.title = @"频道";
    
    DingyuViewController * dingyu = [[DingyuViewController alloc]init];
    GYHNavigationController * nav3 = [[GYHNavigationController alloc]initWithRootViewController:dingyu];
    //    dingyu.title = @"订阅";
    
    MyViewController * my = [[MyViewController alloc]init];
    GYHNavigationController * nav4 = [[GYHNavigationController alloc]initWithRootViewController:my];
    //    my.title = @"我的";
    
    //设置tabBarItem标题
    first.tabBarItem.title = @"首页";
    channel.tabBarItem.title = @"频道";
    dingyu.tabBarItem.title = @"订阅";
    my.tabBarItem.title = @"我的";
    
    
#pragma mark - 定制tabBarItem
    [[UIBarButtonItem appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    
    [first.tabBarItem setImage:[[UIImage imageNamed:@"1首页_1"]   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [first.tabBarItem setSelectedImage:[[UIImage imageNamed:@"1首页_2"]   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [channel.tabBarItem setImage:[[UIImage imageNamed:@"2频道_1"]   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [channel.tabBarItem setSelectedImage:[[UIImage imageNamed:@"2频道_2"]   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [dingyu.tabBarItem setImage:[[UIImage imageNamed:@"3订阅_1"]   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [dingyu.tabBarItem setSelectedImage:[[UIImage imageNamed:@"3订阅_2"]   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [my.tabBarItem setImage:[[UIImage imageNamed:@"4我的_1"]   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [my.tabBarItem setSelectedImage:[[UIImage imageNamed:@"4我的_2"]   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    
    //添加到ViewController
    tabBarController.viewControllers = @[nav1,nav2,nav3,nav4];
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
