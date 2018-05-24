//
//  ViewController.m
//  DWAlertDemo
//
//  Created by VIP on 2018/3/29.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "ViewController.h"
#import "DWAlertView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickShowAlertBtn:(UIButton *)sender {
    DWAlertView *alert = [[DWAlertView alloc] initWithTitle:@"I'm Title" message:@"message"];
    [alert addActionWithTitle:@"Action1" Type:DWAlertActionStyleDefault SelectBlock:^(UIButton *action) {
        NSLog(@"Touch1");
    }];
    [alert addActionWithTitle:@"Action2" Type:DWAlertActionStyleCancel SelectBlock:^(UIButton *action) {
        NSLog(@"Touch2");
    }];
    [alert addActionWithTitle:@"Action3" Type:DWAlertActionStyleDestructive SelectBlock:^(UIButton *action) {
        NSLog(@"Touch3");
    }];
    [alert addTexFieldWithPlaceHolder:@"TextField1" InputBlock:^(NSString *text) {
        NSLog(@"1 - >%@",text);
    }];
    
    [alert show];
}

@end
