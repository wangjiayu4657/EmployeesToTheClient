//
//  OrderDetailViewController.m
//  Beautician
//
//  Created by dengqiang on 4/8/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "Order.h"
#import "OrderPetCell.h"
#import "RemainTimeCell.h"
#import "RichTextCell.h"
#import "RichTextItem.h"
#import "KeyValueTextCell.h"
#import "RemarkCell.h"
#import "ServiceItem.h"
#import "RemarkViewController.h"
#import "ServiceItemsViewController.h"
#import "RemarksViewController.h"

#pragma mark - SectionHeaderView

@interface SectionHeaderView : UIView

@property (nonatomic, assign) BOOL didSetupContraints;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation SectionHeaderView

- (instancetype)init
{
    if (self = [super init])
    {
        self.leftLabel = [[UILabel alloc] init];
        self.leftLabel.font = [UIFont systemFontOfSize:14];
        self.leftLabel.textColor = [UIColor blackColor];
        [self addSubview:self.leftLabel];
        
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.font = [UIFont systemFontOfSize:12];
        self.rightLabel.textColor = [UIColor colorWithHex:0x666666];
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.rightLabel];
        
        self.actionButton = [[UIButton alloc] init];
        [self addSubview:self.actionButton];
    }
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupContraints) {
        [self.leftLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.leftLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.rightLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [self.rightLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.actionButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.leftLabel withOffset:10];
        [self.actionButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.actionButton autoSetDimensionsToSize:CGSizeMake(40, 18)];
        
        self.didSetupContraints = YES;
    }
}

@end


#pragma mark - OrderDetailViewController

typedef NS_ENUM(NSUInteger, TABLE_VIEW_SECTION)
{
    TABLE_VIEW_SECTION_ORDER,
    TABLE_VIEW_SECTION_ADDITIONS,//增加
    TABLE_VIEW_SECTION_REMARK,//备注
    TABLE_VIEW_SECTION_COUNT
};

//typedef NS_ENUM(NSUInteger, TABLE_VIEW_SECTIONS)
//{
//    TABLE_VIEW_SECTIONS_ORDER,
//    TABLE_VIEW_SECTIONS_REMARK,//备注
//    TABLE_VIEW_SECTIONS_ADDITIONS,//增加
//    TABLE_VIEW_SECTIONS_COUNT
//};


typedef NS_ENUM(NSUInteger, TABLE_VIEW_ROW_ORDER)
{
    TABLE_VIEW_ROW_ORDER_SUIT,
    TABLE_VIEW_ROW_ORDER_PET,//宠物
    TABLE_VIEW_ROW_ORDER_ADDRESS,//地址
    TABLE_VIEW_ROW_ORDER_MOBILE,//电话
    TABLE_VIEW_ROW_ORDER_REMARK,//备注
    TABLE_VIEW_ROW_ORDER_TIME,//时间
    TABLE_VIEW_ROW_ORDER_EXTRA_INFO,//额外
    TABLE_VIEW_ROW_ORDER_COUNT
};

@interface OrderDetailViewController () <ServiceItemsViewControllerDelegate>

@property (nonatomic, assign) long long secondsLeft;

@end

