//
//  AppDelegate.m
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "MobClick.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "PushManager.h"
#import "HomeViewController.h"

@interface AppDelegate () <PushManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
//    HomeViewController *home = [[HomeViewController alloc] init];
//    self.window.rootViewController = home;
    
    
    [[User currentUser] restoreFromDisk];
    
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024
                                                         diskCapacity:64 * 1024 * 1024
                                                             diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    //[HttpClient startWithBaseURL:[NSURL URLWithString:@"http://42.96.188.208:6543"]];
    [HttpClient startWithBaseURL:[NSURL URLWithString:@"http://192.168.158:8888"]];
    
#ifdef DEBUG
    [MobClick setCrashReportEnabled:NO];
#endif
    
    [MobClick setAppVersion:[AppManager sharedManager].appVersion];
    [MobClick startWithAppkey:@"55209a62fd98c5a2230001f2" reportPolicy:SEND_ON_EXIT channelId:nil];
    [MobClick updateOnlineConfig];
    
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setSuccessImage:nil];
    [SVProgressHUD setErrorImage:nil];
    
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:APP_MAIN_COLOR] forBarMetrics:UIBarMetricsDefault];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],
                                                           NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:APP_MAIN_COLOR]];
    [UITabBar appearance].tintColor = [UIColor whiteColor];
    
    HomeViewController *homeViewController = [[HomeViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    self.window.rootViewController = self.navigationController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [PushManager startWithOptions:launchOptions delegate:self];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [PushManager registerDeviceToken:deviceToken];
    });
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [PushManager handleRemoteNotification:userInfo];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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

#pragma mark - PushManagerDelegate

- (void)pushManager:(PushManager *)pushManager didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    /*
     userInfo[@"message"]为需要向用户展示的推送消息内容，如果该值不存在，则不需要展示消息内容
     userInfo里的其他key为自定义的附加推送参数
     */
    
    NSLog(@"推送内容: %@", userInfo);
    
    NSString *message = userInfo[@"message"];
    if (message.length > 0) {
        [AppManager showMessage:message];
    }
}

@end
