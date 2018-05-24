//
//  DWAction.h
//  DWAlertDemo
//
//  Created by VIP on 2018/3/30.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWAction : UIButton

@property (nonatomic ,copy) void(^block)(UIButton *);

- (void)addTapBlock:(void(^)(UIButton * btn))block;

@end
