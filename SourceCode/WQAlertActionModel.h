//
//  WQAlertActionModel.h
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//
/**
 * 按钮信息model
 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^WQAClickAction)(void); // 按钮点击事件的回调
@interface WQAlertActionModel : NSObject


/**
 按钮文字
 */
@property (nonatomic, copy) NSString *title;

/**
 点击事件回调
 */
@property (nonatomic, copy) WQAClickAction actionBlock;

/**
 字体大小, 默认:[UIFont systemFontOfSize:15.f];
 */
@property (nonatomic, copy) UIFont *textFont;

/**
 字体颜色, 默认:0x333333
 */
@property (nonatomic, copy) UIColor *textColor;

/**
 便利构造器创建model

 @param title       按钮文字
 @param actionBlock 按钮事件回调
 @return            初始化对象
 */
+ (WQAlertActionModel *)actionModelWithTitle:(NSString *)title actionBlock:(WQAClickAction)actionBlock;

@end
