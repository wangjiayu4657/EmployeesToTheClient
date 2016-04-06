//
//  PersistanceManager.m
//  Beautician
//
//  Created by dengqiang on 4/16/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "PersistanceManager.h"

@implementation PersistanceManager

+ (NSString *)dataDirectoryPath
{
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentsDirectoryPath stringByAppendingPathComponent:@"data"];
}

+ (NSString *)filePathWithIdentifier:(NSString *)identifier
{
    return [[self dataDirectoryPath] stringByAppendingPathComponent:identifier];
}

+ (void)saveObject:(id)object identifier:(NSString *)identifier
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[self dataDirectoryPath]]) {
        NSError *error;
        if (![fileManager createDirectoryAtPath:[self dataDirectoryPath] withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"create data directory error: %@", error);
        }
    }
    
    if (![NSKeyedArchiver archiveRootObject:object toFile:[self filePathWithIdentifier:identifier]]) {
        NSLog(@"saveObject error: %@", identifier);
    }
}

+ (void)removeObjectWithIdentifier:(NSString *)identifier
{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager removeItemAtPath:[self filePathWithIdentifier:identifier] error:&error]) {
        NSLog(@"removeObjectWithIdentifier: %@", error);
    }
}

+ (id)fetchObjectWithIdentifier:(NSString *)identifier
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self filePathWithIdentifier:identifier]];
}

@end
