//
//  WQCustomAlertView.m
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//

#import "WQCustomAlertView.h"
#import <WQViewFrame/UIView+WQFrame.h>
#import "WQAlertActionCell.h"

#define kWQAlertViewLeftAndRightMargin (50.f * kWQFitWidth) // 弹框距离屏幕左右两边的间距
#define kWQAlertViewWidth (kWQScreenWidth - 2 * kWQAlertViewLeftAndRightMargin) // 弹框的宽度
#define kWQAnimateTime 0.2f // 动画时间
#define kWQItemHeight 40.f // 按钮高度

#define kWQCutLineColor kWQHexRGB(0xDDDDDD) // 分割线颜色
#define kWQDefTextColor kWQHexRGB(0x333333) // 默认的文字颜色
#define kWQDefHopeActionColor kWQHexRGB(0xfd6700) // 希望用户操作的按钮的文字颜色

@interface WQCustomAlertView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIView *bgView; // 背景视图
@property (nonatomic, strong) UIView *contentBGView; // 内容所在父视图, 内容视图可以自定义, 默认内容父视图里包含titleLb和MsgLb
@property (nonatomic, strong) UIView *vLineView; // 内容和按钮之间的分割线
@property (nonatomic, strong) UICollectionView *collectionView; // 按钮集合视图
@property (nonatomic, strong) UICollectionViewFlowLayout *horizontalLayout; // 横向布局
@property (nonatomic, strong) UICollectionViewFlowLayout *verticalLayout; // 纵向布局
@property (nonatomic, strong) NSMutableArray<WQAlertActionModel *> *itemDateArr; // 按钮个数数组

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


- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
                cancelBtnTitle:(NSString *)cancelBtnTitle
             cancelActionBlock:(WQAClickAction)cancelActionBlock
               confirmBtnTitle:(NSString *)confirmBtnTitle
            confirmActionBlock:(WQAClickAction)confirmActionBlock
{
    NSMutableArray *actionArr = [NSMutableArray array];
    if (cancelBtnTitle.length) {
        WQAlertActionModel *cancelModel = [[WQAlertActionModel alloc] init];
        cancelModel.title = cancelBtnTitle;
        cancelModel.actionBlock = cancelActionBlock;
        [actionArr addObject:cancelModel];
    }
    if (confirmBtnTitle.length) {
        WQAlertActionModel *confirmModel = [[WQAlertActionModel alloc] init];
        confirmModel.title = confirmBtnTitle;
        confirmModel.actionBlock = confirmActionBlock;
        confirmModel.textColor = cancelBtnTitle.length ? kWQDefHopeActionColor : kWQDefTextColor;
        [actionArr addObject:confirmModel];
    }
    
    [self showAlertViewWithTitle:title message:message actionArr:actionArr];
}
- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
                     actionArr:(NSArray<WQAlertActionModel *> *)actionArr
{
    UIView *contentView = [self setUpDefaultContentViewWithTitle:title msg:message];
    [self showAlertViewWithContentView:contentView actionArr:actionArr];
}
// 依据提醒视图,按钮数目绘制页面
- (void)showAlertViewWithContentView:(UIView *)contentView actionArr:(NSArray<WQAlertActionModel *> *)actionArr
{
    if (!contentView || actionArr.count == 0) {
        return;
    }
    self.itemDateArr = [NSMutableArray arrayWithArray:actionArr];
    // 调整页面布局
    [self updateSubViewsFrameWithContentView:contentView];
    [self showAlertView];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemDateArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WQAlertActionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WQAlertActionCell" forIndexPath:indexPath];
    if (self.itemDateArr.count > indexPath.row) {
        [cell setCellCententWithModel:self.itemDateArr[indexPath.row]];
    }
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    WQAlertActionModel *model = self.itemDateArr[indexPath.row];
    if (model.actionBlock) {
        model.actionBlock();
    }
    [self hideAlertView];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.itemDateArr.count == 0) {
        return CGSizeZero;
    } else if (self.itemDateArr.count == 2) {
        return CGSizeMake((self.contentBGView.wq_width - 1.0f) / 2.0, kWQItemHeight);
    } else {
        return CGSizeMake(self.contentBGView.wq_width, kWQItemHeight);
    }
}

#pragma mark - Private
- (void)initDefaultValue
{
    self.titleFont = [UIFont boldSystemFontOfSize:18.f];
    self.titleColor =  kWQHexRGB(0x000000);
    self.msgFont = [UIFont systemFontOfSize:15.f];
    self.msgColor =  kWQDefTextColor;
}

