//
//  PersistanceManager.h
//  Beautician
//
//  Created by dengqiang on 4/16/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistanceManager : NSObject

+ (void)saveObject:(id)object identifier:(NSString *)identifier;
+ (void)removeObjectWithIdentifier:(NSString *)identifier;
+ (id)fetchObjectWithIdentifier:(NSString *)identifier;

@end
