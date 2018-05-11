//
//  UIView+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UIView+Deal.h"
#import "AppDelegate.h"

@implementation UIView (Deal)


#pragma mark - 视图处理

/** 清空视图 */
- (void)clearView {
    for (UIView *view1 in [self subviews]) {
        [view1 removeFromSuperview];
    }
    
}

/** 清空视图后添加子视图 */
- (void)clearView:(UIView *)backView {
    for (UIView *view1 in [self subviews]) {
        [view1 removeFromSuperview];
    }
    [self addSubview:backView];
}


#pragma mark - 虚线处理

/**
 画虚线
 
 @param lineLength 虚线的长度
 @param lineSpacing 虚线之间的间隔
 @param lineColor 虚线的颜色
 */
- (void)drawDashLineWithLineLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    // 设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    // 设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(self.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    // 设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    // 设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    // 把绘制好的虚线添加上来
    [self.layer addSublayer:shapeLayer];
    
}


#pragma mark - 圆角边框

/**
 添加指定角的圆角
 
 @param radius 圆角度数
 @param radiusDirection 圆角的位置
 @return 处理结果
 */
- (id)addRadius:(CGFloat)radius radiusDirection:(RadiusDirection)radiusDirection {
    UIRectCorner corners;
    switch (radiusDirection) {
        case RadiusAround:
            corners = UIRectCornerAllCorners;
            break;
        case RadiusTop:
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
            break;
        case RadiusBottom:
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case RadiusLeft:
            corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
            break;
        case RadiusRight:
            corners = UIRectCornerTopRight | UIRectCornerBottomRight;
            break;
        case RadiusTopLeft:
            corners = UIRectCornerTopLeft;
            break;
        case RadiusTopRight:
            corners = UIRectCornerTopRight;
            break;
        case RadiusBottomLeft:
            corners = UIRectCornerBottomLeft;
            break;
        case RadiusBottomRight:
            corners = UIRectCornerBottomRight;
            break;
        case RadiusTopLeftAndBottomRight:
            corners = UIRectCornerTopLeft | UIRectCornerBottomRight;
            break;
        case RadiusTopRightAndBottomLeft:
            corners = UIRectCornerTopRight | UIRectCornerBottomLeft;
            break;
            
        default:
            corners = UIRectCornerAllCorners;
            break;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    return self;
}

/**
 添加圆角
 
 @param radius 圆角度数
 @return 处理结果
 */
- (id)addRadius:(CGFloat)radius {

    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    
    return self;
}

/**
 添加边框
 
 @param width 边框宽度
 @param color 边框颜色
 @return 处理结果
 */
- (id)addBorderWidth:(CGFloat)width color:(UIColor *)color {
    
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    
    return self;
}

/**
 添加圆角和边框
 
 @param width 边框宽度
 @param color 边框颜色
 @param radius 圆角度数
 @return 处理结果
 */
- (id)addBorderWidth:(CGFloat)width color:(UIColor *)color radius:(CGFloat)radius {
    
    [self addRadius:radius];
    [self addBorderWidth:width color:color];
    
    return self;
}

/**
 画边框，只有边框，边框里面被挖空
 
 @param width 边框宽度
 @param color 边框颜色
 @return 处理结果
 */
- (id)drawBorderWith:(CGFloat)width color:(UIColor *)color {
    
    return self;
}

/**
 画边框，只有边框，边框里面被挖空
 
 @param width 边框宽度
 @param color 边框颜色
 @param radius 圆角度数
 @return 处理结果
 */
- (id)drawBorderWith:(CGFloat)width color:(UIColor *)color radius:(CGFloat)radius {
    
    return self;
}


#pragma mark - 阴影处理

/** 添加高斯模糊 */
- (void)addBlurEffect:(UIBlurEffectStyle)blurEffectStyle {
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:blurEffectStyle];
    UIVisualEffectView *effectVIew = [[UIVisualEffectView alloc]initWithEffect:effect];
    effectVIew.frame = self.bounds;
    
    [self addSubview:effectVIew];
    
    //    UIBlurEffectStyleExtraLight,
    //    UIBlurEffectStyleLight,
    //    UIBlurEffectStyleDark,
    //    UIBlurEffectStyleExtraDark __TVOS_AVAILABLE(10_0) __IOS_PROHIBITED __WATCHOS_PROHIBITED,
    //    UIBlurEffectStyleRegular NS_ENUM_AVAILABLE_IOS(10_0), // Adapts to user interface style
    //    UIBlurEffectStyleProminent
}

