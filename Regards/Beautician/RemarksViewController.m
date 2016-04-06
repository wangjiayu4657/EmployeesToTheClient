//
//  RemarksViewController.m
//  Beautician
//
//  Created by dengqiang on 4/10/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "RemarksViewController.h"
#import "Remark.h"
#import "RemarkCell.h"
#import "RemarkViewController.h"

@interface RemarksViewController ()

@end

@implementation RemarksViewController

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
    
    self.title = @"备注";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)addButtonPressed:(id)sender
{
    RemarkViewController *remarkViewController = [[RemarkViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:remarkViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.remarks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Remark *remark = self.remarks[indexPath.row];
    return [RemarkCell cellHeightWithRemark:remark];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"remarkCell";
    RemarkCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (remarkCell == nil) {
        remarkCell = [[RemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    remarkCell.remark = self.remarks[indexPath.row];
    
    [remarkCell setNeedsUpdateConstraints];
    [remarkCell updateConstraintsIfNeeded];
    
    return remarkCell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RemarkViewController *remarkViewController = [[RemarkViewController alloc] init];
    remarkViewController.remark = self.remarks[indexPath.row];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:remarkViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
