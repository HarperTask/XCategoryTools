//
//  UITableView+Deal.h
//  CMe
//
//  Created by OS X on 2018/1/26.
//  Copyright © 2018年 杭州石匍丁科技公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol XTableViewDelegate <NSObject>

//@optional
- (void)loadNewData;

- (void)loadMoreData;

@end

@interface UITableView (Deal)

@property (nonatomic, weak) id <XTableViewDelegate> delegate;

/** 添加头部刷新 */
- (void)addHeaderRefresh;

/** 添加底部刷新 */
- (void)addFooterRefresh;


@end
