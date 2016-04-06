//
//  HomeViewController.h
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewController.h"

@interface HomeViewController : BaseTableViewController
@property (assign,nonatomic) NSUInteger STATUS;
@property (strong, nonatomic) UIImageView *subView;
@property (copy, nonatomic) NSString *token;
@end
