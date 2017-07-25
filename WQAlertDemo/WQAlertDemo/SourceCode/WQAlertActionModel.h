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

@interface WQAlertActionModel : NSObject

typedef void(^WQAClickAction)(); // 按钮点击事件的回调

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) WQAClickAction actionBlock;

@property (nonatomic, copy) UIFont *textFont;

@property (nonatomic, copy) UIColor *textColor;

@end
