//
//  AppManager.h
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const AppManagerNeedLoginNotification;
extern NSString * const AppManagerLoginSuccessNotification;
extern NSString * const AppManagerPostSuccessNotification;
extern NSString * const AppManagerUserInfoUpdatedNotification;

@interface AppManager : NSObject

@property (nonatomic, strong, readonly) NSString *uuid;
@property (nonatomic, strong, readonly) NSString *system;
@property (nonatomic, strong, readonly) NSString *device;
@property (nonatomic, strong, readonly) NSString *appVersion;

@property (nonatomic, assign, readonly) double latitude;
@property (nonatomic, assign, readonly) double longitude;

@property (nonatomic, weak) UIViewController *currentViewController;

+ (instancetype)sharedManager;

+ (void)showMessage:(NSString *)message;

+ (void)showMessage:(NSString *)message
              title:(NSString *)title
              delegate:(id<UIAlertViewDelegate>)delegate;

+ (void)showActionMessage:(NSString *)message
              cancelButtonTitle:(NSString *)cancelButtonTitle
              actionButtonTitle:(NSString *)actionButtonTitle
              associatedObject:(id)associatedObject
              delegate:(id<UIAlertViewDelegate>)delegate;

+ (void)postNotificationName:(NSString *)notificationName object:(id)object;
+ (void)postNotificationName:(NSString *)notificationName object:(id)object afterDelay:(NSTimeInterval)delay;
+ (void)dial:(NSString *)phoneNumber;
+ (NSString *)databasePath;

@end
