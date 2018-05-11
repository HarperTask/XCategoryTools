//
//  KeyTextField.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//
// 验证码验证码输入框需要

#import <UIKit/UIKit.h>

@protocol KeyTextFieldDelegate <NSObject>

@optional
- (void)deleteBackward:(UITextField *)textField;

@end

@interface KeyTextField : UITextField

@property (nonatomic, weak) id <KeyTextFieldDelegate> kdelegate;

@end
