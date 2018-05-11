//
//  UIImage+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>


@interface UIImage (Deal)

/** 边框模糊方法 */

/** 核心模糊方法 */
- (id)coreBlurwithBlurNumber:(CGFloat)blur;

/** 当前界面截图 */
- (id)imageFromCurrentView:(UIView *)view;

/** 图片大小设置 */
- (id)imageToSize:(CGSize)size;

/** Base64 位编码 */
+ (id)imageWithBase64EncodedString:(NSString *)encodedString;

/** 压缩成指定大小以下 */
- (NSData *)compressImageToKBytes:(CGFloat)kBytes;

//+ (NSData *)compressImage:(UIImage *)image KBytes:(CGFloat)kBytes;

/** 在图片上添加另外一张图片，生成新的图片 */
- (id)addSubImage:(UIImage *)image frame:(CGRect)frame;

/** 给图片加圆角 */
- (id)addRadius:(CGFloat)radius;


@end
