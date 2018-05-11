//
//  UIImageView+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UIImageView+Deal.h"

@implementation UIImageView (Deal)


#pragma mark - 缓存处理

/**
 加载沙盒缓存图片
 
 @param imagePath 图片路径
 @param placeholderImage 默认图片
 @return 加载图片后的相框
 */
- (void)setCacheImageWithPath:(NSString *)imagePath PlaceholderImage:(UIImage *)placeholderImage {
    if ([UIImage imageWithContentsOfFile:imagePath]) {
        self.image = [UIImage imageWithContentsOfFile:imagePath];
    }
    else {
        self.image = placeholderImage;
    }
    
}

/**
 预览网络图片,不下载到本地
 
 @param imagePath 图片路径
 @param placeholderImage 默认图片
 @return 加载图片后的相框
 */
- (void)setURLImageWithPath:(NSString *)imagePath PlaceholderImage:(UIImage *)placeholderImage {
//    self.image = placeholderImage;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //在block中去执行新的任务
        NSURL *url = [NSURL URLWithString:imagePath];
        NSData *data = [[NSData alloc]initWithContentsOfURL:url];
        UIImage *img = [[UIImage alloc]initWithData:data];
        
        //在主线程中更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = img;
        });
    });

    // 遍历数组元素
    NSArray *array = [[NSArray alloc]initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f", nil];
    
    //NSIndexSet类代表一个不可变的独特的无符号整数的集合,称为索引,因为使用它们的方式。这个集合被称为索引集    唯一的，有序的，无符号整数的集合
    [NSIndexSet indexSetWithIndex:1];//创建一个索引集合，根据索引值
    [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,8)];//创建一个索引集合，根据一个NSRange对象
    
    [array enumerateObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,3)] options:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"\n\n\nidx=%ld, id=%@", (unsigned long)idx, obj);
    }];
    
}

@end
