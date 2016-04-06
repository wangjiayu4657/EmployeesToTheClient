//
//  LoginCell.m
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "LoginCell.h"

@interface LoginCell ()

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *mobileImageView;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UILabel *separatorLine;

@end

@implementation LoginCell

+ (CGFloat)cellHeight
{
    return 100;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.containerView = [[UIView alloc] init];
        self.containerView.backgroundColor = [UIColor whiteColor];
        self.containerView.layer.borderWidth = 0.5;
        self.containerView.layer.borderColor = [UIColor colorWithHex:0xFFCF99].CGColor;
        self.containerView.layer.cornerRadius = 5.0;
        self.containerView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.containerView];
        
        self.mobileImageView = [[UIImageView alloc] init];
        self.mobileImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.mobileImageView.image = [UIImage imageNamed:@"login_icon_mobile"];
        [self.containerView addSubview:self.mobileImageView];
        
        self.passwordImageView = [[UIImageView alloc] init];
        self.passwordImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.passwordImageView.image = [UIImage imageNamed:@"login_icon_password"];
        [self.containerView addSubview:self.passwordImageView];
        
        self.mobileTextField = [[UITextField alloc] init];
        self.mobileTextField.placeholder = @"手机号";
        self.mobileTextField.font = [UIFont systemFontOfSize:15];
        self.mobileTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.mobileTextField.returnKeyType = UIReturnKeyNext;
        [self.containerView addSubview:self.mobileTextField];
        
        self.passwordTextField = [[UITextField alloc] init];
        self.passwordTextField.placeholder = @"密码";
        self.passwordTextField.font = [UIFont systemFontOfSize:15];
        self.passwordTextField.keyboardType = UIKeyboardTypeDefault;
        self.passwordTextField.returnKeyType = UIReturnKeyDone;
        self.passwordTextField.secureTextEntry = YES;
        [self.containerView addSubview:self.passwordTextField];
        
        self.separatorLine = [[UILabel alloc] init];
        self.separatorLine.backgroundColor = [UIColor colorWithHex:0xFFCF99];
        [self.containerView addSubview:self.separatorLine];
    }
    
    return self;
}

#pragma mark - Layout

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints) {
        [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.containerView autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.containerView autoSetDimension:ALDimensionHeight toSize:80];
        
        [self.mobileTextField autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [self.mobileTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
        [self.mobileTextField autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.mobileTextField autoSetDimension:ALDimensionHeight toSize:40];
        
        [self.mobileImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
        [self.mobileImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.mobileTextField];
        [self.mobileImageView autoSetDimensionsToSize:CGSizeMake(30, 30)];
        
        [self.passwordTextField autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.mobileTextField];
        [self.passwordTextField autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
        [self.passwordTextField autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.passwordTextField autoSetDimension:ALDimensionHeight toSize:40];
        
        [self.passwordImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
        [self.passwordImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.passwordTextField];
        [self.passwordImageView autoSetDimensionsToSize:CGSizeMake(30, 30)];
        
        [self.separatorLine autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.separatorLine autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.separatorLine autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.separatorLine autoSetDimension:ALDimensionHeight toSize:0.5];
        
        self.didSetupConstraints = YES;
    }
}

@end