/** 移除高斯模糊 */
- (void)removeBlurEffect {
    for (UIView *view1 in [self subviews]) {
        
        if ([view1 isKindOfClass:[UIVisualEffectView class]]) {
            [view1 removeFromSuperview];
        }
    }
}

/**
 设置视图阴影
 
 @param shadowdirection 阴影的位置
 @param color 阴影的颜色
 @param radius 阴影的半径
 @param alpha 阴影的透明度
 */
- (void)setShadowWith:(ShadowDirection)shadowdirection color:(UIColor *)color radius:(CGFloat)radius alpha:(CGFloat)alpha {
    switch (shadowdirection) {
        case ShadowAround:{
            [self shadowAroundWithColor:color radius:radius alpha:alpha];
        }
            break;
        case ShadowTop:{
            [self shadowTopWithColor:color radius:radius alpha:alpha];
        }
            break;
        case ShadowBottom:{
            [self shadowBottomWithColor:color radius:radius alpha:alpha];
        }
            break;
        case ShadowLeft:{
            [self shadowLeftWithColor:color radius:radius alpha:alpha];
        }
            break;
        case ShadowRight:{
            [self shadowRightWithColor:color radius:radius alpha:alpha];
        }
            break;
        case ShadowBottomRight:{
            //            self shadowBottomRightWithColor:color Size:<#(CGSize)#>
        }
            break;
            
        default:
            break;
    }
}

/** 上方阴影 */
- (void)shadowTopWithColor:(UIColor *)color radius:(CGFloat)radius alpha:(CGFloat)alpha {
    
    [self setShadowWithColor:color radius:radius alpha:alpha];
    
    float _width  = self.bounds.size.width;
    float _addWH  = radius;
    
    CGPoint topLeft      = CGPointMake(-_addWH,-_addWH);            // 左上角
    CGPoint bottomLeft   = CGPointMake(0,0);                        // 左下角
    CGPoint topRight     = CGPointMake(_width+_addWH,-_addWH);      // 右上角
    CGPoint bottomRight  = CGPointMake(0,0);                        // 右下角
    
    CGPoint topMiddle    = CGPointMake(_width/2,-_addWH);           // 上中间
    CGPoint bottomMiddle = CGPointMake(0,0);                        // 下中间
    CGPoint leftMiddle   = CGPointMake(0,0);                        // 左中间
    CGPoint rightMiddle  = CGPointMake(0,0);                        // 右中间
    
    [self setShadowPathWithTopLeft:topLeft BottomLeft:bottomLeft TopRight:topRight BottomRight:bottomRight TopMiddle:topMiddle BottomMiddle:bottomMiddle LeftMiddle:leftMiddle RightMiddle:rightMiddle];
    
}

/** 下方阴影 */
- (void)shadowBottomWithColor:(UIColor *)color radius:(CGFloat)radius alpha:(CGFloat)alpha {
    
    [self setShadowWithColor:color radius:radius alpha:alpha];
    
    float _width  = self.bounds.size.width;
    float _height = self.bounds.size.height;
    float _addWH  = radius;
    
    CGPoint topLeft      = CGPointMake(0,0);                            // 左上角
    CGPoint bottomLeft   = CGPointMake(-_addWH,_height+_addWH);         // 左下角
    CGPoint topRight     = CGPointMake(0,0);                            // 右上角
    CGPoint bottomRight  = CGPointMake(_width+_addWH,_height+_addWH);   // 右下角
    
    CGPoint topMiddle    = CGPointMake(0,0);                            // 上中间
    CGPoint bottomMiddle = CGPointMake(_width/2,_height+_addWH);        // 下中间
    CGPoint leftMiddle   = CGPointMake(0,0);                            // 左中间
    CGPoint rightMiddle  = CGPointMake(0,0);                            // 右中间
    
    [self setShadowPathWithTopLeft:topLeft BottomLeft:bottomLeft TopRight:topRight BottomRight:bottomRight TopMiddle:topMiddle BottomMiddle:bottomMiddle LeftMiddle:leftMiddle RightMiddle:rightMiddle];
    
}

