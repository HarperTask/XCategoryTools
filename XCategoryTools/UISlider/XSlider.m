//
//  XSlider.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "XSlider.h"

@implementation XSlider

/**
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
重写高度方法

@param bounds <#bounds description#>
@return 坐标
*/
- (CGRect)trackRectForBounds:(CGRect)bounds {
    
    return CGRectMake(0, 0, CGRectGetWidth(self.frame), 8);
//    return bounds;
}

/**
 重写滑块的触摸范围
 
 @param bounds <#bounds description#>
 @param rect <#rect description#>
 @param value <#value description#>
 @return <#return value description#>
 */
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    return CGRectInset([super thumbRectForBounds:bounds trackRect:rect value:value], 10, 10);
}


@end
