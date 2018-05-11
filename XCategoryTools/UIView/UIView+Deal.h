//
//  UIView+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,ShadowDirection) {
    /** 四周阴影 */
    ShadowAround,
    /** 上方阴影 */
    ShadowTop,
    /** 下方阴影 */
    ShadowBottom,
    /** 左侧阴影 */
    ShadowLeft,
    /** 右侧阴影 */
    ShadowRight,
    /** 右下阴影 */
    ShadowBottomRight,
};

typedef NS_ENUM(NSUInteger,RadiusDirection) {
    /** 四周圆角 */
    RadiusAround,
    /** 上方圆角 */
    RadiusTop,
    /** 下方圆角 */
    RadiusBottom,
    /** 左侧圆角 */
    RadiusLeft,
    /** 右侧圆角 */
    RadiusRight,
    /** 左上圆角 */
    RadiusTopLeft,
    /** 右上圆角 */
    RadiusTopRight,
    /** 左下圆角 */
    RadiusBottomLeft,
    /** 右下圆角 */
    RadiusBottomRight,
    /** 左上右下圆角 */
    RadiusTopLeftAndBottomRight,
    /** 右上左下圆角 */
    RadiusTopRightAndBottomLeft,
    
};


@interface UIView (Deal)


#pragma mark - 视图处理

/** 清空视图 */
- (void)clearView;

/** 清空视图后添加子视图 */
- (void)clearView:(UIView *)backView;


#pragma mark - 虚线处理

/**
 画虚线

 @param lineLength 虚线的长度
 @param lineSpacing 虚线之间的间隔
 @param lineColor 虚线的颜色
 */
- (void)drawDashLineWithLineLength:(CGFloat)lineLength lineSpacing:(CGFloat)lineSpacing lineColor:(UIColor *)lineColor ;


#pragma mark - 圆角边框

/**
 添加指定角的圆角

 @param radius 圆角度数
 @param radiusDirection 圆角的位置
 @return 处理结果
 */
- (id)addRadius:(CGFloat)radius radiusDirection:(RadiusDirection)radiusDirection;

/**
 添加圆角

 @param radius 圆角度数
 @return 处理结果
 */
- (id)addRadius:(CGFloat)radius;

/**
 添加边框

 @param width 边框宽度
 @param color 边框颜色
 @return 处理结果
 */
- (id)addBorderWidth:(CGFloat)width color:(UIColor *)color;

/**
 添加圆角和边框

 @param width 边框宽度
 @param color 边框颜色
 @param radius 圆角度数
 @return 处理结果
 */
- (id)addBorderWidth:(CGFloat)width color:(UIColor *)color radius:(CGFloat)radius;

/**
 画边框，只有边框，边框里面被挖空

 @param width 边框宽度
 @param color 边框颜色
 @return 处理结果
 */
- (id)drawBorderWith:(CGFloat)width color:(UIColor *)color;

/**
 画边框，只有边框，边框里面被挖空

 @param width 边框宽度
 @param color 边框颜色
 @param radius 圆角度数
 @return 处理结果
 */
- (id)drawBorderWith:(CGFloat)width color:(UIColor *)color radius:(CGFloat)radius;


#pragma mark - 模糊处理
/** 添加高斯模糊 */
- (void)addBlurEffect:(UIBlurEffectStyle)blurEffectStyle;

/** 移除高斯模糊 */
- (void)removeBlurEffect;

#pragma mark - 阴影处理
/**
 设置视图阴影

 @param shadowdirection 阴影的位置
 @param color 阴影的颜色
 @param radius 阴影的半径
 @param alpha 阴影的透明度
 */
- (void)setShadowWith:(ShadowDirection)shadowdirection color:(UIColor *)color radius:(CGFloat)radius alpha:(CGFloat)alpha;

#pragma mark - 截图处理
/** 截手机全屏 */
- (id)saveAllImage;

/** 根据 window 截 view 视图 */
- (id)saveImageWithWindow;

/** 根据 window 截 view 视图 */
 - (id)saveImageWithWindowSize:(CGSize)size;

/** 直接截 view 视图 */
- (id)saveImage;

///** 截长图 */
//- (id)saveLongImag;


#pragma mark - 通知处理
/** 发送通知，无内容 */
- (void)postObserveNotiWithNotiName:(NSString *)notiName;

/** 发送通知，有内容 */
- (void)postObserveNotiWithNotiName:(NSString *)notiName userInfo:(NSDictionary *)userInfo;

/** 监听通知 */
- (void)addObserveNotiWithNotiName:(NSString *)notiName action:(SEL)action;

/** 移除某个通知 */
- (void)removeObserveNotiWithNotiName:(NSString *)notiName;

/** 移除所有通知 */
- (void)removeObserveNotiWithNotiName;



@end
