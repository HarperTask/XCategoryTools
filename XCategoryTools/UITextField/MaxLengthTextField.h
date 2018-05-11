//
//  MaxLengthTextField.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaxLengthTextField : UITextField <UITextFieldDelegate>


/**
 设置输入最大长度的内容 

 @param maxLength 输入最大长度的内容
 */
- (void)setMaxLength:(NSInteger)maxLength;

/**
 设置输入最大字节的内容

 @param maxBytes 输入最大字节的内容
 */
- (void)setMaxBytes:(NSInteger)maxBytes;


@end
