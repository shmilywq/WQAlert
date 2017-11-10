//
//  WQCustomToastView.m
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//

#import "WQCustomToastView.h"

#pragma mark - RootViewController
@interface WQRootViewController : UIViewController

@end

@implementation WQRootViewController

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
/***************** END *****************/

@interface WQCustomToastView ()

@property (nonatomic, strong) UILabel *msgLabel; // 提醒内容
@property (nonatomic, strong) NSTimer *showTimer; // 显示时间计时器

@end

@implementation WQCustomToastView

+ (WQCustomToastView *)shareToast
{
    static WQCustomToastView *toastView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toastView = [[WQCustomToastView alloc] init];
    });
    return toastView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initDefaultValue];
        WQRootViewController *rootVC = [[WQRootViewController alloc] init];
        self.rootViewController = rootVC;
        self.windowLevel = UIWindowLevelAlert;
        self.layer.cornerRadius = 8.f;
        self.layer.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor;
        [self addSubview:self.msgLabel];
        self.hidden = YES;
    }
    return self;
}

- (void)initDefaultValue
{
    _msgColor = [UIColor whiteColor];
    _msgFont = [UIFont systemFontOfSize:15.f];
    _msgAlignment = NSTextAlignmentLeft;
    _showTime = 1.5f;
    _toastPlace = WQToastViewPlace_Bottom;
}
#pragma mark - 显示/消失
// 显示
- (void)showToastWithMessage:(NSString *)message
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    self.hidden = NO;
    [self setToastWithText:message];
    if (_showTimer) {
        [_showTimer invalidate];
        _showTimer = nil;
    }
    _showTimer = [NSTimer scheduledTimerWithTimeInterval:_showTime target:self selector:@selector(dismissToast) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_showTimer forMode:NSDefaultRunLoopMode];
}
// 自定义显示时间显示
- (void)showToastWithMessage:(NSString *)message andShowTime : (NSTimeInterval )timeNum
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    self.hidden = NO;
    [self setToastWithText:message];
    if (_showTimer) {
        [_showTimer invalidate];
        _showTimer = nil;
    }
    if (!timeNum) {
        timeNum = _showTime;
    }
    _showTimer = [NSTimer scheduledTimerWithTimeInterval:timeNum target:self selector:@selector(dismissToast) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_showTimer forMode:NSDefaultRunLoopMode];
}
- (void)dismissToast
{
    self.hidden = YES;
    [_showTimer invalidate];
    _showTimer = nil;
}
#pragma mark - Private
- (void)setToastWithText:(NSString*)text {
    _msgLabel.text = text;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary * attributes = @{NSFontAttributeName : _msgFont, NSParagraphStyleAttributeName : paragraphStyle};
    CGFloat viewMargin = 40.f; // 弹框距屏幕边缘的最小距离
    CGFloat laberMargin = 10.f; // 文字距弹框的边距
    CGFloat maxWidth = screenWidth - 2 * viewMargin - 2 * laberMargin; // 文字最大宽度
    CGFloat maxHeight = screenHeight - 2 * viewMargin - 2 * laberMargin; // 文字最大高度
    CGFloat oneLineTextWidth = [text sizeWithAttributes:@{NSFontAttributeName:_msgFont}].width; // 单行文字的宽度
    // 如果单行文本宽度大于最大限制, 则按最大限制计算多行的
    maxWidth = maxWidth > (oneLineTextWidth + 2 * laberMargin) ? oneLineTextWidth + 2 * laberMargin : maxWidth;
    CGSize contentSize = [text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:attributes context:nil].size;
    if (contentSize.height > maxHeight) {
        contentSize.height = maxHeight;
    }
    _msgLabel.frame = CGRectMake(laberMargin, laberMargin, contentSize.width, contentSize.height);
    
    CGFloat toastWidth = contentSize.width + 2 * laberMargin; // 吐司的宽度
    CGFloat toastHeight = contentSize.height + 2 * laberMargin; // 吐司的高度
    CGFloat toastY = 0.f;
    switch (_toastPlace) {
        case WQToastViewPlace_Top:
        {
            toastY = viewMargin;
        }
            break;
        case WQToastViewPlace_Middle:
        {
            toastY = (screenHeight - toastHeight)/2;
        }
            break;
        case WQToastViewPlace_Bottom:
        {
            toastY = screenHeight - toastHeight - viewMargin;
        }
            break;
        default:
            break;
    }
    
    self.frame = CGRectMake((screenWidth - toastWidth)/2,
                            toastY,
                            toastWidth,
                            toastHeight);
}

#pragma mark - SubViews
- (UILabel *)msgLabel
{
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _msgLabel.numberOfLines = 0.f;
        _msgLabel.textColor = _msgColor;
        _msgLabel.font = _msgFont;
        _msgLabel.lineBreakMode = NSLineBreakByCharWrapping;
        _msgLabel.textAlignment = _msgAlignment;
    }
    return _msgLabel;
}
#pragma mark - Setter
- (void)setMsgFont:(UIFont *)msgFont
{
    _msgFont = msgFont;
    self.msgLabel.font = msgFont;
}
#pragma mark - LazyLoad


@end

