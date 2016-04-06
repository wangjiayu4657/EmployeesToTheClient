//
//  User.m
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "User.h"
#import "PersistanceManager.h"

@implementation User

+ (instancetype)currentUser
{
    static id user = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc] init];
    });
    
    return user;
}

- (BOOL)isValid
{
    return self.accessToken.length > 0;
}

- (void)saveToDisk
{
    [PersistanceManager saveObject:self identifier:@"user"];
}

- (void)removeFromDisk
{
    [PersistanceManager removeObjectWithIdentifier:@"user"];
}

- (void)restoreFromDisk
{
    id user = [PersistanceManager fetchObjectWithIdentifier:@"user"];
    [self copyFromUser:user];
}

- (void)copyFromUser:(User *)user
{
    self.id = user.id;
    self.name = user.name;
    self.avatarURL = user.avatarURL;
    self.mobile = user.mobile;
    self.password = user.password;
    self.accessToken = user.accessToken;
}

+ (void)loginWithMobile:(NSString *)mobile password:(NSString *)password block:(void (^)(NSString *, NSError *))block
{
    [[HttpClient sharedClient] postPath:@"login"
                                 params:@{
                                           @"login": mobile,
                                           @"password": password
                                         }
                            resultBlock:^(id responseObject, NSError *error)
                             {
                                NSDictionary *data = [responseObject[@"data"] toDictionary];
                                NSString *accessToken = [data[@"token"] toString];
                                
                                ((User *)[self currentUser]).accessToken = accessToken;
                                [[self currentUser] saveToDisk];
                                
                                if (block)
                                {
                                    GCD_MAIN_QUEUE_BEGIN
                                    block(accessToken, error);
                                    GCD_MAIN_QUEUE_END
                                }
                              }];
}

@end
