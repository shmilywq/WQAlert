//
//  WQCustomToastView.h
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//
/**
 *  吐司提醒框
 */
#import <UIKit/UIKit.h>

#define WQToastView [WQCustomToastView shareToast]

typedef enum : NSUInteger {
    WQToastViewPlace_Top = 1, // 顶部显示
    WQToastViewPlace_Middle = 2, // 中间显示
    WQToastViewPlace_Bottom = 3, // 下部显示
} WQToastViewPlace;


@interface WQCustomToastView : UIWindow

/**
 文字字号, 默认: [UIFont systemFontOfSize:15.f];
 */
@property (nonatomic, strong) UIFont *msgFont;

/**
 文字颜色, 默认: [UIColor whiteColor];
 */
@property (nonatomic, strong) UIColor *msgColor;

/**
 文字排列方式, 默认:NSTextAlignmentLeft
 */
@property (nonatomic, assign) NSTextAlignment msgAlignment;

/**
 吐司显示时间, 默认: 1.5s
 */
@property (nonatomic, assign) NSTimeInterval showTime;

/**
 吐司位置, 默认:WQToastViewPlace_Bottom(下面显示)
 */
@property (nonatomic, assign) WQToastViewPlace toastPlace;

/**
 单例初始化方法

 @return 单例对象
 */
+ (WQCustomToastView *)shareToast;
/**
 *  显示内容
 *
 *  @param message 信息字符串
 */
- (void)showToastWithMessage:(NSString *)message;

/**
 自定义显示时间及内容显示
 
 @param message 信息字符串
 @param timeNum 显示时间
 */
- (void)showToastWithMessage:(NSString *)message andShowTime : (NSTimeInterval )timeNum;
/**
 *  隐藏吐司. ps:一般不需要手动调用该方法,默认的显示时间过后会自动消失
 */
- (void)dismissToast;


@end