/** 左侧阴影 */
- (void)shadowLeftWithColor:(UIColor *)color radius:(CGFloat)radius alpha:(CGFloat)alpha {
    
    [self setShadowWithColor:color radius:radius alpha:alpha];
    
    float _height = self.bounds.size.height;
    float _addWH  = radius;
    
    CGPoint topLeft      = CGPointMake(-_addWH,-_addWH);                // 左上角
    CGPoint bottomLeft   = CGPointMake(-_addWH,_height+_addWH);         // 左下角
    CGPoint topRight     = CGPointMake(0,0);                            // 右上角
    CGPoint bottomRight  = CGPointMake(0,0);                            // 右下角
    
    CGPoint topMiddle    = CGPointMake(0,0);                            // 上中间
    CGPoint bottomMiddle = CGPointMake(0,0);                            // 下中间
    CGPoint leftMiddle   = CGPointMake(-_addWH,_height/2.0);              // 左中间
    CGPoint rightMiddle  = CGPointMake(0,0);                            // 右中间
    
    [self setShadowPathWithTopLeft:topLeft BottomLeft:bottomLeft TopRight:topRight BottomRight:bottomRight TopMiddle:topMiddle BottomMiddle:bottomMiddle LeftMiddle:leftMiddle RightMiddle:rightMiddle];
}

/** 右侧阴影 */
- (void)shadowRightWithColor:(UIColor *)color radius:(CGFloat)radius alpha:(CGFloat)alpha {
    
    [self setShadowWithColor:color radius:radius alpha:alpha];
    
    float _width  = self.bounds.size.width;
    float _height = self.bounds.size.height;
    float _addWH  = radius;
    
    CGPoint topLeft      = CGPointMake(0,0);                            // 左上角
    CGPoint bottomLeft   = CGPointMake(0,0);                            // 左下角
    CGPoint topRight     = CGPointMake(_width+_addWH,-_addWH);          // 右上角
    CGPoint bottomRight  = CGPointMake(_width+_addWH,_height+_addWH);   // 右下角
    
    CGPoint topMiddle    = CGPointMake(0,0);                            // 上中间
    CGPoint bottomMiddle = CGPointMake(0,0);                            // 下中间
    CGPoint leftMiddle   = CGPointMake(0,0);                            // 左中间
    CGPoint rightMiddle  = CGPointMake(_width+_addWH,_height/2.0);        // 右中间
    
    [self setShadowPathWithTopLeft:topLeft BottomLeft:bottomLeft TopRight:topRight BottomRight:bottomRight TopMiddle:topMiddle BottomMiddle:bottomMiddle LeftMiddle:leftMiddle RightMiddle:rightMiddle];
}

/** 右&下 */
- (void)shadowBottomRightWithColor:(UIColor *)color radius:(CGFloat)radius {
    
    self.layer.shadowColor = [color CGColor];// shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0, -radius);// shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = 0.5;// 阴影透明度，默认0
    self.layer.shadowRadius = radius;// 阴影半径，默认3
    self.layer.masksToBounds = NO;
    
}

/** 全部阴影 */
- (void)shadowAroundWithColor:(UIColor *)color radius:(CGFloat)radius alpha:(CGFloat)alpha {
    
    [self setShadowWithColor:color radius:radius alpha:alpha];
    
    float _width  = self.bounds.size.width;
    float _height = self.bounds.size.height;
    float _addWH  = radius;
    
    CGPoint topLeft      = CGPointMake(-_addWH,-_addWH);                // 左上角
    CGPoint bottomLeft   = CGPointMake(-_addWH,_height+_addWH);         // 左下角
    CGPoint topRight     = CGPointMake(_width+_addWH,-_addWH);          // 右上角
    CGPoint bottomRight  = CGPointMake(_width+_addWH,_height+_addWH);   // 右下角
    
    CGPoint topMiddle    = CGPointMake(_width/2.0,-_addWH);               // 上中间
    CGPoint bottomMiddle = CGPointMake(_width/2.0,_height+_addWH);        // 下中间
    CGPoint leftMiddle   = CGPointMake(-_addWH,_height/2.0);              // 左中间
    CGPoint rightMiddle  = CGPointMake(_width+_addWH,_height/2.0);        // 右中间
    
    [self setShadowPathWithTopLeft:topLeft BottomLeft:bottomLeft TopRight:topRight BottomRight:bottomRight TopMiddle:topMiddle BottomMiddle:bottomMiddle LeftMiddle:leftMiddle RightMiddle:rightMiddle];
    
}

/** 设置阴影属性 */
- (void)setShadowWithColor:(UIColor *)color radius:(CGFloat)radius alpha:(CGFloat)alpha {
    self.layer.shadowColor = [color CGColor];// shadowColor阴影颜色
    self.layer.shadowOffset = CGSizeMake(0, 0);// shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
    self.layer.shadowOpacity = alpha;// 阴影透明度，默认0
    self.layer.shadowRadius = radius;// 阴影半径，默认3
//    self.layer.masksToBounds = NO;
    
}

