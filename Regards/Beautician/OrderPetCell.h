//
//  OrderPetCell.h
//  Beautician
//
//  Created by dengqiang on 4/7/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"

@class Order;

@interface OrderPetCell : BaseTableViewCell

@property (nonatomic, strong) Order *order;

+ (CGFloat)cellHeight;

@end
