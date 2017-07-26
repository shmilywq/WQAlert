//
//  WQAlertActionCell.h
//  WQAlertDemo
//
//  Created by shmily on 2017/7/26.
//  Copyright © 2017年 shmily. All rights reserved.
//
/*
 * alert弹框按钮cell
 */
#import <UIKit/UIKit.h>

@class WQAlertActionModel;
@interface WQAlertActionCell : UICollectionViewCell

/**
 赋值cell
 
 @param cellModel 数据model
 */
- (void)setCellCententWithModel:(WQAlertActionModel *)cellModel;

@end
