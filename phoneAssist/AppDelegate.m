//
//  AppDelegate.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/9/29.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MobClick.h"
#import "CommData.h"
#import "RFRateMe.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


-(void)initControllers
{
    
    MainViewController * vc = [[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    
    
   // [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:17]}            forState:UIControlStateNormal];

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    [MobClick startWithAppkey:UM_SHARE_KEY reportPolicy:BATCH   channelId:@""];
    [UMSocialData setAppKey:UM_SHARE_KEY];
        
    //打开调试log的开关
    [UMSocialData openLog:YES];
    
    //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wx56599a0020b5efcd" appSecret:@"ff9dba284f10f9533fd3e23358f94205" url:SHARE_URL];

    
    //
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self initControllers];
    
    
    [RFRateMe showRateAlertAfterTimesOpened:3];
    
    //
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end


















