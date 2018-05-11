//
//  XLabel.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "XLabel.h"

@implementation XLabelItem

@end

@implementation XLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//  
- (CGSize)getLabelSizeWith:(CGSize)size itemArray:(NSArray *)arr {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,self.text.length)];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    // 行间距
    if(self.lineSpace > 0){
        
        [paragraphStyle setLineSpacing:self.lineSpace];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,self.text.length)];
    }
    
    // 字间距
    if(self.charSpace > 0){
        
        long number = self.charSpace;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
        [attributedString addAttribute:NSKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
        
        CFRelease(num);
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

    // 不同区域的文字
    for (int i = 0; i<arr.count; i++) {
        XLabelItem *item = arr[i];
        
        BOOL flag = [self.text length] > item.range.location+item.range.length;
        // 防止字符串越界
        if (flag) {
            if (item.font) {
                [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:item.font] range:item.range];
            }
            if (item.textColor) {
                [attributedString addAttribute:NSForegroundColorAttributeName value:item.textColor range:item.range];
            }
            if (item.underlineColor) {
                // 下划线类型(粗细和字体相关)
                [attributedString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:item.range];
                
                // 下划线颜色
                [attributedString addAttribute:NSUnderlineColorAttributeName value:item.underlineColor range:item.range];
            }
            
        }
       
    }
    
    self.attributedText = attributedString;
    
    CGRect rect = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    // 向上取整，防止画UI时lab的高度取整
//    return ceil(rect.size.height);
    return rect.size;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
