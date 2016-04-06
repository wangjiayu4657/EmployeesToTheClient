//
//  HomeViewController.m
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "ProfileCell.h"
#import "RichTextCell.h"
#import "RichTextItem.h"
#import "OrdersViewController.h"
#import "Order.h"
#import "Pet.h"
#import "OrderPetCell.h"
#import "KeyValueTextCell.h"
#import "RemainTimeCell.h"
#import "RemarkViewController.h"
#import "ServiceItemsViewController.h"

#import <MapKit/MapKit.h>
#import <AddressBook/AddressBook.h>

#import "ServiceItem.h"///////////
#import "HttpClient.h"
#import "User.h"
//#import "AFHTTPRequestOperationManager.h"
//#define  shopAPIURLRequest @"http://42.96.188.208:6543/shop"
//#define  shopAPIURLRequest @"http://192.168.158.241:8888/"
#define  shopAPIURLRequest @"https://api.douban.com/v2/book/1220562"

typedef NS_ENUM(NSUInteger, TABLE_VIEW_SECTION) {
    TABLE_VIEW_SECTION_SUMMARY,//简介
    TABLE_VIEW_SECTION_ORDER,  //订单
    TABLE_VIEW_SECTION_ADDITIONS,/////////////
    TABLE_VIEW_SECTION_COUNT   //
};

typedef NS_ENUM(NSUInteger, TABLE_VIEW_ROW_ORDER) {
    TABLE_VIEW_ROW_ORDER_SUIT,   //
    TABLE_VIEW_ROW_ORDER_PET,    //宠物
    TABLE_VIEW_ROW_ORDER_ADDRESS,//地址
    TABLE_VIEW_ROW_ORDER_MOBILE,//手机
    TABLE_VIEW_ROW_ORDER_REMARK,//备注
    TABLE_VIEW_ROW_ORDER_TIME,  //时间
    TABLE_VIEW_ROW_ORDER_COUNT
};

@interface HomeViewController ()<ServiceItemsViewControllerDelegate>

@property (nonatomic, strong) Order *order;
@property (nonatomic, assign) long long secondsLeft;

@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIView *todoHeaderView;
@property (nonatomic, strong) UIView *todoHeaderView1;
@property (nonatomic, strong) UILabel *todoHeaderViewTitleLabel;
@property (nonatomic, strong) UILabel *todoHeaderViewTimeLabel;

@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIButton *actionButton;

@end

@implementation HomeViewController

- (instancetype)init
{
    if (self = [super initWithStyle:UITableViewStyleGrouped])
    {
        self.title = APP_NAME;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    User *user = [User currentUser];
    self.token = user.accessToken;
    NSLog(@"_token = %@",_token);
    [self RequestData];
    _STATUS = 1;
    self.ignoreSeparatorInset = YES;
    
    self.startButton = [UIManager buttonWithColor:[UIColor colorWithHex:0x9DD55D] title:@"开始服务"];
    [self.startButton addTarget:self action:@selector(startButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startButton];
    
    self.todoHeaderView = [[UIView alloc] init];
    self.todoHeaderView1 = [[UIView alloc] init];
    self.todoHeaderViewTitleLabel = [[UILabel alloc] init];
    self.todoHeaderViewTitleLabel.font = [UIFont systemFontOfSize:14];
    self.todoHeaderViewTitleLabel.textColor = [UIColor colorWithHex:0x417505];
    self.todoHeaderViewTitleLabel.text = @"下一订单信息";
    [self.todoHeaderView addSubview:self.todoHeaderViewTitleLabel];
    
    self.todoHeaderViewTimeLabel = [[UILabel alloc] init];
    self.todoHeaderViewTimeLabel.font = [UIFont systemFontOfSize:14];
    self.todoHeaderViewTimeLabel.textColor = [UIColor colorWithHex:0xF5A623];
    self.todoHeaderViewTimeLabel.textAlignment = NSTextAlignmentRight;
    self.todoHeaderViewTimeLabel.text = @"2015-04-08 19点";
    [self.todoHeaderView addSubview:self.todoHeaderViewTimeLabel];
    
    
    
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.text = @"额外项目";
    self.leftLabel.font = [UIFont systemFontOfSize:14];
    self.leftLabel.textColor = [UIColor blackColor];
    [self.todoHeaderView1 addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.font = [UIFont systemFontOfSize:13];
    self.rightLabel.textColor = [UIColor colorWithHex:0x666666];
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    [self.todoHeaderView1 addSubview:self.rightLabel];
    
    //self.actionButton = [[UIButton alloc] init];
    self.actionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.actionButton setBackgroundImage:[UIImage imageNamed:@"icon_add"] forState:UIControlStateNormal];
    self.todoHeaderView1.userInteractionEnabled = YES;
    [self.todoHeaderView1 addSubview:self.actionButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needLoginNotification:) name:AppManagerNeedLoginNotification object:nil];
    
    //如果没有订单时显示的画面
    self.subView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 250, 80, 80)];
    self.subView.image = [UIImage imageNamed:@"icon_add"];
    self.subView.hidden = YES;
    [self.view addSubview:self.subView];
    
    
    ServiceItem *serviceItem1 = [[ServiceItem alloc] init];///////////////
    serviceItem1.name = @"宠物刷牙";
    serviceItem1.price = @"20";
    
    ServiceItem *serviceItem2 = [[ServiceItem alloc] init];
    serviceItem2.name = @"宠物SPA";
    serviceItem2.price = @"150";////////////////
    
    PetBreed *breed = [[PetBreed alloc] init];
    breed.name = @"萨摩耶";
    
    Pet *pet = [[Pet alloc] init];
    pet.breed = breed;
    pet.name = @"妞妞";
    pet.age = @"1岁2个月";
    pet.avatarURL = @"http://www.cndog.net/upimg/2013/10/2013101010292397.jpg";
    
    self.order = [[Order alloc] init];
    self.order.pet = pet;
    self.order.amount = @"69.9";
    self.order.quantity = 2;
    self.order.serviceDate = [[[NSDate alloc] init] dateByAddingTimeInterval:100000];
    self.order.address = @"西湖区文一西路云桂花园7幢201";
    self.order.mobile = @"18605812631";
    self.order.additionalItems = @[serviceItem1, serviceItem2];//////////
    self.secondsLeft = [self.order.serviceDate timeIntervalSinceNow];
    
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(refreshRemainTime) userInfo:nil repeats:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
//    UIDynamicAnimator
    
    if ([User currentUser].isValid == NO)
    {
        //[AppManager postNotificationName:AppManagerNeedLoginNotification object:nil];
    }
}


