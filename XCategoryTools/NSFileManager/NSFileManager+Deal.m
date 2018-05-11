//
//  NSFileManager+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "NSFileManager+Deal.h"

@implementation NSFileManager (Deal)

/**
 创建本地文件夹
 
 @param filePath 文件夹路径
 */
+ (void)createDirectory:(NSString *)filePath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *directory = [NSHomeDirectory() stringByAppendingPathComponent:filePath];
   
    [fileManager createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
}

/**
 计算文件大小 按照换算单位返回相应值(B/K/M)
 
 @param path 文件路径
 @param danwei 返回文件大小计算单位
 @return 单件大小
 */
+ (float)fileSizeWithFilePath:(NSString *)path Danwei:(Danwei)danwei;{
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 判断字符串是否为文件/文件夹
    BOOL flag = NO;
    BOOL exists = [mgr fileExistsAtPath:path isDirectory:&flag];
    
    // 文件/文件夹不存在
    if (exists == NO) return 0;
    
    float totalByteSize = 0;
    
    // 文件夹
    if (flag) {
        // 遍历文件夹中的所有内容
        NSArray *subpaths = [mgr subpathsAtPath:path];
        
        // 计算文件夹大小
        for (NSString *subpath in subpaths){
            // 拼接全路径
            NSString *fullSubPath = [path stringByAppendingPathComponent:subpath];
            
            // 判断是否为文件
            BOOL flag = NO;
            [mgr fileExistsAtPath:fullSubPath isDirectory:&flag];
            if (flag == NO){// 是文件
                NSDictionary *attr = [mgr attributesOfItemAtPath:fullSubPath error:nil];
                
                totalByteSize += [attr[NSFileSize] integerValue];
            }
        }
        
        
    }
    else {// 是文件
        NSDictionary *attr = [mgr attributesOfItemAtPath:path error:nil];
        
        totalByteSize = [attr[NSFileSize] integerValue];
    }
    
    switch (danwei) {
        case Danwei_B:
            return totalByteSize;
            break;
        case Danwei_K:
            return totalByteSize/1024.0;
            break;
        case Danwei_M:
            return totalByteSize/1024.0/1024.0;
            break;
        case Danwei_G:
            return totalByteSize/1024.0/1024.0/1024.0;
            break;
            
        default:
            return totalByteSize;
            break;
    }
    
}

/**
 复制工程里的文件到沙盒中
 
 @param path 文件路径
 @param fileName 工程里的文件名，也是复制后文件名
 @return 复制是否成功
 */
+ (BOOL)copyFileToPath:(NSString *)path fileName:(NSString *)fileName {
    BOOL flag = [self searchCacheWithFilePath:path];
    
    if (flag) {
        XHBLOG(@"%@ 已存在", fileName);
        
        return NO;
    }
    
    NSString *file = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",path,fileName];

    BOOL copyFlag = [fileManager copyItemAtPath:file toPath:filePath error:nil];
    
    if (copyFlag) {
        XHBLOG(@"%@ file copy success", fileName);
    }
    else {
        XHBLOG(@"%@ copy failed", fileName);
    }
    
    return YES;
}

/**
 检查磁盘内存大小
 
 @param path 磁盘路径
 @return 磁盘内存大小
 */
+ (CGFloat)checkFreeDiskSpaceWithPath:(NSString *)path  {
//    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:NSTemporaryDirectory()];
    NSError *error = nil;
//    if (@available(iOS 11.0, *)) {
//        NSDictionary *results = [fileURL resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey] error:&error];
//        if (!results) {
//            NSLog(@"Error retrieving resource keys: %@ %@", [error localizedDescription], [error userInfo]);
//
//            abort();
//
//        }
//        NSLog(@"Available capacity for important usage: %@", results);
//    } else {
//        // Fallback on earlier versions
//    }
    
    
    uint64_t freeSpace = 0;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSArray *paths = [path componentsSeparatedByString:@"/"];
    NSDictionary *attrbites = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (attrbites) {
        NSNumber *freeFileSystemSizeInBytes = [attrbites objectForKey:NSFileSystemFreeSize];
        freeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
        freeSpace = freeSpace/1000.0/1000.0;
        
        return freeSpace;
    }
    
    return freeSpace;
}

/**
 清空文件缓存
 
 @param path 文件路径
 */
+ (void)clearCacheWithFilePath:(NSString *)path {
    // 建立文件管理类
    NSFileManager *manager=[NSFileManager defaultManager];
    NSString *name;
    NSDirectoryEnumerator *directoryEnumerator= [manager enumeratorAtPath:path];
    
    // 遍历目录
    while (name = [directoryEnumerator nextObject]) {
        NSString *newPath=[NSString stringWithFormat:@"%@/%@",path,name];
        // 执行删除沙盒目录里的图片
        [manager removeItemAtPath:newPath error:nil];
    }

}

/**
 查找文件是否存在
 
 @param path 文件路径
 @return 是否存在
 */
+ (BOOL)searchCacheWithFilePath:(NSString *)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL flag = [fileManager fileExistsAtPath:path];
    
    if (flag) {
        return YES;
    }
    return NO;
}


@end
