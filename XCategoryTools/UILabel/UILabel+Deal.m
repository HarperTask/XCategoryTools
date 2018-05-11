//
//  UILabel+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UILabel+Deal.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>


@implementation UILabel (Deal)

- (CGFloat)charSpace {
    return [objc_getAssociatedObject(self,_cmd) floatValue];
}

- (void)setCharSpace:(CGFloat)charSpace {
    objc_setAssociatedObject(self, @selector(charSpace), @(charSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (CGFloat)lineSpace {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setLineSpace:(CGFloat)lineSpace {
    objc_setAssociatedObject(self, @selector(lineSpace), @(lineSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)firsthead {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setFirsthead:(CGFloat)firsthead {
    objc_setAssociatedObject(self, @selector(firsthead), @(firsthead), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)head {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setHead:(CGFloat)head {
    objc_setAssociatedObject(self, @selector(head), @(head), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)tail {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setTail:(CGFloat)tail {
    objc_setAssociatedObject(self, @selector(tail), @(tail), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSRange)range {
    return [objc_getAssociatedObject(self, _cmd) rangeValue];
}


#pragma mark - 颜色处理

/**
 设定颜色
 
 @param string 要处理的全部字符串
 @param range 特殊颜色字符串的位置和长度
 @param color 特殊颜色
 */
- (void)setLabelDifferentColorWithString:(NSString *)string range:(NSRange)range color:(UIColor *)color {
//    XHBLog(@"%lu:%lu", [string length],range.length+range.location);
       
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc]initWithString:string];
    
    if ([string length]>range.location+range.length) {
         
        [tempStr addAttribute:NSForegroundColorAttributeName value:color range:range];
        
    }

    self.attributedText = tempStr;
}

/**
 设定多种颜色
 
 @param string 要处理的全部字符串
 @param range1 特殊颜色字符串的位置和长度1
 @param color1 特殊颜色1
 @param range2 特殊颜色字符串的位置和长度2
 @param color2 特殊颜色2
 */
- (void)setLabelDifferentColorWithString:(NSString *)string range1:(NSRange)range1 color1:(UIColor *)color1 range2:(NSRange)range2 color2:(UIColor *)color2 {
    
//    XHBLog(@"%lu:%lu", [string length],range2.length+range2.location);
    
    NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc]initWithString:string];

    if ([string length]>range1.location+range1.length) {
         [tempStr addAttribute:NSForegroundColorAttributeName value:color1 range:range1];
    }
    if ([string length]>range2.location+range2.length) {
         [tempStr addAttribute:NSForegroundColorAttributeName value:color2 range:range2];
    }
    
    self.attributedText = tempStr;

}


#pragma mark - 大小处理

/**
 获取普通 Label 的大小
 
 @param size 默认大小
 @param string label 的内容
 @param font label 的字体大小
 @return 计算的大小
 */
- (CGSize)getLabelSizeWith:(CGSize)size string:(NSString *)string font:(CGFloat)font {
    
    CGSize labelSize;
    if ([string length]>0) {
        labelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AUTO_SCALE_F(font)]} context:nil].size;
    }
    else {
        labelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:0]} context:nil].size;
    
    }
    
    return labelSize;
}

/**
 获取普通 Label 的大小 bold是否时系统加粗字体
 
 @param size 默认大小
 @param string label 的内容
 @param font label 的字体大小
 @param bold 是否加粗
 @return 计算的大小
 */
- (CGSize)getLabelSizeWith:(CGSize)size string:(NSString *)string font:(CGFloat)font bold:(BOOL)bold {
    
    CGSize labelSize;
    if ([string length]>0) {
        if (bold) {
            labelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:AUTO_SCALE_F(font)]} context:nil].size;
        }
        else {
            labelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:AUTO_SCALE_F(font)]} context:nil].size;
        }
        
    }
    else {
        labelSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:0]} context:nil].size;
        
    }
    
    return labelSize;
}

