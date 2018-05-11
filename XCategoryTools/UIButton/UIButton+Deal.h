//
//  UIButton+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Deal)

#pragma mark - 颜色处理

/**
 按钮不同状态下的颜色

 @param backgroundColor 按钮的颜色
 @param state 触发事件的状态
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;



@end
