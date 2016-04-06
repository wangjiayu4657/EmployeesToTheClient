//
//  BaseObject.m
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseObject.h"
#import <objc/runtime.h>

@interface BaseObject () <NSCoding>

@end

@implementation BaseObject

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        unsigned int count;
        
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        
        for (NSUInteger i = 0; i < count; i++)
        {
            objc_property_t property = properties[i];
            NSString *key = [NSString stringWithUTF8String:property_getName(property)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
        
        free(properties);
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (NSUInteger i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    
    free(properties);
}

@end
