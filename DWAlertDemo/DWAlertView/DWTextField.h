//
//  DWTextField.h
//  DWAlertDemo
//
//  Created by VIP on 2018/3/31.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DWTextField : UITextField

@property (nonatomic ,copy) void(^block)(NSString *);

@property (nonatomic ,copy) NSString *dwPlaceholder;

- (void)valueChangeBlock:(void(^)(NSString * x))block;

@end
