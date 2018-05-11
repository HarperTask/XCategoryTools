//
//  UIImageView+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Deal)


#pragma mark - 缓存处理

/**
 加载沙盒缓存图片

 @param imagePath 图片路径
 @param placeholderImage 默认图片
 */


- (void)setCacheImageWithPath:(NSString *)imagePath PlaceholderImage:(UIImage *)placeholderImage;

/**
 预览网络图片,不下载到本地

 @param imagePath 图片路径
 @param placeholderImage 默认图片
 */
- (void)setURLImageWithPath:(NSString *)imagePath PlaceholderImage:(UIImage *)placeholderImage;



@end