/** 添加阴影 */
- (void)setShadowPathWithTopLeft:(CGPoint)topLeft BottomLeft:(CGPoint)bottomLeft TopRight:(CGPoint)topRight BottomRight:(CGPoint)bottomRight TopMiddle:(CGPoint)topMiddle BottomMiddle:(CGPoint)bottomMiddle LeftMiddle:(CGPoint)leftMiddle RightMiddle:(CGPoint)rightMiddle {
    
    // 路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:topLeft];
    
    // 添加四个二元曲线
    [path addQuadCurveToPoint:topRight controlPoint:topMiddle];
    
    [path addQuadCurveToPoint:bottomRight controlPoint:rightMiddle];
    
    [path addQuadCurveToPoint:bottomLeft controlPoint:bottomMiddle];
    
    [path addQuadCurveToPoint:topLeft controlPoint:leftMiddle];
    
    // 设置阴影路径
    self.layer.shadowPath = path.CGPath;
    
}


#pragma mark - 弹框

- (void)setChildViewWithNSArray:(NSArray *)arr title:(NSString *)title action:(SEL)action {
    CGFloat H;
    if (AUTO_SCALE_H(36)+(CELL_H+1)*arr.count-1>SCREEN_HEIGHT*0.6) {
        H = SCREEN_HEIGHT*0.6;
    }
    else {
        H = AUTO_SCALE_H(36)+(CELL_H+1)*arr.count-1;
    }
    
    [Controls viewWith:self frame:CGRectMake(0, 0, AUTO_SCALE_W(250), H) backColor:kWHITE_COLOR alpha:1.0 cornerRadius:0];
    self.center = self.superview.center;
    
    [self tanView:self NSArray:arr title:title target:self action:action];
    
}

- (void)tanView:(UIView *)backView NSArray:(NSArray *)arr title:(NSString *)title target:(id)target action:(SEL)action {
    
    UIView *redView = [[UIView alloc]init];
    [Controls viewWith:redView frame:CGRectMake(0, 0, FUNC_W(backView), AUTO_SCALE_H(36)) backColor:kMAIN_COLOR alpha:1.0 cornerRadius:0];
    [backView addSubview:redView];
    
    UILabel *leixingLabel = [[UILabel alloc]init];
    [Controls labelWith:leixingLabel frame:CGRectMake(MARGIN_W_38, 0, FUNC_W(redView), FUNC_H(redView)) title:title titleColor:kWHITE_COLOR backColor:nil font:16.0 bold:NO cornerRadius:0];
    [redView addSubview:leixingLabel];
    
    
    if (AUTO_SCALE_H(36)+(CELL_H+1)*arr.count-1>SCREEN_HEIGHT*0.66) {
        UIScrollView *whiteView = [[UIScrollView alloc]init];
        [Controls scrollViewWith:whiteView frame:CGRectMake(0, FUNC_H(redView), FUNC_W(backView), FUNC_H(backView)-FUNC_H(redView)) contentSize:CGSizeMake(FUNC_W(redView), (CELL_H+1)*arr.count-1) delegate:self bounces:NO pagingEnabled:NO showsHorizontal:NO showsVertical:NO];
        [backView addSubview:whiteView];
        
        for (int i = 0; i < arr.count; i++) {
            UILabel *la = [[UILabel alloc]init];
            [Controls labelWith:la frame:CGRectMake(MARGIN_W_38, (CELL_H+1)*i, FUNC_W(backView)-MARGIN_W_38*2, CELL_H) title:arr[i] titleColor:kTITLE_COLOR backColor:nil font:15.0 bold:NO cornerRadius:0];
            [whiteView addSubview:la];
            
            UIView *line = [[UIView alloc]init];
            [Controls line:line frame:CGRectMake(0, FUNC_Y(la)+FUNC_H(la), FUNC_W(whiteView), 1) lineColor:kLINE_COLOR];
            [whiteView addSubview:line];
            
            UIButton *btn = [[UIButton alloc]init];
            [Controls buttonWith:btn frame:CGRectMake(0, (CELL_H+1)*i, FUNC_W(whiteView), CELL_H) backImageName:nil title:nil titleColor:nil backColor:nil font:0 target:target action:action cornerRadius:0];
            btn.tag = i;
            [whiteView addSubview:btn];
        }
        
    }
    else {
        UIView *whiteView = [[UIView alloc]init];
        [Controls viewWith:whiteView frame:CGRectMake(0, FUNC_H(redView), FUNC_W(backView), (CELL_H+1)*arr.count-1) backColor:kWHITE_COLOR alpha:1.0 cornerRadius:0];
        [backView addSubview:whiteView];
        
        for (int i = 0; i < arr.count; i++) {
            UILabel *la = [[UILabel alloc]init];
            [Controls labelWith:la frame:CGRectMake(MARGIN_W_38, (CELL_H+1)*i, FUNC_W(backView)-MARGIN_W_38*2, CELL_H) title:arr[i] titleColor:kTITLE_COLOR backColor:nil font:15.0 bold:NO cornerRadius:0];
            [whiteView addSubview:la];
            
            UIView *line = [[UIView alloc]init];
            [Controls line:line frame:CGRectMake(0, FUNC_Y(la)+FUNC_H(la), FUNC_W(whiteView), 1) lineColor:kLINE_COLOR];
            [whiteView addSubview:line];
            
            UIButton *btn = [[UIButton alloc]init];
            [Controls buttonWith:btn frame:CGRectMake(0, (CELL_H+1)*i, SCREEN_WIDTH, CELL_H) backImageName:nil title:nil titleColor:nil backColor:nil font:0 target:target action:action cornerRadius:0];
            btn.tag = i;
            [whiteView addSubview:btn];
        }
        
    }
    
}


