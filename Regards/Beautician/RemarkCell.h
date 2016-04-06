//
//  RemarkCell.h
//  Beautician
//
//  Created by dengqiang on 4/8/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"

@class Remark;

@interface RemarkCell : BaseTableViewCell

@property (nonatomic, strong) Remark *remark;

+ (CGFloat)cellHeightWithRemark:(Remark *)remark;

@end
