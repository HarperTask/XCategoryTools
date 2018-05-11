//
//  NSArray+Deal.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Deal)

/** 判断是否是空数组 */
- (BOOL)isNullArray;

/** 删除重复数据 */
- (id)arrayWithMemberIsOnly;

/** 数组计算交集 */
- (id)arrayForIntersectionWithOtherArray:(NSArray *)otherArray;

/** 数组计算差集 */
- (id)arrayForMinusWithOtherArray:(NSArray *)otherArray;

/** 条件排序 多条件排序时，下标小的优先级高 */
- (id)arraySortedWithKeyArray:(NSArray *)keyArray;


@end
