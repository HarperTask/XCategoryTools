//
//  UILabel+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (Deal)


/** 字间距 */
@property (nonatomic, assign) CGFloat charSpace;

/** 行间距  */
@property (nonatomic, assign) CGFloat lineSpace;

/** 首行缩进 */
@property (nonatomic, assign) CGFloat firsthead;

/** 行首缩进 */
@property (nonatomic, assign) CGFloat head;

/** 行尾缩进 */
@property (nonatomic, assign) CGFloat tail;


#pragma mark - 颜色处理

/**
 设定颜色

 @param string 要处理的全部字符串
 @param range 特殊颜色字符串的位置和长度
 @param color 特殊颜色
 */
- (void)setLabelDifferentColorWithString:(NSString *)string range:(NSRange)range color:(UIColor *)color;

/**
 设定多种颜色

 @param string 要处理的全部字符串
 @param range1 特殊颜色字符串的位置和长度1
 @param color1 特殊颜色1
 @param range2 特殊颜色字符串的位置和长度2
 @param color2 特殊颜色2
 */
- (void)setLabelDifferentColorWithString:(NSString *)string range1:(NSRange)range1 color1:(UIColor *)color1 range2:(NSRange)range2 color2:(UIColor *)color2;


#pragma mark - 大小处理

/**
 获取普通 Label 的大小

 @param size 默认大小
 @param string label 的内容
 @param font label 的字体大小
 @return 计算的大小
 */
- (CGSize)getLabelSizeWith:(CGSize)size string:(NSString *)string font:(CGFloat)font;

/**
 获取普通 Label 的大小 bold是否时系统加粗字体

 @param size 默认大小
 @param string label 的内容
 @param font label 的字体大小
 @param bold 是否加粗
 @return 计算的大小
 */
- (CGSize)getLabelSizeWith:(CGSize)size string:(NSString *)string font:(CGFloat)font bold:(BOOL)bold;

/**
 设置字间距,行间距,段间距,首行缩进,行首缩进,行尾缩进,并返回 Label 大小

 @param size <#size description#>
 @param font <#font description#>
 @return <#return value description#>
 */
- (CGSize)getLabelSizeWith:(CGSize)size font:(CGFloat)font;


/**
 设置行距,间距,段距,并返回 Label 高度

 @param str label 的内容
 @param font label 的字体大小
 @param lineSpace 行间距
 @param textSize <#textSize description#>
 @param textlengthSpace 字间距
 @param paragraphSpacing 段间距
 @return 计算的大小
 */
- (CGFloat)getSpaceLabelHeightWith:(NSString *)str withFont:(CGFloat)font withLineSpace:(CGFloat)lineSpace size:(CGSize)textSize textlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing;


#pragma mark - 间距处理

/**
 设置首行缩进,行尾缩进

 @param string label 的内容
 @param alignment 对齐方式
 @param head 行首缩进大小
 @param firsthead 行首缩进大小
 @param tail 行尾缩进大小
 @param space 行间距
 */
- (void)setIndentationWithString:(NSString *)string alignment:(NSTextAlignment)alignment lineheadIndent:(int)head firstLineIndent:(int)firsthead tailIndent:(int)tail lineSpacing:(CGFloat)space;


/**
 行间距

 @param space 间距大小
 @param string label 的内容
 */
- (void)setLineSpacing:(CGFloat)space string:(NSString *)string;

/**
 首行缩进

 @param firsthead 缩进大小
 @param string label 的内容
 */
- (void)setFirstLineHeadIndent:(int)firsthead string:(NSString *)string;

/**
 行首缩进

 @param head 缩进大小
 @param string label 的内容
 */
- (void)setLineheadIndent:(int)head string:(NSString *)string;

/**
 行尾缩进

 @param tail 缩进大小
 @param string label 的内容
 */
- (void)setTailIndent:(int)tail string:(NSString *)string;


#pragma mark - 下划线处理

/**
 下划线

 @param string label 的内容
 @param range 需要添加下划线内容的位置和长度
 */
- (void)setUnderlineWithString:(NSString *)string range:(NSRange)range;


///** 自定义后高度 */
//- (CGFloat)getLabelHeightWithSize:(CGSize)size itemArray:(NSArray *)arr;

@end



