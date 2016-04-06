//
//  LoginViewController.m
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginCell.h"
#import "NSObject+AssociatedObject.h"
#import "HttpClient.h"
@interface LoginViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *activeTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180)];
    headerView.contentMode = UIViewContentModeScaleAspectFit;
    headerView.image = [UIImage imageNamed:@"login_img_header"];
    self.tableView.tableHeaderView = headerView;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width , 100)];
    UIButton *loginButton = [UIManager buttonWithColor:APP_MAIN_COLOR title:@"登录" cornerRadius:5.0];
    loginButton.frame = CGRectMake(10, 0, self.view.bounds.size.width - 20, 40);
    [loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:loginButton];
    self.tableView.tableFooterView = footerView;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.tableView addGestureRecognizer:tapGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)dismissKeyboard
{
    if ([self.activeTextField isFirstResponder])
    {
        [self.activeTextField resignFirstResponder];
    }
}

- (IBAction)loginButtonPressed:(id)sender
{
    LoginCell *loginCell = (LoginCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([loginCell.mobileTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 11)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码"];
        return;
    }
    if (loginCell.passwordTextField.text.length == 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    
    [User loginWithMobile:@"18667026232" password:@"18667026232" block:^(NSString *accessToken, NSError *error)
    {
        if (error)
        {
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        }
        else
        {
            [User currentUser].id = 1;
            [self dismissKeyboard];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [LoginCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * const cellIdentifier = @"loginCell";
    LoginCell *loginCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (loginCell == nil)
    {
        loginCell = [[LoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        loginCell.backgroundColor = [UIColor clearColor];
        loginCell.selectionStyle = UITableViewCellSelectionStyleNone;
        loginCell.mobileTextField.delegate = self;
        loginCell.passwordTextField.delegate = self;
        loginCell.mobileTextField.associatedObject = @YES;
        [loginCell.mobileTextField becomeFirstResponder];
    }
    
    [loginCell setNeedsUpdateConstraints];
    [loginCell updateConstraintsIfNeeded];
    
    return loginCell;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    NSLog(@"%@",textField.text);
    self.activeTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.associatedObject)
    {
        LoginCell *loginCell = (LoginCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [loginCell.passwordTextField becomeFirstResponder];
    }
    else
    {
        [self loginButtonPressed:nil];
    }
//    NSLog(@"textField = %@",textField);
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (!textField.associatedObject)
    {
        return YES;
    }
    
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filter = [[string componentsSeparatedByCharactersInSet:characterSet] componentsJoinedByString:@""];
//    NSLog(@"filter = %@",filter);
//    NSLog(@"string = %@",string);
    return [string isEqualToString:filter];
}

@end