@implementation OrderDetailViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单详情";
    self.ignoreSeparatorInset = YES;
    
    self.secondsLeft = [self.order.serviceDate timeIntervalSinceNow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (IBAction)actionButtonPressed:(UIButton *)sender
{
    if (sender.tag == TABLE_VIEW_SECTION_REMARK) {
        RemarkViewController *remarkViewController = [[RemarkViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:remarkViewController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
    else if (sender.tag == TABLE_VIEW_SECTION_ADDITIONS) {
        ServiceItemsViewController *serviceItemsViewController = [[ServiceItemsViewController alloc] init];
        serviceItemsViewController.delegate = self;
        serviceItemsViewController.selectedItems = self.order.additionalItems;
        [self.navigationController pushViewController:serviceItemsViewController animated:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return TABLE_VIEW_SECTION_COUNT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    switch (section)
        {
            case TABLE_VIEW_SECTION_ORDER:
                number = TABLE_VIEW_ROW_ORDER_COUNT;
                break;
                
            case TABLE_VIEW_SECTION_ADDITIONS:
                number = self.order.additionalItems.count > 0 ? self.order.additionalItems.count + 1: 0;
                break;
                
            case TABLE_VIEW_SECTION_REMARK:
                number = self.order.remarks.count;
                break;
                
            default:
                break;
        }
        return number;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44;
    switch (indexPath.section)
    {
        case TABLE_VIEW_SECTION_ORDER:
        {
            if (indexPath.row == TABLE_VIEW_ROW_ORDER_PET)
            {
                height = [OrderPetCell cellHeight];
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_EXTRA_INFO)
            {
                height = [RemainTimeCell cellHeight];
            }
            else
            {
                height = 30;
            }
            
            break;
        }
            
        case TABLE_VIEW_SECTION_ADDITIONS:
        {
            height = 30;
            
            break;
        }
            
        case TABLE_VIEW_SECTION_REMARK:
        {
            Remark *remark = self.order.remarks[indexPath.row];
            height = [RemarkCell cellHeightWithRemark:remark];
            break;
        }
            
        default:
            break;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section) {
        case TABLE_VIEW_SECTION_ORDER: {
            if (indexPath.row == TABLE_VIEW_ROW_ORDER_SUIT) {
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
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_PET) {
                NSString *cellIdentifier = @"orderPetCell";
                OrderPetCell *orderPetCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (orderPetCell == nil) {
                    orderPetCell = [[OrderPetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    orderPetCell.accessoryType = UITableViewCellAccessoryNone;
                    orderPetCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                orderPetCell.order = self.order;
                
                cell = orderPetCell;
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_TIME) {
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
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_EXTRA_INFO) {
                NSString *cellIdentifier = @"remainTimeCell";
                RemainTimeCell *remainTimeCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (remainTimeCell == nil) {
                    remainTimeCell = [[RemainTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    remainTimeCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                remainTimeCell.secondsLeft = self.secondsLeft;
                
                cell = remainTimeCell;
            }
            else {
                NSString *cellIdentifier = @"textCell";
                KeyValueTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (textCell == nil) {
                    textCell = [[KeyValueTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    textCell.keyFont = [UIFont systemFontOfSize:13];
                    textCell.valueFont = textCell.keyFont;
                    textCell.keyTextColor = [UIColor colorWithHex:0x333333];
                    textCell.valueTextColor = textCell.keyTextColor;
                    textCell.keyLabelWidth = 65;
                    textCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    textCell.selectionStyle = UITableViewCellSelectionStyleDefault;
                }
                
                if (indexPath.row == TABLE_VIEW_ROW_ORDER_ADDRESS) {
                    textCell.keyText = @"服务地址：";
                    textCell.valueText = self.order.address;
                }
                else if (indexPath.row == TABLE_VIEW_ROW_ORDER_MOBILE) {
                    textCell.keyText = @"联系电话：";
                    textCell.valueText = self.order.mobile;
                }
                else if (indexPath.row == TABLE_VIEW_ROW_ORDER_REMARK) {
                    textCell.keyText = @"备注：";
                    textCell.valueText = @"这狗太凶！";
                }
                
                cell = textCell;
            }
            
            break;
        }
        
        case TABLE_VIEW_SECTION_ADDITIONS: {
            NSString *cellIdentifier = @"additionalItemCell";
            KeyValueTextCell *additionalItemCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (additionalItemCell == nil) {
                additionalItemCell = [[KeyValueTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                additionalItemCell.keyFont = [UIFont systemFontOfSize:13];
                additionalItemCell.keyTextColor = [UIColor colorWithHex:0x333333];
                additionalItemCell.keyTextAlignment = NSTextAlignmentLeft;
                additionalItemCell.valueTextAlignment = NSTextAlignmentRight;
                additionalItemCell.accessoryType = UITableViewCellAccessoryNone;
                additionalItemCell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            
            if (indexPath.row < self.order.additionalItems.count)
            {
                additionalItemCell.valueFont = additionalItemCell.keyFont;
                additionalItemCell.valueTextColor = additionalItemCell.keyTextColor;
                additionalItemCell.keyLabelWidth = 65;
                ServiceItem *serviceItem = self.order.additionalItems[indexPath.row];
                additionalItemCell.keyText = serviceItem.name;
                additionalItemCell.valueText = [NSString stringWithFormat:@"￥%@", serviceItem.price];
            }
            else
            {
                additionalItemCell.valueFont = [UIFont boldSystemFontOfSize:16];
                additionalItemCell.valueTextColor = [UIColor colorWithHex:0xD0021B];
                
                additionalItemCell.keyLabelWidth = 100;
                NSString *keyText = [NSString stringWithFormat:@"需支付：<font size=4 color=black>￥%@</font>", @"140"];
                additionalItemCell.keyAttributedText = [[NSAttributedString alloc] initWithData:[keyText dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                
                additionalItemCell.valueText = @"支付成功";
            }
            
            cell = additionalItemCell;
            
            break;
        }
            
        case TABLE_VIEW_SECTION_REMARK: {
            NSString *cellIdentifier = @"remarkCell";
            RemarkCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if (remarkCell == nil) {
                remarkCell = [[RemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            
            Remark *remark = self.order.remarks[indexPath.row];
            remarkCell.remark = remark;
            
            cell = remarkCell;
            
            break;
        }
            
        default:
            break;
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == TABLE_VIEW_SECTION_REMARK)
    {
        return 10;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionHeaderView *headerView = [[SectionHeaderView alloc] init];
    switch (section) {
        case TABLE_VIEW_SECTION_ORDER:
            headerView.leftLabel.text = @"订单信息";
            headerView.rightLabel.text = @"完成时间：2015-04-01 20:00";
            headerView.actionButton = nil;
            break;
            
        case TABLE_VIEW_SECTION_ADDITIONS:
            headerView.leftLabel.text = @"额外项目";
            [headerView.actionButton setBackgroundImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
            break;
            
        case TABLE_VIEW_SECTION_REMARK:
            headerView.leftLabel.text = @"备注";
            [headerView.actionButton setBackgroundImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    headerView.actionButton.tag = section;
    [headerView.actionButton addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView setNeedsUpdateConstraints];
    [headerView updateConstraintsIfNeeded];
    
    return headerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    if (indexPath.section == TABLE_VIEW_SECTION_ORDER) {
        if (indexPath.row == TABLE_VIEW_ROW_ORDER_REMARK) {
            RemarksViewController *remarksViewController = [[RemarksViewController alloc] init];
            remarksViewController.remarks = self.order.remarks;
            [self.navigationController pushViewController:remarksViewController animated:YES];
        }
    }
    else if (indexPath.section == TABLE_VIEW_SECTION_REMARK) {
        RemarkViewController *remarkViewController = [[RemarkViewController alloc] init];
        remarkViewController.remark = self.order.remarks[indexPath.row];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:remarkViewController];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

#pragma mark - ServiceItemsViewControllerDelegate

- (void)didSelectServicesItems:(NSArray *)selectedItems
{
    self.order.additionalItems = selectedItems;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:TABLE_VIEW_SECTION_ADDITIONS] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
