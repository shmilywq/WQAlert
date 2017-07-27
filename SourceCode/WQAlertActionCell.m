//
//  WQAlertActionCell.m
//  WQAlertDemo
//
//  Created by shmily on 2017/7/26.
//  Copyright © 2017年 shmily. All rights reserved.
//

#import "WQAlertActionCell.h"
#import "WQAlertActionModel.h"
#import <WQViewFrame/UIView+WQFrame.h>

@interface WQAlertActionCell ()

@property (nonatomic, strong) UILabel *titleLb; // 按钮标题

@end
@implementation WQAlertActionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubviews];
    }
    return self;
}
#pragma mark - 赋值
- (void)setCellCententWithModel:(WQAlertActionModel *)cellModel
{
    _titleLb.text = cellModel.title;
    _titleLb.font = cellModel.textFont;
    _titleLb.textColor = cellModel.textColor;
    _titleLb.frame = self.contentView.bounds;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _titleLb.font = [UIFont systemFontOfSize:18.f];
    _titleLb.textColor = kWQHexRGB(0x333333);
}

#pragma mark - Subviews
- (void)setUpSubviews
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _titleLb = [[UILabel alloc] init];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_titleLb];
}


@end
