//
//  XSlider.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XSlider : UISlider

/**
 重写高度方法

 @param bounds <#bounds description#>
 @return 坐标
 */
- (CGRect)trackRectForBounds:(CGRect)bounds;

/**
 重写滑块的触摸范围

 @param bounds <#bounds description#>
 @param rect <#rect description#>
 @param value <#value description#>
 @return <#return value description#>
 */
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value;

@end
