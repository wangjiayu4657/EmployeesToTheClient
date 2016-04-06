//
//  RemainTimeCell.h
//  Beautician
//
//  Created by dengqiang on 4/7/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface RemainTimeCell : BaseTableViewCell

@property (nonatomic, assign) long long secondsLeft;

+ (CGFloat)cellHeight;

@end
