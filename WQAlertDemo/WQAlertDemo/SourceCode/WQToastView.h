//
//  WQToastView.h
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//
/**
 *  吐司提醒框
 */
#import <UIKit/UIKit.h>

#define WQToast [WQToastView shareToast]

@interface WQToastView : UIWindow

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
 单例初始化方法

 @return 单例对象
 */
+ (WQToastView *)shareToast;
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
