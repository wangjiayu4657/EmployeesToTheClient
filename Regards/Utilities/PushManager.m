//
//  PushManager.m
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "PushManager.h"
#import "UMessage.h"

@interface PushManager ()

@property (nonatomic, weak) id<PushManagerDelegate> delegate;

@end

@implementation PushManager

+ (PushManager *)sharedManager
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

+ (void)startWithOptions:(NSDictionary *)launchOptions delegate:(id<PushManagerDelegate>)delegate
{
    [self sharedManager].delegate = delegate;
    
    [UMessage startWithAppkey:@"5518fd4afd98c51669000584" launchOptions:launchOptions];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:settings];
    }
    else
    {
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
    }
    
    [UMessage setLogEnabled:YES];
    
    
    NSDictionary *params = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    if (params && [[self sharedManager].delegate respondsToSelector:@selector(pushManager:didReceiveRemoteNotification:)])
    {
        [[self sharedManager].delegate pushManager:[self sharedManager] didReceiveRemoteNotification:params];
    }
}

+ (void)registerDeviceToken:(NSData *)deviceToken
{
    NSLog(@"DeviceToken: %@", deviceToken);
    [UMessage registerDeviceToken:deviceToken];
}

+ (void)setTags:(NSSet *)tags
{
    [UMessage addTag:tags response:^(id responseObject, NSInteger remain, NSError *error) {
        NSLog(@"set tags success: %@", tags);
        if (remain < 10) {
            [UMessage removeAllTags:nil];
        }
    }];
}

+ (void)setAlias:(NSString *)alias
{
    [UMessage addAlias:alias type:@"uid" response:^(id responseObject, NSError *error)
    {
        NSLog(@"set alias success: %@", alias);
    }];
}

+ (void)handleRemoteNotification:(NSDictionary *)userInfo
{    
    NSLog(@"RemoteNotification: %@", userInfo);
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (message)
    {
        [params setObject:message forKey:@"message"];
    }
    [params removeObjectForKey:@"aps"];
    
    if ([[self sharedManager].delegate respondsToSelector:@selector(pushManager:didReceiveRemoteNotification:)]) {
        [[self sharedManager].delegate pushManager:[self sharedManager] didReceiveRemoteNotification:params];
    }
}

@end
