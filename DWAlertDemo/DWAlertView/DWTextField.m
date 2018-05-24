//
//  DWTextField.m
//  DWAlertDemo
//
//  Created by VIP on 2018/3/31.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "DWTextField.h"

@implementation DWTextField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void)configUI
{
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    self.tintColor = [UIColor colorWithRed:40/255.0 green:100/255.0 blue:240/255.0 alpha:1.0];
}

- (void)textFieldDidChange :(UITextField *)theTextField{
    if (self.block) {
        self.block(theTextField.text);
    }
}

- (void)valueChangeBlock:(void (^)(NSString *))block
{
    self.block = block;
}

-(void)setDwPlaceholder:(NSString *)dwPlaceholder
{
    self.placeholder = dwPlaceholder;
    NSMutableAttributedString *ph = [[NSMutableAttributedString alloc] initWithString:dwPlaceholder];
    [ph addAttribute:NSForegroundColorAttributeName
               value:[UIColor lightGrayColor]
               range:NSMakeRange(0, dwPlaceholder.length)];
    [ph addAttribute:NSFontAttributeName
               value:[UIFont systemFontOfSize:12]
               range:NSMakeRange(0, dwPlaceholder.length)];
    self.attributedPlaceholder = ph;
}

// 控制placeHolder的位置，左右缩20，但是光标位置不变
 -(CGRect)placeholderRectForBounds:(CGRect)bounds
 {
     CGRect inset = CGRectMake(bounds.origin.x+8, bounds.origin.y, bounds.size.width-10, bounds.size.height);//更好理解些
     return inset;
 }


// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+8, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+8, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}

@end
