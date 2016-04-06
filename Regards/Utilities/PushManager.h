//
//  PushManager.h
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PushManager;

@protocol PushManagerDelegate <NSObject>

- (void)pushManager:(PushManager *)pushManager didReceiveRemoteNotification:(NSDictionary *)userInfo;

@end

@interface PushManager : NSObject

+ (void)startWithOptions:(NSDictionary *)launchOptions delegate:(id<PushManagerDelegate>)delegate;
+ (void)registerDeviceToken:(NSData *)deviceToken;
+ (void)setTags:(NSSet *)tags;
+ (void)setAlias:(NSString *)alias;
+ (void)handleRemoteNotification:(NSDictionary *)userInfo;

@end