#pragma mark - 截图处理

/** 截手机全屏 */
- (id)saveAllImage {
    
    UIImage *image = [self saveImageWithWindowSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    return image;
}

/** 根据 window 截 view 视图 */
- (id)saveImageWithWindow {
    UIImage *image = [self saveImageWithWindowSize:self.bounds.size];
    
    return image;
}

/** 根据 window 截 view 视图 */
- (id)saveImageWithWindowSize:(CGSize)size {
     //    CGSize imageSize = CGSizeZero;
     //    imageSize = [UIScreen mainScreen].bounds.size;
     //
     //    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
     //    CGContextRef context = UIGraphicsGetCurrentContext();
     //
     //    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     //
     //    UIWindow *window = appdelegate.window;
     //
     //    CGContextSaveGState(context);
     //    CGContextTranslateCTM(context, window.center.x, window.center.y);
     //    CGContextConcatCTM(context, theView.transform);
     //    CGContextTranslateCTM(context, -window.bounds.size.width * window.layer.anchorPoint.x, -window.bounds.size.height * window.layer.anchorPoint.y);
     //
     //    if ([theView respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
     //        [theView drawViewHierarchyInRect:window.bounds afterScreenUpdates:YES];
     //    }
     //    else  {
     //        [theView.layer renderInContext:context];
     //    }
     //    CGContextRestoreGState(context);
     //
     //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
     //    UIGraphicsEndImageContext();
     //
     //    if (image != nil) {
     //        //保存图片到相册
     //        UIImageWriteToSavedPhotosAlbum(image, self, NULL, NULL);
     //    }
     //
     //    return image;
     
     CGSize imageSize = size;
     
     UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
     CGContextRef context = UIGraphicsGetCurrentContext();
     
     AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     
     UIWindow *window = appdelegate.window;
     
     CGContextSaveGState(context);
     CGContextTranslateCTM(context, window.center.x, window.center.y);
     //    CGContextConcatCTM(context, theView.transform);
     //    CGContextTranslateCTM(context, -theView.bounds.size.width * window.layer.anchorPoint.x, -theView.bounds.size.height * window.layer.anchorPoint.y);
     CGContextTranslateCTM(context, -window.bounds.size.width/2.0, -window.bounds.size.height/2.0) ;
     
     if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
         [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
     }
     else  {
         [self.layer renderInContext:context];
     }
     CGContextRestoreGState(context);
     
     UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     
     if (image != nil) {
         //保存图片到相册
         //        UIImageWriteToSavedPhotosAlbum(image, self, NULL, NULL);
     }
     
     return image;

}

/** 直接截 view 视图 */
- (id)saveImage {
    
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        //保存图片到相册
//        UIImageWriteToSavedPhotosAlbum(theImage, self, NULL, NULL);
    }
    
    return image;
}


#pragma mark - 通知监听
/** 发送通知，无内容 */
- (void)postObserveNotiWithNotiName:(NSString *)notiName {
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil];
}

/** 发送通知，有内容 */
- (void)postObserveNotiWithNotiName:(NSString *)notiName userInfo:(NSDictionary *)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:nil userInfo:userInfo];
}

/** 监听通知 */
- (void)addObserveNotiWithNotiName:(NSString *)notiName action:(SEL)action {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:action name:notiName object:nil];
}

/** 移除某个通知 */
- (void)removeObserveNotiWithNotiName:(NSString *)notiName {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notiName object:nil];
}

/** 移除所有通知 */
- (void)removeObserveNotiWithNotiName {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
