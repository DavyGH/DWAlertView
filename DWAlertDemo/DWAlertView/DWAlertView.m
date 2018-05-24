//
//  DWAlertView.m
//  DWAlertDemo
//
//  Created by VIP on 2018/3/29.
//  Copyright © 2018年 Crazy Davy. All rights reserved.
//

#import "DWAlertView.h"
#import "DWAction.h"
#import "DWTextField.h"
#import "DWDealConstant.h"

#define DW_SCREEN_W [UIScreen mainScreen].bounds.size.width
#define DW_SCREEN_H [UIScreen mainScreen].bounds.size.height
#define DW_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define DW_LAB_W 200
#define DW_CLEARANCE 60
#define DW_BG_W DW_SCREEN_W - (DW_CLEARANCE * 2)

#define DW_FONT(font) [UIFont boldSystemFontOfSize:font]
#define DW_KEYBOARD_SPACING 88
#define DW_ACTION_HEIGHT 44

@interface DWAlertView ()

// UI
@property (nonatomic, strong) UIView *alphaBGView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLab;

@property (nonatomic, strong) UILabel *messageLab;

// Parameter
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSMutableArray <DWAction *> *actionArr;

@property (nonatomic, strong) NSMutableArray <DWTextField *> *textFieldArr;

@end

@implementation DWAlertView

#pragma - life cycle

