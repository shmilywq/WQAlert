//
//  ViewController.m
//  WQAlertDemo
//
//  Created by shmily on 2017/7/25.
//  Copyright © 2017年 shmily. All rights reserved.
//

#import "ViewController.h"
#import "WQAlert.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - Action
// 显示吐司
- (IBAction)clickShowToastBtnAction:(id)sender {
    [[WQCustomToastView shareToast] showToastWithMessage:@"哇哈哈! biubiubiu"];
}
// 显示默认弹框
- (IBAction)clickShowAlertBtnAction:(id)sender {
    [WQAlertView showAlertViewWithTitle:@"测试" message:@"一个大西瓜,切成了两半! 你一半, 我一半!" cancelBtnTitle:@"确定" cancelActionBlock:^{
        [WQToastView showToastWithMessage:@"点击了确定按钮"];
    } confirmBtnTitle:@"取消" confirmActionBlock:^{
        [WQToastView showToastWithMessage:@"自定义吐司显示时间: 5s" andShowTime:5.f];
    }];
}
// 显示多按钮弹框
- (IBAction)clickShowMuchAlertBtnAction:(id)sender {
    WQAlertActionModel *model1 = [WQAlertActionModel actionModelWithTitle:@"滴" actionBlock:^{
        [WQToastView showToastWithMessage:@"滴"];
    }];
    model1.textFont = [UIFont systemFontOfSize:12.f];
    model1.textColor = [UIColor redColor];
    WQAlertActionModel *model2 = [WQAlertActionModel actionModelWithTitle:@"滴滴" actionBlock:^{
        [WQToastView showToastWithMessage:@"滴滴"];
    }];
    model2.textFont = [UIFont systemFontOfSize:15.f];
    model2.textColor = [UIColor yellowColor];
    WQAlertActionModel *model3 = [WQAlertActionModel actionModelWithTitle:@"滴滴滴滴滴滴滴滴滴滴滴滴滴滴滴滴" actionBlock:^{
        [WQToastView showToastWithMessage:@"好多滴"];
    }];
    model3.textFont = [UIFont systemFontOfSize:18.f];
    model3.textColor = [UIColor blueColor];
    NSArray *modelArr = @[model1, model2, model3];
    [WQAlertView showAlertViewWithTitle:@"多按钮弹框" message:@"come on! 来吧,亮亮相吧! 小宝贝! " actionArr:modelArr];
}
- (IBAction)clickShowCustomAlertBtnAction:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
