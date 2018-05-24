//
//  DWDealConstant.m
//  DWAlertDemo
//
//  Created by VIP on 2018/3/31.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "DWDealConstant.h"

@implementation DWDealConstant

+ (CGFloat)getTextHeight:(NSString *)string Font:(UIFont *)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    CGRect tmpRect = [string boundingRectWithSize:CGSizeMake(200, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil] context:nil];
    return tmpRect.size.height;
}

+ (CGFloat)getLabMaxY:(UILabel *)lab
{
    return lab.frame.origin.y + lab.frame.size.height + 10;
}

+ (CGFloat)getTextFieldMaxY:(UITextField *)textfield
{
    return textfield.frame.origin.y + textfield.frame.size.height + 10;
}

+ (CGFloat)getActionMaxY:(UIButton *)action
{
    return action.frame.origin.y + action.frame.size.height;
}

@end
