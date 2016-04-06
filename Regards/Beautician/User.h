//
//  User.h
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseObject.h"

@interface User : BaseObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *accessToken;

+ (instancetype)currentUser;

- (BOOL)isValid;

- (void)restoreFromDisk;

+ (void)loginWithMobile:(NSString *)mobile password:(NSString *)password block:(void (^)(NSString *accessToken, NSError *error))block;

@end
