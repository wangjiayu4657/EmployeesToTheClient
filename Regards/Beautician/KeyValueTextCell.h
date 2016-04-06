//
//  KeyValueTextCell.h
//  Beautician
//
//  Created by dengqiang on 4/7/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface KeyValueTextCell : BaseTableViewCell

@property (nonatomic, strong) NSString *keyText;
@property (nonatomic, strong) NSString *valueText;
@property (nonatomic, strong) UIFont *keyFont;
@property (nonatomic, strong) UIFont *valueFont;
@property (nonatomic, strong) UIColor *keyTextColor;
@property (nonatomic, strong) UIColor *valueTextColor;
@property (nonatomic, assign) NSTextAlignment keyTextAlignment;
@property (nonatomic, assign) NSTextAlignment valueTextAlignment;
@property (nonatomic, strong) NSAttributedString *keyAttributedText;
@property (nonatomic, strong) NSAttributedString *valueAttributedText;
@property (nonatomic, assign) CGFloat keyLabelWidth;

@end
