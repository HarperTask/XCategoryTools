//
//  KeyTextField.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "KeyTextField.h"

@implementation KeyTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (void)deleteBackward {
    [super deleteBackward];
    if ([self.kdelegate respondsToSelector:@selector(deleteBackward:)]) {
        [self.kdelegate deleteBackward:self];
    }
}

@end
