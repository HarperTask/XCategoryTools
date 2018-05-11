//
//  UITextField+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Deal)

/**
 只能输入数字和一个小数点 输入框改变时调用

 @param range 输入的位置和长度
 @param string 输入的内容
 @return 是不是数字和一个小数点
 */
- (BOOL)isFloatWithRange:(NSRange)range string:(NSString *)string;

/**
 只能输入数字 输入框改变时调用

 @param string 输入的内容
 @return 是不是数字
 */
- (BOOL)isNumberWithString:(NSString *)string;


/** 格式化银行卡 */
//- (id)becomeBankCardNum;


@end
