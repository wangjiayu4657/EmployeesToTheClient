//
//  MenuItemCell.m
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "RichTextCell.h"
#import "RichTextItem.h"

@interface RichTextCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tipsLabel;

@end

@implementation RichTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.iconImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = [UIColor colorWithHex:0x333333];
        [self.contentView addSubview:self.nameLabel];
        
        self.tipsLabel = [[UILabel alloc] init];
        self.tipsLabel.font = [UIFont systemFontOfSize:14];
        self.tipsLabel.textColor = [UIColor colorWithHex:0x999999];
        self.tipsLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.tipsLabel];
    }
    
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints)
    {
        if (self.type == RichTextCellTypeWithoutIcon)
        {
            [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:0];
            [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
            [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
            [self.iconImageView autoSetDimension:ALDimensionWidth toSize:0];
        }
        else
        {
            [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
            [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
            [self.iconImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
            [self.iconImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.iconImageView];
        }
        
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.iconImageView withOffset:15];
        [self.nameLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.iconImageView];
        
        [self.tipsLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nameLabel];
        [self.tipsLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.accessoryType == UITableViewCellAccessoryNone ? 15 : 0];
        [self.tipsLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (void)setType:(RichTextCellType)type
{
    _type = type;

    if (type == RichTextCellTypeWithoutIcon)
    {
        self.iconImageView.hidden = YES;
    }
    else
    {
        self.iconImageView.hidden = NO;
    }
}

- (void)setRichTextItem:(RichTextItem *)richTextItem
{
    _richTextItem = richTextItem;
    
    self.iconImageView.image = richTextItem.icon;
    self.nameLabel.text = richTextItem.name;
    self.tipsLabel.text = richTextItem.tips;
    
}

- (void)setTipsFont:(UIFont *)tipsFont
{
    _tipsFont = tipsFont;
    self.tipsLabel.font = tipsFont;
}

- (void)setNameFont:(UIFont *)nameFont
{
    _nameFont = nameFont;
    self.nameLabel.font = nameFont;
}

@end
