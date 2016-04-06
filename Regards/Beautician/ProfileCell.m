//
//  ProfileCell.m
//  Beautician
//
//  Created by dengqiang on 4/5/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "ProfileCell.h"
#import "UIImageView+WebCache.h"

@interface ProfileCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *statusLabel;

@end

@implementation ProfileCell

+ (CGFloat)cellHeight
{
    return 80;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.avatarImageView = [[UIImageView alloc] init];
        self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.avatarImageView.layer.borderWidth = 0.5;
        self.avatarImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.avatarImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.avatarImageView];
        
        self.nameLabel = [[UILabel alloc] init];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.nameLabel.textColor = [UIColor colorWithHex:0x333333];
        [self.contentView addSubview:self.nameLabel];
        
        self.statusLabel = [[UILabel alloc] init];
        self.statusLabel.font = [UIFont systemFontOfSize:14];
        self.statusLabel.textColor = [UIColor colorWithHex:0x417505];
        self.statusLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.statusLabel];
    }
    
    return self;
}

#pragma mark - Layout

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints)
    {
        [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        [self.avatarImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.avatarImageView];
        self.avatarImageView.layer.cornerRadius = ([[self class] cellHeight] - 20) / 2.0;
        
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatarImageView withOffset:15];
        [self.nameLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.statusLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [self.statusLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nameLabel withOffset:10];
        [self.statusLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (void)setAvatarURL:(NSString *)avatarURL
{
    _avatarURL = avatarURL;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:avatarURL]];
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.nameLabel.text = name;
}

- (void)setStatus:(NSUInteger)status
{
    _status = status;
    if (status == 1)
    {
        self.statusLabel.text = @"空闲中";
    }
    else
    {
        self.statusLabel.text = @"正在服务";
        self.statusLabel.textColor  = [UIColor colorWithHex:0xD0021B];
    }
    
}

@end
