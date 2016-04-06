//
//  OrdersViewController.m
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "OrdersViewController.h"
#import "HMSegmentedControl.h"
#import "Order.h"
#import "Pet.h"
#import "RichTextCell.h"
#import "RichTextItem.h"
#import "OrderPetCell.h"
#import "KeyValueTextCell.h"
#import "OrderDetailViewController.h"
#import "Remark.h"
#import "ServiceItem.h"


typedef NS_ENUM(NSUInteger, TABLE_VIEW_ROW)
{
    TABLE_VIEW_ROW_SUIT,
    TABLE_VIEW_ROW_PET, //宠物
    TABLE_VIEW_ROW_TIME,//时间
    TABLE_VIEW_ROW_COUNT
};

@interface OrdersViewController ()

@property (nonatomic, strong) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) NSArray *orders;

@end

@implementation OrdersViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"全部订单";
    self.segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"待完成", @"已完成", @"已取消"]];
    self.segmentedControl.font = [UIFont systemFontOfSize:16];
    self.segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    self.segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentedControl.selectionIndicatorHeight = 2.0;
    self.segmentedControl.selectionIndicatorColor = APP_MAIN_COLOR;
    self.segmentedControl.selectedTextColor = APP_MAIN_COLOR;
    self.segmentedControl.textColor = [UIColor colorWithHex:0x999999];
    [self.segmentedControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
    
    self.ignoreSeparatorInset = YES;
    
    
    
    ServiceItem *serviceItem1 = [[ServiceItem alloc] init];
    serviceItem1.name = @"宠物刷牙";
    serviceItem1.price = @"20";
    
    ServiceItem *serviceItem2 = [[ServiceItem alloc] init];
    serviceItem2.name = @"美容SPA";
    serviceItem2.price = @"120";
    
    
    Remark *remark1 = [[Remark alloc] init];
    remark1.date = [NSDate dateWithTimeIntervalSinceNow:-1000];
    remark1.content = @"需要带浴盆需要带浴盆需要带浴盆需要带浴盆需要带浴盆需要带浴盆需要带浴盆需要带浴盆需要带浴盆需要带浴盆需要带浴盆";
    
    Remark *remark2 = [[Remark alloc] init];
    remark2.date = [NSDate dateWithTimeIntervalSinceNow:-20000];
    remark2.content = @"狗狗左脚受过伤狗狗左脚受过伤狗狗左脚受过伤狗狗左脚受过伤狗狗左脚受过伤狗狗左脚受过伤狗狗左脚受过伤狗狗左脚受过伤狗狗左脚受过伤狗狗左脚受过伤";
    
    
    PetBreed *breed = [[PetBreed alloc] init];
    breed.name = @"萨摩耶";
    
    Pet *pet = [[Pet alloc] init];
    pet.breed = breed;
    pet.name = @"妞妞";
    pet.age = @"1岁2个月";
    pet.avatarURL = @"http://www.cndog.net/upimg/2013/10/2013101010292397.jpg";
    
    Order *order1 = [[Order alloc] init];
    order1.id = 1;
    order1.pet = pet;
    order1.amount = @"69.9";
    order1.quantity = 2;
    order1.serviceDate = [[[NSDate alloc] init] dateByAddingTimeInterval:-100000];
    order1.address = @"西湖区文一西路云桂花园7幢201";
    order1.mobile = @"18605812631";
    order1.remarks = @[remark1, remark2];
    order1.additionalItems = @[serviceItem1, serviceItem2];
    
    Order *order2 = [[Order alloc] init];
    order2.id = 2;
    order2.pet = pet;
    order2.amount = @"69.9";
    order2.quantity = 2;
    order2.serviceDate = [[[NSDate alloc] init] dateByAddingTimeInterval:-100000];
    order2.address = @"西湖区文一西路云桂花园7幢202";
    order2.mobile = @"18605812631";
    order2.remarks = @[remark1, remark2];
    order2.additionalItems = @[serviceItem1, serviceItem2];
    
    Order *order3 = [[Order alloc] init];
    order3.id = 3;
    order3.pet = pet;
    order3.amount = @"69.9";
    order3.quantity = 2;
    order3.serviceDate = [[[NSDate alloc] init] dateByAddingTimeInterval:-100000];
    order3.address = @"西湖区文一西路云桂花园7幢203";
    order3.mobile = @"18605812631";
    order3.remarks = @[remark1, remark2];
    order3.additionalItems = @[serviceItem1, serviceItem2];
    
    Order *order4 = [[Order alloc] init];
    order4.id = 4;
    order4.pet = pet;
    order4.amount = @"69.9";
    order4.quantity = 2;
    order4.serviceDate = [[[NSDate alloc] init] dateByAddingTimeInterval:-100000];
    order4.address = @"西湖区文一西路云桂花园7幢204";
    order4.mobile = @"18605812631";
    order4.remarks = @[remark1, remark2];
    order4.additionalItems = @[serviceItem1, serviceItem2];
    
    Order *order5 = [[Order alloc] init];
    order5.id = 5;
    order5.pet = pet;
    order5.amount = @"69.9";
    order5.quantity = 2;
    order5.serviceDate = [[[NSDate alloc] init] dateByAddingTimeInterval:-100000];
    order5.address = @"西湖区文一西路云桂花园7幢205";
    order5.mobile = @"18605812631";
    order5.remarks = @[remark1, remark2];
    order5.additionalItems = @[serviceItem1, serviceItem2];
    
    self.orders = @[order1, order2, order3, order4, order5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Layout

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (!self.didSetupConstraints) {
        [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.segmentedControl autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.segmentedControl autoSetDimension:ALDimensionHeight toSize:35];
        
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.segmentedControl];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (IBAction)segmentControlValueChanged:(id)sender
{
    HMSegmentedControl *segmentedControl = sender;
    NSLog(@"segmentControlValueChanged: %ld", segmentedControl.selectedSegmentIndex);
    //self.SegmentIndex = segmentedControl.selectedSegmentIndex;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.orders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return TABLE_VIEW_ROW_COUNT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    
    switch (indexPath.row) {
        case TABLE_VIEW_ROW_SUIT:
            height = 30;
            break;
            
        case TABLE_VIEW_ROW_PET:
            height = [OrderPetCell cellHeight];
            break;
            
        case TABLE_VIEW_ROW_TIME:
            height = 44;
            break;
            
        default:
            break;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case TABLE_VIEW_ROW_SUIT:
        {
            NSString *cellIdentifier = @"orderSuitCell";
            RichTextCell *orderSuitCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (orderSuitCell == nil) {
                orderSuitCell = [[RichTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                orderSuitCell.accessoryType = UITableViewCellAccessoryNone;
                orderSuitCell.selectionStyle = UITableViewCellSelectionStyleNone;
                orderSuitCell.type = RichTextCellTypeWithoutIcon;
                orderSuitCell.nameFont = [UIFont systemFontOfSize:14];
                orderSuitCell.tipsFont = [UIFont systemFontOfSize:13];
            }
            
            RichTextItem *item = [[RichTextItem alloc] init];
            item.name = @"上门沐浴套餐";
            item.tips = @"订单号：12345678901234";
            
            orderSuitCell.richTextItem = item;
            
            cell = orderSuitCell;
            
            break;
        }
            
        case TABLE_VIEW_ROW_PET:
        {
            NSString *cellIdentifier = @"orderPetCell";
            OrderPetCell *orderPetCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (orderPetCell == nil)
            {
                orderPetCell = [[OrderPetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                orderPetCell.accessoryType = UITableViewCellAccessoryNone;
                orderPetCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            orderPetCell.order = self.orders[indexPath.section];
            
            cell = orderPetCell;
            
            break;
        }
            
        case TABLE_VIEW_ROW_TIME:
        {
            NSString *cellIdentifier = @"timeCell";
            KeyValueTextCell *timeCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (timeCell == nil) {
                timeCell = [[KeyValueTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                timeCell.keyFont = [UIFont systemFontOfSize:13];
                timeCell.valueFont = timeCell.keyFont;
                timeCell.keyTextColor = [UIColor colorWithHex:0x333333];
                timeCell.valueTextColor = [UIColor colorWithHex:0xF5A623];
                timeCell.keyLabelWidth = 65;
                timeCell.accessoryType = UITableViewCellAccessoryNone;
                timeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                timeCell.keyText = @"预约时间：";
            }

            timeCell.valueText = @"2015-04-01 19点";
            
            cell = timeCell;
            
            break;
        }
            
        default:
            break;
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (void) checkButtonPress:(UIButton *)sender
{
    NSLog(@"sender = %@",sender.associatedObject);
    
    OrderDetailViewController *orderDetailViewController = [[OrderDetailViewController alloc] init];
    orderDetailViewController.order = self.orders[sender.tag];
    [self.navigationController pushViewController:orderDetailViewController animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"indexPath.section = %ld",indexPath.section);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OrderDetailViewController *orderDetailViewController = [[OrderDetailViewController alloc] init];
    orderDetailViewController.order = self.orders[indexPath.section];
   //orderDetailViewController.segmentIndex = self.SegmentIndex;
    [self.navigationController pushViewController:orderDetailViewController animated:YES];
}

@end
