//
//  NSFileManager+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,Danwei) {
    /** 单位是 B */
    Danwei_B,
    /** 单位是 KB */
    Danwei_K,
    /** 单位是 MB */
    Danwei_M,
    /** 单位是 GB */
    Danwei_G,
};

@interface NSFileManager (Deal)

/**
 创建本地文件夹

 @param filePath 文件夹路径
 */
+ (void)createDirectory:(NSString *)filePath;

/**
 计算文件大小 按照换算单位返回相应值(B/K/M)

 @param path 文件路径
 @param danwei 返回文件大小计算单位
 @return 单件大小
 */
+ (float)fileSizeWithFilePath:(NSString *)path Danwei:(Danwei)danwei;

/**
 复制工程里的文件到沙盒中

 @param path 文件路径
 @param fileName 工程里的文件名，也是复制后文件名
 @return 复制是否成功
 */
+ (BOOL)copyFileToPath:(NSString *)path fileName:(NSString *)fileName;

/**
 检查磁盘内存大小

 @param path 磁盘路径
 @return 磁盘内存大小
 */
+ (CGFloat)checkFreeDiskSpaceWithPath:(NSString *)path;

/**
 清空文件缓存

 @param path 文件路径
 */
+ (void)clearCacheWithFilePath:(NSString *)path;

/**
 查找文件是否存在

 @param path 文件路径
 @return 是否存在
 */
+ (BOOL)searchCacheWithFilePath:(NSString *)path;


@end
