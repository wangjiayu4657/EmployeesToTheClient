//
//  RemainTimeCell.m
//  Beautician
//
//  Created by dengqiang on 4/7/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "RemainTimeCell.h"

@interface RemainTimeCell ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation RemainTimeCell

+ (CGFloat)cellHeight
{
    return 44;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconImageView.image = [UIImage imageNamed:@"home_icon_clock"];
        [self.contentView addSubview:self.iconImageView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor colorWithHex:0x666666];
        self.titleLabel.text = @"剩余时间";
        [self.contentView addSubview:self.titleLabel];
    }
    
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints) {
        [self.titleLabel autoAlignAxis:ALAxisVertical toSameAxisOfView:self.contentView withOffset:10];
        [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        
        [self.iconImageView autoPinEdge:ALEdgeRight toEdge:ALEdgeLeft ofView:self.titleLabel withOffset:-10];
        [self.iconImageView autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [self.iconImageView autoSetDimensionsToSize:CGSizeMake(24, 24)];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (void)setSecondsLeft:(long long)secondsLeft
{
    _secondsLeft = secondsLeft;
   // NSLog(@"secondsLeft = %lld",secondsLeft);
    NSUInteger days = (NSUInteger)secondsLeft / (3600 * 24);
    NSUInteger hours = (NSUInteger)(secondsLeft - 3600 * 24 * days) / 3600;
    NSUInteger minutes = (NSUInteger)(secondsLeft - 3600 * 24 * days - 3600 * hours) / 60;
    
    NSString *string;
    if (days > 0) {
        string = [NSString stringWithFormat:@"距预约时间还有<font color=D0021B size=4>%d天%d小时%d分</font>", days, hours, minutes];
    }
    else if (hours > 0) {
        string = [NSString stringWithFormat:@"距预约时间还有<font color=D0021B size=4>%d小时%d分</font>", hours, minutes];
    }
    else if (minutes > 0) {
        string = [NSString stringWithFormat:@"距预约时间还有<font color=D0021B size=4>%d分</font>", minutes];
    }
    
    self.titleLabel.attributedText = [[NSAttributedString alloc] initWithData:[string dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
}

@end
