//
//  WQAlertActionModel.m
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//

#import "WQAlertActionModel.h"
#import <WQViewFrame/UIView+WQFrame.h>
@implementation WQAlertActionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _textFont = [UIFont systemFontOfSize:15.f];
        _textColor = kWQHexRGB(0x333333);
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
+ (WQAlertActionModel *)actionModelWithTitle:(NSString *)title actionBlock:(WQAClickAction)actionBlock
{
    WQAlertActionModel *model = [[WQAlertActionModel alloc] init];
    model.title = title;
    model.actionBlock = actionBlock;
    return model;
}

@end