//  间距大小
- (CGSize)getLabelSizeWith:(CGSize)size font:(CGFloat)font {
    CGSize labelSize;
    if ([self.text isNil]) {
        return CGSizeMake(0, 0);
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0,self.text.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    // 行间距
    if (self.lineSpace) {
        [paragraphStyle setLineSpacing:self.lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,self.text.length)];
    }
    
    // 字间距
    if (self.charSpace) {
//        long number = self.charSpace;
//        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
//        [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
//        
//        CFRelease(num);
    }
    
    //首行缩进
    if (self.firsthead) {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.firstLineHeadIndent = self.firsthead;

        [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.text.length)];

    }
    
    // 行首缩进
    if (self.head) {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.headIndent = self.head;
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.text.length)];
    }
    
    // 行尾缩进
    if (self.tail) {
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.tailIndent = -self.tail;
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, self.text.length)];
    }
    
    self.attributedText = attributedString;
    
    CGRect rect = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];

    labelSize = rect.size;
    
    return labelSize;
}


//  间距高度
- (CGFloat)getSpaceLabelHeightWith:(NSString *)string withFont:(CGFloat)font withLineSpace:(CGFloat)lineSpace size:(CGSize)textSize textlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing {
   
    if ([string length] == 0) {
        return 0;
    }
    
    else {
        CGSize labelSize;
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        
        paraStyle.alignment = NSTextAlignmentLeft;
        
        paraStyle.lineSpacing = lineSpace;              //行间距
        
        paraStyle.paragraphSpacing = paragraphSpacing;  //段间距
        
        paraStyle.hyphenationFactor = 1.0;
        
        paraStyle.firstLineHeadIndent = 0.0;
        
        paraStyle.paragraphSpacingBefore = 0.0;
        
        paraStyle.headIndent = 0;
        
        paraStyle.tailIndent = 0;
        
        NSDictionary *dic = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:AUTO_SCALE_F(font)],
                              NSParagraphStyleAttributeName:paraStyle,
                              NSKernAttributeName:textlengthSpace //字间距
                              
                              };
        
        labelSize = [string boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        return labelSize.height;
    }

    
}


#pragma mark - 间距处理

/**
 行间距
 
 @param space 间距大小
 @param string label 的内容
 */
- (void)setLineSpacing:(CGFloat)space string:(NSString *)string {
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineSpacing = space;
    
    [self tempStrWithString:string Style:style];
}

/**
 首行缩进
 
 @param firsthead 缩进大小
 @param string label 的内容
 */
- (void)setFirstLineHeadIndent:(int)firsthead string:(NSString *)string {
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.firstLineHeadIndent = firsthead;
    
    [self tempStrWithString:string Style:style];
}

/**
 行首缩进
 
 @param head 缩进大小
 @param string label 的内容
 */
- (void)setLineheadIndent:(int)head string:(NSString *)string {
   
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.headIndent = head;
    
    [self tempStrWithString:string Style:style];
    
}

/**
 行尾缩进
 
 @param tail 缩进大小
 @param string label 的内容
 */
- (void)setTailIndent:(int)tail string:(NSString *)string {
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -tail;
    
    [self tempStrWithString:string Style:style];
}

/**
 设置首行缩进,,行尾缩进
 
 @param string label 的内容
 @param alignment 对齐方式
 @param head 行首缩进大小
 @param firsthead 行首缩进大小
 @param tail 行尾缩进大小
 @param space 行间距
 */
- (void)setIndentationWithString:(NSString *)string alignment:(NSTextAlignment)alignment lineheadIndent:(int)head firstLineIndent:(int)firsthead tailIndent:(int)tail lineSpacing:(CGFloat)space {
    
    NSMutableParagraphStyle *style =  [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment           = alignment;//对齐
    style.lineSpacing         = space;
    style.firstLineHeadIndent  = firsthead;
    style.headIndent          = head;
    style.tailIndent          = -tail;
    
    [self tempStrWithString:string Style:style];
    
}

- (void)tempStrWithString:(NSString *)string Style:(NSMutableParagraphStyle *)style {
    
    if ([string length]>0) {
        NSMutableAttributedString *tempStr = [[NSMutableAttributedString alloc] initWithString:string];
        
        [tempStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
        
        self.attributedText = tempStr;

    }
}


#pragma mark - 下划线处理

/**
 下划线
 
 @param string label 的内容
 @param range 需要添加下划线内容的位置和长度
 */
- (void)setUnderlineWithString:(NSString *)string range:(NSRange)range {
    
    if ([string length]>0) {
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:string];
        NSRange contentRange = {0,2};
        [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
        
        self.attributedText = content;

    }
}


@end
