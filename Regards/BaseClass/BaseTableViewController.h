//
//  BaseTableViewController.h
//  Pets
//
//  Created by dengqiang on 3/31/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#include "BaseViewController.h"

@interface BaseTableViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL ignoreSeparatorInset;

- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
