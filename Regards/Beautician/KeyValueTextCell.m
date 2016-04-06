//
//  KeyValueTextCell.m
//  Beautician
//
//  Created by dengqiang on 4/7/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "KeyValueTextCell.h"

@interface KeyValueTextCell ()

@property (nonatomic, strong) UILabel *keyTextLabel;
@property (nonatomic, strong) UILabel *valueTextLabel;

@end

@implementation KeyValueTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.keyTextLabel = [[UILabel alloc] init];
        self.keyTextLabel.font = [UIFont systemFontOfSize:14];
        self.keyTextLabel.textColor = [UIColor colorWithHex:0x999999];
        [self.contentView addSubview:self.keyTextLabel];
        
        self.valueTextLabel = [[UILabel alloc] init];
        self.valueTextLabel.font = [UIFont systemFontOfSize:14];
        self.valueTextLabel.textColor = [UIColor colorWithHex:0x333333];
        [self.contentView addSubview:self.valueTextLabel];
        
        self.keyLabelWidth = 80;
    }
    
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints) {
        [self.keyTextLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.keyTextLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.keyTextLabel autoSetDimension:ALDimensionWidth toSize:self.keyLabelWidth];
        
        [self.valueTextLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:self.accessoryType == UITableViewCellAccessoryNone ? 15 : 0];
        [self.valueTextLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.keyTextLabel];
        [self.valueTextLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (void)setKeyText:(NSString *)keyText
{
    _keyText = keyText;
    self.keyTextLabel.text = keyText;
}

- (void)setValueText:(NSString *)valueText
{
    _valueText = valueText;
    self.valueTextLabel.text = valueText;
}

- (void)setKeyFont:(UIFont *)keyFont
{
    _keyFont = keyFont;
    self.keyTextLabel.font = keyFont;
}

- (void)setValueFont:(UIFont *)valueFont
{
    _valueFont = valueFont;
    self.valueTextLabel.font = valueFont;
}

- (void)setKeyTextColor:(UIColor *)keyTextColor
{
    _keyTextColor = keyTextColor;
    self.keyTextLabel.textColor = keyTextColor;
}

- (void)setValueTextColor:(UIColor *)valueTextColor
{
    _valueTextColor = valueTextColor;
    self.valueTextLabel.textColor = valueTextColor;
}

- (void)setKeyLabelWidth:(CGFloat)keyLabelWidth
{
    _keyLabelWidth = keyLabelWidth;
}

- (void)setKeyTextAlignment:(NSTextAlignment)keyTextAlignment
{
    _keyTextAlignment = keyTextAlignment;
    self.keyTextLabel.textAlignment = keyTextAlignment;
}

- (void)setValueTextAlignment:(NSTextAlignment)valueTextAlignment
{
    _valueTextAlignment = valueTextAlignment;
    self.valueTextLabel.textAlignment = valueTextAlignment;
}

- (void)setKeyAttributedText:(NSAttributedString *)keyAttributedText
{
    _keyAttributedText = keyAttributedText;
    self.keyTextLabel.attributedText = keyAttributedText;
}

- (void)setValueAttributedText:(NSAttributedString *)valueAttributedText
{
    _valueAttributedText = valueAttributedText;
    self.valueTextLabel.attributedText = valueAttributedText;
}

@end
