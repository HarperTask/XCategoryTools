//
//  UIImage+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UIImage+Deal.h"

@implementation UIImage (Deal)

//  核心模糊方法
- (id)coreBlurwithBlurNumber:(CGFloat)blur {
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage  *inputImage=[CIImage imageWithCGImage:self.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey: @"inputRadius"];
    // 模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    
    return blurImage;
}

//  当前界面截图
- (id)imageFromCurrentView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, view.layer.contentsScale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

//  图片大小设置
- (id)imageToSize:(CGSize)size {
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace,kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, size.width/3, size.height/3);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), scaledImage.CGImage);
    // CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // 返回新的改变大小后的图片
    return scaledImage;
    
}

static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight) {
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2.0);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2.0, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2.0, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2.0, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2.0, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

// base64 位编码
+ (id)imageWithBase64EncodedString:(NSString *)encodedString {
    NSData *imgData = [[NSData alloc]initWithBase64EncodedString:encodedString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *image = [UIImage imageWithData:imgData];
    
    return image;
}

// 压缩成指定大小
- (NSData *)compressImageToKBytes:(CGFloat)kBytes {
    
    NSData *data = UIImageJPEGRepresentation(self, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    
    while (dataKBytes > kBytes && maxQuality > 0.01f) {
        
        maxQuality = maxQuality - 0.01f;
        
        data = UIImageJPEGRepresentation(self, maxQuality);
    
        dataKBytes = data.length / 1000.0;
        
        if (lastData == dataKBytes) {
            break;
        }
        else{
            lastData = dataKBytes;
        }
    }
    
    return data;
}

+ (NSData *)compressImage:(UIImage *)image KBytes:(CGFloat)kBytes {
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    
    while (dataKBytes > kBytes && maxQuality > 0.01f) {
        
        maxQuality = maxQuality - 0.01f;
        
        data = UIImageJPEGRepresentation(image, maxQuality);
        
        dataKBytes = data.length / 1000.0;
        
        if (lastData == dataKBytes) {
            break;
        }
        else{
            lastData = dataKBytes;
        }
    }
    
    return data;

}

/** 在图片上添加另外一张图片，生成新的图片 */
- (id)addSubImage:(UIImage *)image frame:(CGRect)frame {
    // 1.获取底图的大小
    CGImageRef imgRef1 = self.CGImage;
    CGFloat w1 = CGImageGetWidth(imgRef1);
    CGFloat h1 = CGImageGetHeight(imgRef1);
    
    // 2.获取子视图的坐标
//    CGImageRef imgRef = image.CGImage;
//    CGFloat x = frame.origin.x;
//    CGFloat y = frame.origin.y;
//    CGFloat w = frame.size.width;
//    CGFloat h = frame.size.height;
    
    // 3.以获取底图的大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(w1, h1));
    
    // 4.把底图画到上下文中
    [self drawInRect:CGRectMake(0, 0, w1, h1)];
    
    // 5.再把小图放在上下文中 像素坐标
//    [image drawInRect:frame];//再把小图放在上下文中
    [image drawInRect:CGRectMake(frame.origin.x * 2, frame.origin.y * 2, frame.size.width * 2, frame.size.width * 2)];//再把小图放在上下文中
    
    // 6.从当前上下文中获得最终图片
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7.关闭上下文
    UIGraphicsEndImageContext();
    
    // 8.保存到相册
//    UIImageWriteToSavedPhotosAlbum(resultImg, self, NULL, NULL);
    
    return resultImg;
}

/** 在图片上添加另外一张图片，生成新的图片 */
- (id)spliceImage:(UIImage *)image frame:(CGRect)frame {
    // 1.获取底图的大小
    CGImageRef imgRef1 = self.CGImage;
    CGFloat w1 = CGImageGetWidth(imgRef1);
    CGFloat h1 = CGImageGetHeight(imgRef1);
    
    // 2.获取子视图的坐标
    //    CGImageRef imgRef = image.CGImage;
    //    CGFloat x = frame.origin.x;
    //    CGFloat y = frame.origin.y;
    //    CGFloat w = frame.size.width;
    //    CGFloat h = frame.size.height;
    
    // 3.以获取底图的大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(w1, h1));
    
    // 4.把底图画到上下文中
    [self drawInRect:CGRectMake(0, 0, w1, h1)];
    
    // 5.再把小图放在上下文中 像素坐标
    //    [image drawInRect:frame];//再把小图放在上下文中
    [image drawInRect:CGRectMake(frame.origin.x * 2, frame.origin.y * 2, frame.size.width * 2, frame.size.width * 2)];//再把小图放在上下文中
    
    // 6.从当前上下文中获得最终图片
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    
    // 7.关闭上下文
    UIGraphicsEndImageContext();
    
    // 8.保存到相册
    //    UIImageWriteToSavedPhotosAlbum(resultImg, self, NULL, NULL);
    
    return resultImg;
}

/** 给图片加圆角 */
- (id)addRadius:(CGFloat)radius {
    
    CGRect rect = (CGRect){0.f,0.f,self.size};
    
    // void UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
    //size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
    //    opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    //    scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);
    
    // 根据矩形画带圆角的曲线
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);
    
    [self drawInRect:rect];
    
    //图片缩放，是非线程安全的
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}


@end
