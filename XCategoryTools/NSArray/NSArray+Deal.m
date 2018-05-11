//
//  NSArray+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "NSArray+Deal.h"

@implementation NSArray (Deal)

/** 判断是否是空数组 */
- (BOOL)isNullArray {
    
    if (self == nil) {
        
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    
    if (self.count == 0) {
        
        return YES;
    }
    
    return NO;
}

/** 删除重复数据 */
- (id)arrayWithMemberIsOnly {
    NSMutableArray *categoryArray =  [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < [self count]; i++) {
        @autoreleasepool {
            if ([categoryArray containsObject:[self objectAtIndex:i]] == NO) {
                [categoryArray addObject:[self objectAtIndex:i]];
            }
        }
    }
    return categoryArray;
    
}

/** 数组计算交集 */
- (id)arrayForIntersectionWithOtherArray:(NSArray *)otherArray {
    NSMutableArray *intersectionArray = [NSMutableArray array];
    if (self.count == 0) return nil;
    if (!otherArray) return nil;
    // 遍历
    for (id obj in self) {
        if (![otherArray containsObject:obj]) continue;
        // 添加
        [intersectionArray addObject:obj];
    }
    
    return intersectionArray;
    
}

/** 数组计算差集 */
- (id)arrayForMinusWithOtherArray:(NSArray *)otherArray {
    if (!self) return nil;
    if (!otherArray) return self;
    NSMutableArray *minusArray = [NSMutableArray arrayWithArray:self];
    // 遍历
    for (id obj in otherArray) {
        if (![self containsObject:obj]) continue;
        // 移除
        [minusArray removeObject:obj];
    }
    
    return minusArray;
    
}

/** 条件排序 多条件排序时，下标小的优先级高 */
- (id)arraySortedWithKeyArray:(NSArray *)keyArray {
    NSMutableArray *tempMArray = [[NSMutableArray alloc]init];
    
    for (NSString *key in keyArray) {
        // 默认升序
        NSSortDescriptor *keySD = [NSSortDescriptor sortDescriptorWithKey:key ascending:YES];
        
        [tempMArray addObject:keySD];
    }
    
    return [self sortedArrayUsingDescriptors:tempMArray];
    
}

@end
