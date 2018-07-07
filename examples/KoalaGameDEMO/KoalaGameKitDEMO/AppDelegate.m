//
//  AppDelegate.m
//  KoalaGameKitDEMO
//
//  Created by kaola  on 2018/5/11.
//  Copyright © 2018年 kaola . All rights reserved.
//

#import "AppDelegate.h"

#import <KoalaGameKIt/KoalaGameKit.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // debug时可以开启打印，发布时要关闭打印
#ifdef DEBUG
    [Koala kgk_openLog:YES];
#endif
    
    // 初始化
    [KKConfig sharedConfig].appid = @"100000"; // app id
    [KKConfig sharedConfig].channel = @"appstore100000";
    [KKConfig sharedConfig].appkey = @"123456";  // 签名的key
    
    __weak typeof(self) weakSelf = self;
    [Koala kgk_initGameKitWithCompletionHandler:^(KKResult *result) {
        
        if (result.result.boolValue) {
            
            NSLog(@"初始化成功：%@", result.msg);
            [weakSelf demo_autologin];
        }
        else {
            
            NSLog(@"初始化失败：%@", result.msg);
        }
    }];
    
    return YES;
}

- (void)demo_autologin {
    
    [Koala kgk_loginWithViewController:NULL isAllowUserAutologin:YES floatBallInitStyle:FloatBallStyleDefault isRememberFloatBallLocation:YES completeHandler:^(KKResult * _Nonnull result) {
        
        if (result.isSucc) {
            // 登录成功，data是一个user模型：KKUser
            KKUser *user = result.data;
            NSLog(@"登录成功：%@", user);
        }
        else {
            
            // 登录失败: 并不会有登录失败的回调，如网络错误，密码错误等，sdk已自行处理。
            NSLog(@"登录失败:%@", result.msg);
        }
    }];
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
