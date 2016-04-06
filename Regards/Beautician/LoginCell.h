//
//  LoginCell.h
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LoginCell : BaseTableViewCell

@property (nonatomic, strong) UITextField *mobileTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

+ (CGFloat)cellHeight;

@end
