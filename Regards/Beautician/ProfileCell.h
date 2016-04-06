//
//  ProfileCell.h
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ProfileCell : BaseTableViewCell

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatarURL;
@property (nonatomic, assign) NSUInteger status;

+ (CGFloat)cellHeight;

@end
