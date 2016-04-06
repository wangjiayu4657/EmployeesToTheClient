//
//  ServiceItemsViewController.h
//  Beautician
//
//  Created by dengqiang on 4/9/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol ServiceItemsViewControllerDelegate <NSObject>

- (void)didSelectServicesItems:(NSArray *)selectedItems;

@end

@interface ServiceItemsViewController : BaseTableViewController

@property (nonatomic, weak) id<ServiceItemsViewControllerDelegate>delegate;
@property (nonatomic, weak) NSArray *selectedItems;

@end
