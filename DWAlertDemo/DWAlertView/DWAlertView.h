//
//  DWAlertView.h
//  DWAlertDemo
//
//  Created by VIP on 2018/3/29.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DWActionType){
    DWAlertActionStyleDefault = 0,
    DWAlertActionStyleCancel,
    DWAlertActionStyleDestructive
};

typedef void(^SelectBlock)(UIButton *action);

typedef void(^InputBlock)(NSString *text);

@interface DWAlertView : UIView

/*
 *是否点击背景消失 默认NO
 */
@property (nonatomic ,assign) BOOL enableTapBG;

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message;

- (void)addTexFieldWithPlaceHolder:(NSString *)placeholder
                  InputBlock:(InputBlock)block;

- (void)addActionWithTitle:(NSString *)title
                      Type:(DWActionType)type
               SelectBlock:(SelectBlock)block;

- (void)show;

@end