// 获取文字frame
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    CGSize stringSize = CGSizeZero;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect stringRect = [text boundingRectWithSize:constraintSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    stringSize = CGSizeMake(stringRect.size.width + 2.f, stringRect.size.height + 2.f);
    return stringSize;
}
// 更新页面布局
- (void)updateSubViewsFrameWithContentView:(UIView *)contentView
{
    contentView.wq_origin = CGPointMake(0.f, 0.f);
    if (contentView.wq_width > kWQScreenWidth) {
        contentView.wq_width = kWQAlertViewWidth;
    }
    [self.contentBGView addSubview:contentView];
    self.contentBGView.frame = contentView.frame;
    CGFloat alertViewWidth = contentView.wq_width;
    self.vLineView.frame = CGRectMake(0.f, self.contentBGView.wq_bottom, alertViewWidth, 1.f);
    if (self.itemDateArr.count == 2) {
        // 2个按钮
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.vLineView.wq_bottom, alertViewWidth, kWQItemHeight) collectionViewLayout:self.horizontalLayout];
    } else {
        CGFloat collectionViewHeight = kWQItemHeight * self.itemDateArr.count + (self.itemDateArr.count - 1);
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.vLineView.wq_bottom, alertViewWidth, collectionViewHeight) collectionViewLayout:self.verticalLayout];
    }
    self.collectionView.backgroundColor = kWQCutLineColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[WQAlertActionCell class] forCellWithReuseIdentifier:@"WQAlertActionCell"];
    [self.bgView addSubview:self.collectionView];
    CGFloat bgViewX = (kWQScreenWidth - alertViewWidth) / 2;
    self.bgView.frame = CGRectMake(bgViewX, 0, alertViewWidth, self.collectionView.wq_bottom);
    self.bgView.center = self.center;
}
#pragma mark - SubViews
- (void)setUpSubViews
{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.contentBGView];
    [self.bgView addSubview:self.vLineView];
}
- (UIView *)setUpDefaultContentViewWithTitle:(NSString *)title msg:(NSString *)msg
{
    UIView *defContentView = [[UIView alloc] init];
    CGFloat vMargin = 15.f; // 上下间距
    CGFloat hMargin = 15.f; // 左右间距
    CGFloat subViewWidth = kWQAlertViewWidth - 2 * hMargin;
    CGFloat defContentViewHeight = vMargin;
    if (title.length) {
        CGFloat titleHeight = [self sizeWithText:title font:self.titleFont constraintSize:CGSizeMake(subViewWidth, MAXFLOAT)].height;
        UILabel *titleLb = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, vMargin, subViewWidth, titleHeight)];
        titleLb.textColor = self.titleColor;
        titleLb.font = self.titleFont;
        titleLb.numberOfLines = 0;
        titleLb.text = title;
        if (titleHeight > self.titleFont.lineHeight * 2) {
            // 2行以上居左
            titleLb.textAlignment = NSTextAlignmentLeft;
        } else {
            // 1行文字居中
            titleLb.textAlignment = NSTextAlignmentCenter;
        }
        [defContentView addSubview:titleLb];
        defContentViewHeight += titleHeight;
    }
    if (msg.length) {
        defContentViewHeight += 10.f;
        CGFloat msgHeight = [self sizeWithText:msg font:self.msgFont constraintSize:CGSizeMake(subViewWidth, MAXFLOAT)].height;
        UILabel *msgLb = [[UILabel alloc] initWithFrame:CGRectMake(hMargin, defContentViewHeight, subViewWidth, msgHeight)];
        msgLb.textColor = self.msgColor;
        msgLb.numberOfLines = 0;
        msgLb.font = self.msgFont;
        msgLb.text = msg;
        msgLb.lineBreakMode = NSLineBreakByCharWrapping;
        if (msgHeight > self.msgFont.lineHeight * 2) {
            // 2行以上居左
            msgLb.textAlignment = NSTextAlignmentLeft;
        } else {
            // 1行文字居中
            msgLb.textAlignment = NSTextAlignmentCenter;
        }
        [defContentView addSubview:msgLb];
        defContentViewHeight += msgHeight;
    }
    defContentViewHeight += vMargin;
    defContentView.frame = CGRectMake(0, 0, kWQAlertViewWidth, defContentViewHeight);
    return defContentView;
}

#pragma mark - Action
- (void)showAlertView
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window endEditing:YES];
    for (UIView *subview in window.subviews) {
        if ([subview isKindOfClass:[self class]]) {
            subview.alpha = 0.f;
        }
    }
    [window addSubview:self ];
    self.transform =  CGAffineTransformMakeScale(1.05, 1.05);
    self.alpha = 0.f;
    [UIView animateWithDuration:kWQAnimateTime animations:^{
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
    }];
}
- (void)hideAlertView
{
    [UIView animateWithDuration:kWQAnimateTime animations:^{
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        for (UIView *subview in window.subviews) {
            if ([subview isKindOfClass:[self class]]) {
                [UIView animateWithDuration:kWQAnimateTime animations:^{
                    subview.alpha = 1.f;
                }];
                break;
            }
        }
    }];
}
#pragma mark - LazyLoad
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10.f;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}
- (UIView *)contentBGView
{
    if (!_contentBGView) {
        _contentBGView = [[UIView alloc] init];
    }
    return _contentBGView;
}

- (UIView *)vLineView
{
    if (!_vLineView) {
        _vLineView = [[UIView alloc] init];
        _vLineView.backgroundColor = kWQCutLineColor;
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
