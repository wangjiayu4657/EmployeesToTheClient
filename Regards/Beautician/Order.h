//
//  Order.h
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseObject.h"

typedef NS_ENUM(NSUInteger, OrderStatus)
{
    OrderStatusCanceled,            // 已取消
    OrderStatusNotStarted,          // 等待服务
    OrderStatusInService,           // 正在服务
    OrderStatusNotPaid,             // 服务完成，等待支付
    OrderStatusPaid,                // 支付完成
    OrderStatusFinished             // 订单完结
};

@class Pet;

@interface Order : BaseObject

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, assign) NSUInteger quantity;
@property (nonatomic, strong) Pet *pet;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSDate *serviceDate;
@property (nonatomic, strong) NSArray *remarks;
@property (nonatomic, strong) NSArray *additionalItems;
@property (nonatomic, strong) NSString *additionalFee;
@property (nonatomic, assign) OrderStatus status;

@end
