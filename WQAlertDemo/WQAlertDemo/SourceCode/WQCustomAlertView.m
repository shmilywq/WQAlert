//
//  WQCustomAlertView.m
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//

#import "WQCustomAlertView.h"
#import <WQViewFrame/UIView+WQFrame.h>
@interface WQCustomAlertView ()

@property (nonatomic, strong) UIView *bgView; // 背景视图
@property (nonatomic, strong) UIView *contentView; // 内容所在父视图, 内容视图可以自定义
@property (nonatomic, strong) UIView *vLineView; // 内容和按钮之间的分割线
@property (nonatomic, strong) UICollectionView *collectionView; // 按钮集合视图
@property (nonatomic, strong) UICollectionViewFlowLayout *horizontalLayout; // 横向布局
@property (nonatomic, strong) UICollectionViewFlowLayout *verticalLayout; // 纵向布局
@property (nonatomic, strong) NSMutableArray<WQAlertActionModel *> *itemDateArr; // 按钮个数数组

// 默认内容父视图里包含titleLb和MsgLb
@property (nonatomic, strong) UILabel *titleLb; // 标题lb
@property (nonatomic, strong) UILabel *msgLb; // 提示信息lb

@end

@implementation WQCustomAlertView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaultValue];
        [self setUpSubViews];
    }
    return self;
}

- (void)initDefaultValue
{
    
}
- (void)setUpSubViews
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.contentView];
    [self.bgView addSubview:self.vLineView];
    [self.bgView addSubview:self.collectionView];
}

#pragma mark - LazyLoad
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.center = self.center;
        _bgView.layer.cornerRadius = 10.f;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)titleLb
{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = self.titleColor;
        _titleLb.font = self.titleFont;
        _titleLb.numberOfLines = 0;
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}
- (UILabel *)msgLb
{
    if (!_msgLb) {
        _msgLb = [[UILabel alloc] init];
        _msgLb.textColor = self.msgColor;
        _msgLb.numberOfLines = 0;
        _msgLb.font = self.msgFont;
        _msgLb.lineBreakMode = NSLineBreakByCharWrapping;
    }
    return _msgLb;
}
- (UIView *)vLineView
{
    if (!_vLineView) {
        _vLineView = [[UIView alloc] init];
        _vLineView.backgroundColor = kWQHexRGB(0xDDDDDD);
    }
    return _vLineView;
}

- (UICollectionViewFlowLayout *)horizontalLayout
{
    if (!_horizontalLayout) {
        _horizontalLayout = [[UICollectionViewFlowLayout alloc] init];
        _horizontalLayout.minimumLineSpacing = 1.0f;
        _horizontalLayout.minimumInteritemSpacing = 0.f;
        _horizontalLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _horizontalLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _horizontalLayout;
}
- (UICollectionViewFlowLayout *)verticalLayout
{
    if (!_verticalLayout) {
        _verticalLayout = [[UICollectionViewFlowLayout alloc] init];
        _verticalLayout.minimumLineSpacing = 1.f;
        _verticalLayout.minimumInteritemSpacing = 0.f;
        _horizontalLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _verticalLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _verticalLayout;
}

- (NSMutableArray<WQAlertActionModel *> *)itemDateArr
{
    if (!_itemDateArr) {
        _itemDateArr = [NSMutableArray array];
    }
    return _itemDateArr;
}


@end
