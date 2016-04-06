//
//  OrderPetCell.m
//  Beautician
//
//  Created by dengqiang on 4/7/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "OrderPetCell.h"
#import "Order.h"
#import "Pet.h"
#import "UIImageView+WebCache.h"

@interface OrderPetCell ()

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *breedLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *quantityLabel;
@property (nonatomic, strong) UIImageView *genderImageView;

@end

@implementation OrderPetCell

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
        self.nameLabel.font = [UIFont systemFontOfSize:14];
        self.nameLabel.textColor = [UIColor colorWithHex:0xC06C00];
        [self.contentView addSubview:self.nameLabel];
        
        self.genderImageView = [[UIImageView alloc] init];
        self.genderImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.genderImageView];
        
        self.breedLabel = [[UILabel alloc] init];
        self.breedLabel.font = [UIFont systemFontOfSize:12];
        self.breedLabel.textColor = [UIColor colorWithHex:0x666666];
        [self.contentView addSubview:self.breedLabel];
        
        self.ageLabel = [[UILabel alloc] init];
        self.ageLabel.font = [UIFont systemFontOfSize:12];
        self.ageLabel.textColor = [UIColor colorWithHex:0x666666];
        [self.contentView addSubview:self.ageLabel];
        
        self.amountLabel = [[UILabel alloc] init];
        self.amountLabel.font = [UIFont systemFontOfSize:16];
        self.amountLabel.textColor = [UIColor colorWithHex:0x333333];
        [self.contentView addSubview:self.amountLabel];
        
        self.quantityLabel = [[UILabel alloc] init];
        self.quantityLabel.font = [UIFont systemFontOfSize:12];
        self.quantityLabel.textColor = [UIColor colorWithHex:0x666666];
        [self.contentView addSubview:self.quantityLabel];
    }
    
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints) {
        [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
        [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [self.avatarImageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        [self.avatarImageView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionHeight ofView:self.avatarImageView];
        self.avatarImageView.layer.cornerRadius = ([[self class] cellHeight] - 20) / 2.0;
        
        [self.nameLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.avatarImageView withOffset:20];
        [self.nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self.avatarImageView withOffset:3];
        
        [self.genderImageView autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:self.nameLabel withOffset:10];
        [self.genderImageView autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.nameLabel];
        [self.genderImageView autoSetDimensionsToSize:CGSizeMake(15, 15)];
        
        [self.breedLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.nameLabel];
        [self.breedLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.nameLabel withOffset:5];
        
        [self.ageLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self.breedLabel];
        [self.ageLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.breedLabel withOffset:5];
        
        [self.amountLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [self.amountLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:22];
        
        [self.quantityLabel autoPinEdge:ALEdgeRight toEdge:ALEdgeRight ofView:self.amountLabel];
        [self.quantityLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:22];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (void)setOrder:(Order *)order
{
    _order = order;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:order.pet.avatarURL]];
    self.nameLabel.text = order.pet.name;
    self.breedLabel.text = order.pet.breed.name;
    self.ageLabel.text = order.pet.age;
    [self.genderImageView sd_setImageWithURL:[NSURL URLWithString:@"http://ico.ooopic.com/iconset01/vista-love-icons/gif/99084.gif"]];
    self.amountLabel.text = [NSString stringWithFormat:@"￥%@", order.amount];
    self.quantityLabel.text = [NSString stringWithFormat:@"x%lu", (unsigned long)order.quantity];
}

@end
