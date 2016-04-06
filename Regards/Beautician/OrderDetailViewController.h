//
//  OrderDetailViewController.h
//  Beautician
//
//  Created by dengqiang on 4/8/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewController.h"

@class Order;

@interface OrderDetailViewController : BaseTableViewController

@property (nonatomic, strong) Order *order;
//@property (assign, nonatomic) NSUInteger segmentIndex;
@end
