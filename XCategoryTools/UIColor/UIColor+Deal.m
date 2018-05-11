//
//  UIColor+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UIColor+Deal.h"

@implementation UIColor (Deal)

/**
 平铺颜色
 
 @param name 要平铺的图片名称
 @return 处理后的颜色
 */
+ (id)imageNamed:(NSString *)name {
    UIImage *backgroundImage = [UIImage imageNamed:name];
    
    UIColor *backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    
    return backgroundColor;
}

@end
