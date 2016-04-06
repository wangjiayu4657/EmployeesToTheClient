//
//  ServiceItemsViewController.m
//  Beautician
//
//  Created by dengqiang on 4/9/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "ServiceItemsViewController.h"
#import "ServiceItem.h"
#import "KeyValueTextCell.h"

@interface ServiceItemsViewController ()

@property (nonatomic, strong) NSArray *serviceItems;
@property (nonatomic, strong) NSMutableSet *selectedIndexes;

@end

@implementation ServiceItemsViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        self.ignoreSeparatorInset = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择额外项目";
    
    self.navigationItem.rightBarButtonItem = [UIManager barButtonItemWithTitle:@"确定" target:self action:@selector(okButtonPressed:)];
    
    ServiceItem *serviceItem1 = [[ServiceItem alloc] init];
    serviceItem1.name = @"轻微打结";
    serviceItem1.price = @"20";
    
    ServiceItem *serviceItem2 = [[ServiceItem alloc] init];
    serviceItem2.name = @"中度打结";
    serviceItem2.price = @"50";
    
    ServiceItem *serviceItem3 = [[ServiceItem alloc] init];
    serviceItem3.name = @"严重打结";
    serviceItem3.price = @"80";
    
    ServiceItem *serviceItem4 = [[ServiceItem alloc] init];
    serviceItem4.name = @"刷牙";
    serviceItem4.price = @"20";
    
    ServiceItem *serviceItem5 = [[ServiceItem alloc] init];
    serviceItem5.name = @"修贵宾脚";
    serviceItem5.price = @"10";
    
    ServiceItem *serviceItem6 = [[ServiceItem alloc] init];
    serviceItem6.name = @"美容";
    serviceItem6.price = @"80";
    
    self.serviceItems = @[serviceItem1, serviceItem2, serviceItem3, serviceItem4, serviceItem5, serviceItem6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)okButtonPressed:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(didSelectServicesItems:)])
    {
        NSMutableArray *items = [NSMutableArray array];
        for (NSNumber *index in self.selectedIndexes)
        {
            [items addObject:self.serviceItems[index.intValue]];
        }
        [self.delegate didSelectServicesItems:items];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setSelectedItems:(NSArray *)selectedItems
{
    _selectedItems = selectedItems;
    
    self.selectedIndexes = [@[@0, @3, @4] mutableCopy];
}

- (NSMutableSet *)selectedIndexes
{
    if (_selectedIndexes == nil)
    {
        _selectedIndexes = [NSMutableSet set];
    }
    
    return _selectedIndexes;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.serviceItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"serviceItemCell";
    KeyValueTextCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[KeyValueTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.keyFont = [UIFont systemFontOfSize:15];
        cell.valueFont = cell.keyFont;
        cell.keyTextColor = [UIColor colorWithHex:0x333333];
        cell.valueTextColor = cell.keyTextColor;
        cell.valueTextAlignment = NSTextAlignmentLeft;
        cell.keyLabelWidth = 100;
    }

    ServiceItem *serviceItem = self.serviceItems[indexPath.row];
    cell.keyText = serviceItem.name;
    cell.valueText = [NSString stringWithFormat:@"￥%@", serviceItem.price];
    //cell.tintColor = [UIColor redColor];
    if ([self.selectedIndexes containsObject:@(indexPath.row)])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.selectedIndexes containsObject:@(indexPath.row)])
    {
        [self.selectedIndexes removeObject:@(indexPath.row)];
    }
    else
    {
        [self.selectedIndexes addObject:@(indexPath.row)];
    }
    
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
