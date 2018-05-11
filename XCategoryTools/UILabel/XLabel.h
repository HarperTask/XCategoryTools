//
//  XLabel.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLabelItem : NSObject

/**  自定义范围  */
@property (nonatomic, assign) NSRange range;

/** 自定义字体 */
@property (nonatomic, assign) CGFloat font;

/** 自定义字体颜色 */
@property (nonatomic, strong, nonnull) UIColor *textColor;

/** 自定义下划线颜色 */
@property (nonatomic, strong, nonnull)UIColor *underlineColor;


@end


@interface XLabel : UILabel

/** 自定义间距大小 */
- (CGSize)getLabelSizeWith:(CGSize)size itemArray:(NSArray *_Nullable)arr;



@end
