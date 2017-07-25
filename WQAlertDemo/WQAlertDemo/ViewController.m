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
    [[WQToastView shareToast] showToastWithMessage:@"哇哈哈! biubiubiu"];
}

- (IBAction)clickShowAlertBtnAction:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
