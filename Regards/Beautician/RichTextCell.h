//
//  MenuItemCell.h
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "BaseTableViewCell.h"

typedef NS_OPTIONS(NSUInteger, RichTextCellType)
{
    RichTextCellTypeDefault,
    RichTextCellTypeWithoutIcon
};

@class RichTextItem;

@interface RichTextCell : BaseTableViewCell

@property (nonatomic, strong) RichTextItem *richTextItem;
@property (nonatomic, assign) RichTextCellType type;
@property (nonatomic, strong) UIFont *nameFont;
@property (nonatomic, strong) UIFont *tipsFont;

@end
