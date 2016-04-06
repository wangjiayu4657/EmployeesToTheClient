//
//  MenuItem.h
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseObject.h"

typedef NS_OPTIONS(NSUInteger, RichTextItemId)
{
    RichTextItemIdOrders = 1,
};

@interface RichTextItem : BaseObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) NSString *targetURL;
@property (nonatomic, strong) NSString *tips;

@end
