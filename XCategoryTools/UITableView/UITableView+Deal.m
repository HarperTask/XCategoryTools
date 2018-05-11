//
//  UITableView+Deal.m
//  CMe
//
//  Created by OS X on 2018/1/26.
//  Copyright © 2018年 杭州石匍丁科技公司. All rights reserved.
//

#import "UITableView+Deal.h"



@implementation UITableView (Deal)


- (void)addHeaderRefreshh {
    //自动更改透明度
    self.mj_header.automaticallyChangeAlpha = YES;
    
    //下拉刷新
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

- (void)addFooterRefresh {
    //自动更改透明度
    self.mj_header.automaticallyChangeAlpha = YES;
    
    //上拉刷新
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadNewData {
//    if ([self.delegate respondsToSelector:@selector(loadNewData)]) {
//        [self.delegate loadNewData];
//    }
}

- (void)loadMoreData {
//    if ([self.delegate respondsToSelector:@selector(loadMoreData)]) {
//        [self.delegate loadMoreData];
//    }
}

@end