//请求数据
- (void) RequestData
{

    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *param = [[NSMutableDictionary alloc] initWithCapacity:1];
    NSString *str = VALID_STRING(_token);
    if (![str isEqualToString:@""])
    {
        [param setObject:_token forKey:@"token"];
    }
    
    [aClient postPath:shopAPIURLRequest params:param resultBlock:^(id responseObject, NSError *error)
     {
         NSLog(@"responseObject = %@",responseObject);
    }];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Layout

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if (!self.didSetupConstraints)
    {
        [self.startButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.startButton autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.startButton autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.startButton autoSetDimension:ALDimensionHeight toSize:40];
        
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.tableView autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:self.startButton];
        
        [self.todoHeaderViewTitleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.todoHeaderViewTitleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.todoHeaderViewTimeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [self.todoHeaderViewTimeLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.leftLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.leftLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.rightLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.rightLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.actionButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.leftLabel withOffset:10];
        [self.actionButton autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.actionButton  autoSetDimensionsToSize:CGSizeMake(40, 18)];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (IBAction)startButtonPressed:(id)sender
{
    if (_STATUS == 2)
    {
        self.startButton.backgroundColor = [UIColor colorWithHex:0xD0021B];
        [self.startButton setTitle:@"完成服务" forState:UIControlStateNormal];
    }
    else
    {
        self.startButton.backgroundColor = [UIColor colorWithHex:0x9DD55D];
        [self.startButton setTitle:@"开始服务" forState:UIControlStateNormal];
    }

    NSLog(@"Start");
}

#pragma mark - Timer

- (void)refreshRemainTime
{
    self.secondsLeft = [self.order.serviceDate timeIntervalSinceNow];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:TABLE_VIEW_ROW_ORDER_TIME inSection:TABLE_VIEW_SECTION_ORDER]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - Notification

- (void)needLoginNotification:(NSNotification *)notification
{
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_STATUS == 2)
    {
        return TABLE_VIEW_SECTION_COUNT;
    }
    else
    {
        //self.subView.hidden = NO;//如果没有订单则显示
        return TABLE_VIEW_SECTION_COUNT - 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger number = 0;
    switch (section)
    {
        case TABLE_VIEW_SECTION_SUMMARY:
            number = 2;
            break;
            
        case TABLE_VIEW_SECTION_ORDER:
            number = TABLE_VIEW_ROW_ORDER_COUNT;
            break;
        case TABLE_VIEW_SECTION_ADDITIONS:///////////
            if (_STATUS == 2)
            {
                number = self.order.additionalItems.count > 0? self.order.additionalItems.count+1:0;
            }
            else
            {
                break;
            }
           
            //number = 3;
            break;////////////
        default:
            break;
    }
    
    return number;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    switch (indexPath.section)
    {
        case TABLE_VIEW_SECTION_SUMMARY:
        {
            if (indexPath.row == 0)
            {
                height = [ProfileCell cellHeight];
            }
            else if (indexPath.row == 1)
            {
                height = 44;
            }
            
            break;
        }
            
        case TABLE_VIEW_SECTION_ORDER:
        {
            if (indexPath.row == TABLE_VIEW_ROW_ORDER_PET)
            {
                height = [OrderPetCell cellHeight];
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_TIME)
            {
                height = [RemainTimeCell cellHeight];
            }
            else
            {
                height = 30;
            }
            break;
        }
       case TABLE_VIEW_SECTION_ADDITIONS:///////////
        {
            if (_STATUS == 2)
            {
                height = 30;
                break;
            }
            else
            {
                return 0.1;
                break;
            }
        }////////
            
        default:
            break;
    }
    
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.section)
    {
        case TABLE_VIEW_SECTION_SUMMARY:
        {
            if (indexPath.row == 0)
            {
                NSString *cellIdentifier = @"profileCell";
                ProfileCell *profileCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (profileCell == nil)
                {
                    profileCell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    profileCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                profileCell.avatarURL = @"http://pic41.nipic.com/20140508/12413954_161446509121_2.png";
                profileCell.name = @"乔巴";
                profileCell.status = 1;
                self.STATUS = profileCell.status;
                cell = profileCell;
            }
            else if (indexPath.row == 1)
            {
                NSString *cellIdentifier = @"orderCell";
                RichTextCell *richTextCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (richTextCell == nil) {
                    richTextCell = [[RichTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    richTextCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    richTextCell.nameFont = [UIFont systemFontOfSize:15];
                }
                
                RichTextItem *item = [[RichTextItem alloc] init];
                item.id = RichTextItemIdOrders;
                item.name = @"全部订单";
                item.icon = [UIImage imageNamed:@"home_icon_orders"];
                item.tips = @"5";
                
                richTextCell.richTextItem = item;
                cell = richTextCell;
            }
            
            break;
        }
            
        case TABLE_VIEW_SECTION_ORDER:
        {
            if (indexPath.row == TABLE_VIEW_ROW_ORDER_SUIT)
            {
                NSString *cellIdentifier = @"orderSuitCell";
                RichTextCell *orderSuitCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (orderSuitCell == nil)
                {
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
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_PET)
            {
                NSString *cellIdentifier = @"orderPetCell";
                OrderPetCell *orderPetCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (orderPetCell == nil)
                {
                    orderPetCell = [[OrderPetCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    orderPetCell.accessoryType = UITableViewCellAccessoryNone;
                    orderPetCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                orderPetCell.order = self.order;
                cell = orderPetCell;
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_TIME)
            {
                NSString *cellIdentifier = @"remainTimeCell";
                RemainTimeCell *remainTimeCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (remainTimeCell == nil)
                {
                    remainTimeCell = [[RemainTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                }
                
                remainTimeCell.secondsLeft = self.secondsLeft;
                
                cell = remainTimeCell;
            }
            else
            {
                NSString *cellIdentifier = @"textCell";
                KeyValueTextCell *textCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (textCell == nil)
                {
                    textCell = [[KeyValueTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    textCell.keyFont = [UIFont systemFontOfSize:13];
                    textCell.valueFont = textCell.keyFont;
                    textCell.keyTextColor = [UIColor colorWithHex:0x666666];
                    textCell.valueTextColor = textCell.keyTextColor;
                    textCell.keyLabelWidth = 65;
                    textCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    textCell.selectionStyle = UITableViewCellSelectionStyleDefault;
                }
                
                if (indexPath.row == TABLE_VIEW_ROW_ORDER_ADDRESS)
                {
                    textCell.keyText = @"服务地址：";
                    textCell.valueText = self.order.address;
                }
                else if (indexPath.row == TABLE_VIEW_ROW_ORDER_MOBILE)
                {
                    textCell.keyText = @"联系电话：";
                    textCell.valueText = self.order.mobile;
                }
                else if (indexPath.row == TABLE_VIEW_ROW_ORDER_REMARK)
                {
                    textCell.keyText = @"备注：";
                    textCell.valueText = @"这狗太凶！";
                }
                
                cell = textCell;
            }
            
            break;
            
           
        }
        case TABLE_VIEW_SECTION_ADDITIONS:///////////
        {
            if (self.STATUS == 2)
            {
               static NSString *cellIdentifier = @"additionalItemCell";
                KeyValueTextCell *additionItemCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
                if (additionItemCell == nil)
                {
                    additionItemCell = [[KeyValueTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
                    additionItemCell.keyFont = [UIFont systemFontOfSize:13];
                    additionItemCell.keyTextColor = [UIColor colorWithHex:0x333333];
                   
                    additionItemCell.keyTextAlignment = NSTextAlignmentLeft;
                    additionItemCell.valueTextAlignment = NSTextAlignmentRight;
                    additionItemCell.accessoryType = UITableViewCellAccessoryNone;
                    additionItemCell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
               
                if (indexPath.row < self.order.additionalItems.count)
                {
                    additionItemCell.keyFont = [UIFont systemFontOfSize:13];
                    additionItemCell.valueFont = additionItemCell.keyFont;
                    additionItemCell.keyTextColor = [UIColor blackColor];
                    additionItemCell.valueTextColor = additionItemCell.keyTextColor;
                    additionItemCell.keyLabelWidth = 65;
                
                    ServiceItem *serviceItem = self.order.additionalItems[indexPath.row];
                    additionItemCell.keyText = serviceItem.name;
                    additionItemCell.valueText = [NSString stringWithFormat:@"￥%@",serviceItem.price];
                   
                }
                else
                {
                    additionItemCell.keyFont = [UIFont systemFontOfSize:16];
                    additionItemCell.valueFont = additionItemCell.keyFont;
                    additionItemCell.keyTextColor = [UIColor colorWithHex:0xD0021B];
                    additionItemCell.valueTextColor = additionItemCell.keyTextColor;
                    additionItemCell.keyLabelWidth = 100;
                
                    NSString *keyText = [NSString stringWithFormat:@"需支付<font size = 4,color = black> ￥%@</font>",@"140"];
                    additionItemCell.keyAttributedText = [[NSAttributedString alloc] initWithData:[keyText dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
                    additionItemCell.valueText = @"支付成功";
                   
                }
             cell = additionItemCell;
             break;
            }
         else
            {
                cell = nil;
                break;
            }
        }
        default:
            break;
    }
    
    [cell setNeedsUpdateConstraints];
    [cell updateConstraintsIfNeeded];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    switch (section) {
        case TABLE_VIEW_SECTION_SUMMARY:
            height = 0.1;
            break;
            
        case TABLE_VIEW_SECTION_ORDER:
            height = 30;
            break;
            
            case TABLE_VIEW_SECTION_ADDITIONS:///////////
            if (_STATUS == 2)
            {
                height = 30;
                break;////////
            }
            else
            {
                return 0.1;
                break;
            }
            
        default:
            break;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height;
    switch (section) {
        case TABLE_VIEW_SECTION_SUMMARY:
            height = 0.1;
            break;
            
        case TABLE_VIEW_SECTION_ORDER:
            height = 0.1;
            break;
            
        case TABLE_VIEW_SECTION_ADDITIONS://///////
            if (_STATUS == 2)
            {
                height = 10;
                break;////////////
            }
           else
           {
               return 0.1;
               break;
           }
        default:
            break;
    }
    
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //self.actionButton.tag = section;
    [self.actionButton addTarget:self action:@selector(actionButtonPress) forControlEvents:UIControlEventTouchUpInside];
    if (section == 1)
    {
        return self.todoHeaderView;
    }
    else if (section == 2)
    {
        if (_STATUS == 2)
        {
            return self.todoHeaderView1;
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}

#pragma mark - actionButton
- (void) actionButtonPress
{
        ServiceItemsViewController *serviceItemsView = [[ServiceItemsViewController alloc] init];
        serviceItemsView.delegate = self;
        serviceItemsView.selectedItems = self.order.additionalItems;
        [self.navigationController pushViewController:serviceItemsView animated:YES];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section)
    {
        case TABLE_VIEW_SECTION_SUMMARY:
        {
            if (indexPath.row == 1)
            {
                OrdersViewController *ordersViewController = [[OrdersViewController alloc] init];
                [self.navigationController pushViewController:ordersViewController animated:YES];
            }
            break;
        }
        case TABLE_VIEW_SECTION_ORDER:
        {
            if (indexPath.row == TABLE_VIEW_ROW_ORDER_ADDRESS)
            {
//                if ([[UIApplicationsharedApplication] canOpenURL:[NSURLURLWithString:@"baidumap://map/"]]) {
//                    
//                }
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_MOBILE)
            {
                [AppManager dial:self.order.mobile];
            }
            else if (indexPath.row == TABLE_VIEW_ROW_ORDER_REMARK)
            {
                RemarkViewController *remarkViewController = [[RemarkViewController alloc] init];
                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:remarkViewController];
                [self presentViewController:navigationController animated:YES completion:nil];
            }
            
            break;
        }
            
        default:
            break;
    }
}


- (void)didSelectServicesItems:(NSArray *)selectedItems
{
    NSLog(@"selectedItems = %@",selectedItems);
    self.order.additionalItems = selectedItems;
    NSLog(@"selectedItems = %ld",selectedItems.count);
    //更新TABLE_VIEW_SECTION_ADDITIONS组的数据并使用动画
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:TABLE_VIEW_SECTION_ADDITIONS] withRowAnimation:UITableViewRowAnimationAutomatic];
}
@end
