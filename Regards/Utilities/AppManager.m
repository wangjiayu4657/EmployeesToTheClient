//
//  AppManager.m
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "AppManager.h"
#import <sys/utsname.h>
#import "UICKeyChainStore.h"

#define kAppManagerDeviceIdKey                  @"AppManagerDeviceIdKey"

NSString * const AppManagerNeedLoginNotification = @"AppManagerNeedLoginNotification";
NSString * const AppManagerLoginSuccessNotification = @"AppManagerLoginSuccessNotification";
NSString * const AppManagerPostSuccessNotification = @"AppManagerPostSuccessNotification";
NSString * const AppManagerUserInfoUpdatedNotification = @"AppManagerUserInfoUpdatedNotification";

@interface AppManager ()

@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *system;
@property (nonatomic, strong) NSString *device;
@property (nonatomic, strong) NSString *appVersion;

@end

@implementation AppManager

+ (instancetype)sharedManager
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

#pragma mark - Private

#pragma mark - Getter/Setter

- (NSString *)uuid
{
    if (_uuid == nil) {
        _uuid = [UICKeyChainStore stringForKey:kAppManagerDeviceIdKey];
        if (_uuid == nil) {
            _uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
            NSLog(@"_uuid = %@",_uuid);
            [UICKeyChainStore setString:_uuid forKey:kAppManagerDeviceIdKey];
        }
    }
    
    return _uuid;
}

- (NSString *)device
{
    if (_device == nil) {
        struct utsname systemInfo;
        uname(&systemInfo);
        _device = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    }
    
    return _device;
}

- (NSString *)system
{
    if (_system == nil) {
        _system = [NSString stringWithFormat:@"%@ %@", [UIDevice currentDevice].systemName, [UIDevice currentDevice].systemVersion];
    }
    
    return _system;
}

- (NSString *)appVersion
{
    return APP_VERSION;
}

#pragma mark - Public

+ (void)showMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"我知道啦" otherButtonTitles:nil, nil];
    
    [alertView show];
}

+ (void)showMessage:(NSString *)message title:(NSString *)title delegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title ?: @"提示"
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:@"我知道啦"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

+ (void)showActionMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle actionButtonTitle:(NSString *)actionButtonTitle associatedObject:(id)associatedObject delegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:cancelButtonTitle ?: @"取消"
                                              otherButtonTitles:actionButtonTitle ?: @"确定", nil];
    alertView.associatedObject = associatedObject;
    
    [alertView show];
}

+ (void)postNotificationName:(NSString *)notificationName object:(id)object
{
    [self postNotificationName:notificationName object:object afterDelay:0];
}

+ (void)postNotificationName:(NSString *)notificationName object:(id)object afterDelay:(NSTimeInterval)delay
{
    dispatch_after(delay, dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object];
    });
}

+ (void)dial:(NSString *)phoneNumber
{
    UIWebView *webView = (UIWebView *)[[UIApplication sharedApplication].keyWindow viewWithTag:-1000];
    if (webView == nil)
    {
        webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        [[UIApplication sharedApplication].keyWindow addSubview:webView];
    }
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", phoneNumber]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

+ (NSString *)databasePath
{
    return [[NSBundle mainBundle] pathForResource:@"beautician" ofType:@"db"];
}

@end
