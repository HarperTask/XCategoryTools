//
//  UITextField+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UITextField+Deal.h"

@interface UITextField ()

@property (nonatomic, copy) NSString *tempStr;

@end

@implementation UITextField (Deal)

/**
 只能输入数字和一个小数点 输入框改变时调用
 
 @param range 输入的位置和长度
 @param string 输入的内容
 @return 是不是数字和一个小数点
 */
- (BOOL)isFloatWithRange:(NSRange)range string:(NSString *)string {
    // 限制只能输入数字
    BOOL isHaveDian;
    isHaveDian = YES;
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    
    if ([self.text rangeOfString:@"."].location == NSNotFound) {
        isHaveDian = NO;
    }
    
    if ([string length] > 0) {
        
        // 当前输入的字符
        unichar single = [string characterAtIndex:0];
        
        // 数据格式正确
        if ((single >= '0' && single <= '9') || single == '.') {
            
            if([self.text length] == 0) {
                if(single == '.') {
                    [self.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }
            
            // 输入的字符是否是小数点
            if (single == '.') {
                // text中还没有小数点
                if(isHaveDian) {
                    
                    [self.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
                else {
                    
                    return YES;
                }
            }
            else {
                // 存在小数点
                if (isHaveDian) {
                    
                    // 判断小数点的位数
                    NSRange ran = [self.text rangeOfString:@"."];
                    
                    // 两位小数(可修改)
                    if (range.location - ran.location <= 2) {
                        //                        return YES;
                    }
                    else {
                        //                        return NO;
                    }
                }
                else {
                    return YES;
                }
            }
        }
        // 输入的数据格式不正确
        else {
            
            [self.text stringByReplacingCharactersInRange:range withString:@""];
            
            return NO;
        }
    }
    else {
        return YES;
    }
    
    return YES;
}

/**
 只能输入数字 输入框改变时调用
 
 @param string 输入的内容
 @return 是不是数字
 */
- (BOOL)isNumberWithString:(NSString *)string {
    
    NSCharacterSet *tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < string.length) {
        NSString *tempString = [string substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [tempString rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            return NO;
        }
        i++;
    }

    return YES;
}

//- (id)becomeBankCardNum {
//  
//}




@end
