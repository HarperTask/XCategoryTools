//
//  NSBundle+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "NSBundle+Deal.h"

@implementation NSBundle (Deal)

/** app 信息 */
+ (id)appInfo {
    NSDictionary *appinfoDic = [[NSBundle mainBundle] infoDictionary];
    
    return appinfoDic;
}

/** app 名称 */
+ (id)appName {
    [self appInfo];
    NSString *app_Name = [[NSBundle appInfo] objectForKey:@"CFBundleDisplayName"];
    
    return app_Name;
}

/** app 版本 */
+ (id)appVersion {
    NSString *app_Version = [[NSBundle appInfo] objectForKey:@"CFBundleShortVersionString"];
    
    return app_Version;
}

/** app build 版本 */
+ (id)appBuild {
    
    NSString *app_build = [[NSBundle appInfo] objectForKey:@"CFBundleVersion"];
    
    return app_build;
}

@end
