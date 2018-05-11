//
//  UIView+Frame.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)
//X
- (CGFloat)x_originX {
    return self.frame.origin.x;
}
- (void)setX_originX:(CGFloat)x_originX {
    CGRect rect = self.frame;
    rect.origin.x = x_originX;
    self.frame = rect;
}

//Y
- (CGFloat)x_originY {
    return self.frame.origin.y;
}
- (void)setX_originY:(CGFloat)x_originY {
    CGRect rect = self.frame;
    rect.origin.y = x_originY;
    self.frame = rect;
}

//W
- (CGFloat)x_width {
    return self.frame.size.width;
}
- (void)setX_width:(CGFloat)x_width {
    CGRect rect = self.frame;
    rect.size.width = x_width;
    self.frame = rect;
}

//H
- (CGFloat)x_height {
    return self.frame.size.height;
}
- (void)setX_height:(CGFloat)x_height {
    CGRect rect = self.frame;
    rect.size.height = x_height;
    self.frame = rect;
}


@end