- (void)dealloc
{
    NSLog(@"delloc");
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
{
    self = [super initWithFrame:CGRectMake(0, 0, DW_SCREEN_W, DW_SCREEN_H)];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _title = title;
        _message = message;
        
        //监听键盘
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)show
{
    [self configUI];
    [self dealTextField];
    [self dealAction];
    [self dealBG];
    [self showAnimation];
}

- (void)dissmiss
{
    [UIView animateWithDuration:.15 animations:^{
        self.bgView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)packUpKeyboard
{
    [self endEditing:YES];
}

- (void)configUI
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [self addSubview:self.alphaBGView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLab];
    [self.bgView addSubview:self.messageLab];
    
    if (self.actionArr.count == 0) {
        [self addActionWithTitle:@"确定" Type:DWAlertActionStyleDefault SelectBlock:nil];
    }
}

- (void)showAnimation
{
    self.bgView.transform = CGAffineTransformMakeScale(0.05, 0.05);
    [UIView animateWithDuration:.15
                     animations:^{
                         self.bgView.transform = CGAffineTransformMakeScale(1.05, 1.05);
                     }completion:^(BOOL finish){
                         [UIView animateWithDuration:.15
                                          animations:^{
                                              self.bgView.transform = CGAffineTransformMakeScale(0.95, 0.95);
                                          }completion:^(BOOL finish){
                                              [UIView animateWithDuration:.15
                                                               animations:^{
                                                                   self.bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                               }];
                                          }];
                     }];
}

#pragma mark - events -

- (void)addActionWithTitle:(NSString *)title
                      Type:(DWActionType)type
               SelectBlock:(SelectBlock)block
{
    DWAction *action = [DWAction buttonWithType:UIButtonTypeCustom];
    [action setTitle:title forState:UIControlStateNormal];
    action.titleLabel.font = DW_FONT(14);
    action.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
    action.layer.borderWidth = 0.3;
    switch (type) {
        case DWAlertActionStyleCancel:
            [action setTitleColor:DW_RGBA(213, 60, 50, 1.0) forState:UIControlStateNormal];
            break;
        case DWAlertActionStyleDestructive:
            [action setTitleColor:DW_RGBA(38, 93, 228, 1.0) forState:UIControlStateNormal];
            break;
        case DWAlertActionStyleDefault:
            [action setTitleColor:DW_RGBA(56, 120, 234, 1.0) forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    [self.bgView addSubview:action];
    [self.actionArr addObject:action];
    
    __weak typeof(self) weakSelf = self;
    [action addTapBlock:^(UIButton *btn) {
        !block?:block(btn);
        [weakSelf dissmiss];
    }];
}

- (void)addTexFieldWithPlaceHolder:(NSString *)placeholder
                        InputBlock:(InputBlock)block
{
    DWTextField *textField = [[DWTextField alloc] init];
    textField.dwPlaceholder = placeholder;
    
    [self.bgView addSubview:textField];
    [self.textFieldArr addObject:textField];
    
    [textField valueChangeBlock:^(NSString *x) {
        !block?:block(x);
    }];
}

//当键盘出现
- (void)keyboardWillShow:(NSNotification *)notification
{
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGRect rect = _bgView.frame;
    rect.origin.y = DW_SCREEN_H - rect.size.height - height - DW_KEYBOARD_SPACING;
    _bgView.frame = rect;
}

//当键退出
- (void)keyboardWillHide:(NSNotification *)notification
{
    CGRect rect = _bgView.frame;
    rect.origin.y = (DW_SCREEN_H - (DW_BG_W))/2;
    _bgView.frame = rect;
}

#pragma mark - deal -

- (void)dealTextField
{
    NSInteger j = self.textFieldArr.count;
    for (int i = 0; i < j; i ++) {
        DWTextField *textField = self.textFieldArr[i];
        textField.frame = CGRectMake((DW_BG_W - DW_LAB_W)/2, [DWDealConstant getLabMaxY:_messageLab] + i*40, DW_LAB_W, 33);
    }
}

- (void)dealAction
{
    CGFloat W = DW_BG_W;
    NSInteger j = self.actionArr.count;
    for (int i = 0; i < j; i ++) {
        DWAction *action = self.actionArr[i];
        if (j < 3) {
            if (self.textFieldArr.count == 0) {
                action.frame = CGRectMake(i*(W/j), [DWDealConstant getLabMaxY:_messageLab], W/j, DW_ACTION_HEIGHT);
            }else{
                action.frame = CGRectMake(i*(W/j), [DWDealConstant getTextFieldMaxY:_textFieldArr.lastObject], W/j, DW_ACTION_HEIGHT);
            }
        }else{
            if (self.textFieldArr.count == 0) {
                action.frame = CGRectMake(0, [DWDealConstant getLabMaxY:_messageLab] + i*DW_ACTION_HEIGHT, W, DW_ACTION_HEIGHT);
            }else{
                action.frame = CGRectMake(0, [DWDealConstant getTextFieldMaxY:_textFieldArr.lastObject] + i*DW_ACTION_HEIGHT, W, DW_ACTION_HEIGHT);
            }
        }
    }
}

- (void)dealBG
{
    CGFloat Y = [DWDealConstant getActionMaxY:self.actionArr.lastObject];
    _bgView.frame = CGRectMake(_bgView.frame.origin.x, _bgView.frame.origin.y, _bgView.frame.size.width, Y);
}

#pragma mark - lazy load -

- (UIView *)alphaBGView
{
    if (!_alphaBGView) {
        _alphaBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DW_SCREEN_W, DW_SCREEN_H)];
        _alphaBGView.backgroundColor = [UIColor blackColor];
        _alphaBGView.alpha = 0.5;
        if (_enableTapBG) {
            UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmiss)];
            [_alphaBGView addGestureRecognizer:tapGestureRecognizer];
        }
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packUpKeyboard)];
        [_alphaBGView addGestureRecognizer:tapGestureRecognizer];
    }
    return _alphaBGView;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(DW_CLEARANCE, (DW_SCREEN_H - (DW_BG_W))/2, DW_BG_W, DW_BG_W)];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 6.0;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (UILabel *)titleLab
{
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] initWithFrame:CGRectMake((DW_BG_W - DW_LAB_W)/2, 20, DW_LAB_W, [DWDealConstant getTextHeight:_title Font:DW_FONT(16)])];
        _titleLab.font = DW_FONT(16);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.numberOfLines = 0;
        _titleLab.text = _title;
    }
    return _titleLab;
}

- (UILabel *)messageLab
{
    if (!_messageLab) {
        _messageLab = [[UILabel alloc] initWithFrame:CGRectMake((DW_BG_W - DW_LAB_W)/2, [DWDealConstant getLabMaxY:_titleLab], DW_LAB_W, [DWDealConstant getTextHeight:_message Font:DW_FONT(12)])];
        _messageLab.font = DW_FONT(12);
        _messageLab.textAlignment = NSTextAlignmentCenter;
        _messageLab.textColor = [UIColor grayColor];
        _messageLab.numberOfLines = 0;
        _messageLab.text = _message;
    }
    return _messageLab;
}

- (NSMutableArray<DWAction *> *)actionArr
{
    if (!_actionArr) {
        _actionArr = [NSMutableArray array];
    }
    return _actionArr;
}

-(NSMutableArray<DWTextField *> *)textFieldArr
{
    if (!_textFieldArr) {
        _textFieldArr = [NSMutableArray array];
    }
    return _textFieldArr;
}

@end
