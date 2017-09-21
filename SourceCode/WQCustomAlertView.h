//
//  WQCustomAlertView.h
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//
/*
 * Alert提醒框
 */
#import <UIKit/UIKit.h>
#import "WQAlertActionModel.h"

#define WQAlertView [[WQCustomAlertView alloc] init]

@interface WQCustomAlertView : UIView

/**
 标题字体, 默认:18.f粗体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 标题字体颜色, 默认:0x000000
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 提示信息字体, 默认:18.f常规
 */
@property (nonatomic, strong) UIFont *msgFont;

/**
 提示信息字体颜色, 默认:0x333333
 */
@property (nonatomic, strong) UIColor *msgColor;

/**
 弹框完全使用默认值,支持一个和两个按钮,不支持多个.当有两个按钮时,右按钮色值为0xfd6700
 
 @param title              标题
 @param message            提醒内容
 @param cancelBtnTitle     左按钮的标题
 @param cancelActionBlock  左按钮的事件回调
 @param confirmBtnTitle    右按钮的标题
 @param confirmActionBlock 右按钮的事件回调
 */
- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
                cancelBtnTitle:(NSString *)cancelBtnTitle
             cancelActionBlock:(WQAClickAction)cancelActionBlock
               confirmBtnTitle:(NSString *)confirmBtnTitle
            confirmActionBlock:(WQAClickAction)confirmActionBlock;

/**
 自定义按钮样式弹框
 
 @param title     标题
 @param message   提醒内容
 @param actionArr 按钮数组
 */
- (void)showAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
                     actionArr:(NSArray<WQAlertActionModel *> *)actionArr;

/**
 自定义提醒内容视图的弹框

 @param contentView 提醒内容视图
 @param actionArr   按钮数组
 */
- (void)showAlertViewWithContentView:(UIView *)contentView
                           actionArr:(NSArray<WQAlertActionModel *> *)actionArr;

/**
 *  系统弹框, 按钮可以只有一个
 *
 *  @param title              标题
 *  @param message            提醒内容
 *  @param cancelBtnTitle     取消按钮标题
 *  @param confirmBtnTitle    确认按钮标题
 *  @param cancelActionBlock  取消事件回调
 *  @param confirmActionBlock 确定事件回调
 */
- (void)showSystemAlertViewWithTitle:(NSString *)title
                       message:(NSString *)message
                cancelBtnTitle:(NSString *)cancelBtnTitle
             cancelActionBlock:(WQAClickAction)cancelActionBlock
               confirmBtnTitle:(NSString *)confirmBtnTitle
            confirmActionBlock:(WQAClickAction)confirmActionBlock;
/**
 *  系统弹框, 按钮可以只有一个
 *
 *  @param fromVC             显示的控制器
 *  @param title              标题
 *  @param message            提醒内容
 *  @param cancelBtnTitle     取消按钮标题
 *  @param cancelActionBlock  取消事件回调
 *  @param confirmBtnTitle    确认按钮标题
 *  @param confirmActionBlock 确定事件回调
 */
- (void)showSystemAlertViewWithFromVC:(UIViewController *)fromVC
                          title:(NSString *)title
                        message:(NSString *)message
                 cancelBtnTitle:(NSString *)cancelBtnTitle
              cancelActionBlock:(WQAClickAction)cancelActionBlock
                confirmBtnTitle:(NSString *)confirmBtnTitle
             confirmActionBlock:(WQAClickAction)confirmActionBlock;

@end
