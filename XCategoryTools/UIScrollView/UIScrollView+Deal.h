//
//  UIScrollView+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (Deal)

/** 是否滑到顶部 */
- (BOOL)isEndToTop;

/** 是否滑到底部 */
- (BOOL)isEndToBottom;

/** 截长图 */
- (id)saveLongImage;



@end
