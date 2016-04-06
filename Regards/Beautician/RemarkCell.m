//
//  RemarkCell.m
//  Beautician
//
//  Created by dengqiang on 4/8/15.
//  Copyright (c) 2015 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "RemarkCell.h"
#import "Remark.h"

@interface RemarkCell ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation RemarkCell

+ (CGFloat)cellHeightWithRemark:(Remark *)remark
{
    CGSize maxLabelSize = CGSizeMake([UIApplication sharedApplication].keyWindow.bounds.size.width - 20, FLT_MAX);
    CGRect rect = [remark.content boundingRectWithSize:maxLabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil];
    
    return rect.size.height + 35;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.font = [UIFont systemFontOfSize:12];
        self.dateLabel.textColor = [UIColor colorWithHex:0x999999];
        [self.contentView addSubview:self.dateLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:14];
        self.contentLabel.textColor = [UIColor colorWithHex:0x333333];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
    }
    
    return self;
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    if (!self.didSetupConstraints) {
        [self.dateLabel autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
        [self.dateLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        
        [self.contentLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.dateLabel withOffset:5];
        [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
        [self.contentLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
        
        self.didSetupConstraints = YES;
    }
}

#pragma mark - Private

- (void)setRemark:(Remark *)remark
{
    _remark = remark;
    self.dateLabel.text = @"2015-04-01 22:00";
    self.contentLabel.text = remark.content;
}

@end
