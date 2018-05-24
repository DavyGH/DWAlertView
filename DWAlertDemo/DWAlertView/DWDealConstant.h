//
//  DWDealConstant.h
//  DWAlertDemo
//
//  Created by VIP on 2018/3/31.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DWDealConstant : NSObject

+ (CGFloat)getTextHeight:(NSString *)string Font:(UIFont *)font;

+ (CGFloat)getLabMaxY:(UILabel *)lab;

+ (CGFloat)getTextFieldMaxY:(UITextField *)textfield;

+ (CGFloat)getActionMaxY:(UIButton *)action;

@end
