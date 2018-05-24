//
//  DWAction.m
//  DWAlertDemo
//
//  Created by VIP on 2018/3/30.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "DWAction.h"

@implementation DWAction

-(void)addTapBlock:(void(^)(UIButton*))block
{
    self.block = block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}

-(void)click:(UIButton*)btn
{
    if(self.block) {
        self.block(btn);
    }
}

-(void)setBlock:(void(^)(UIButton*))block
{
    _block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}

@end
