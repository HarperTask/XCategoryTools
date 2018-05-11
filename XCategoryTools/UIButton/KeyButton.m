//
//  KeyButton.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "KeyButton.h"



@implementation KeyButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
//        self.tempFrame = CGRectMake(SCREEN_WIDTH-48, SCREEN_HEIGHT , 48.0f, 30.0f);
//        [self setFrame:self.tempFrame];
//        [self setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
//        [self addTarget:self action:@selector(cancelBackKeyboard:) forControlEvents:UIControlEventTouchDown];
//        
//        // 增加监听，当键盘出现时或改变时
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
//        
//        // 增加监听，当键盘退出时
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.tempFrame = frame;
        self.hidden = YES;
        [self setImage:[UIImage imageNamed:@"keyboard"] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(cancelBackKeyboard:) forControlEvents:UIControlEventTouchDown];
        
        // 增加监听，当键盘出现时或改变时
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardWillShowNotification object:nil];
        
        // 增加监听，当键盘退出时
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    }
    
    return self;
}

// 键盘出现
- (void)handleKeyboardDidShow:(NSNotification *)notification {
    self.hidden = NO;
    // 获取键盘信息
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size;
    
    // 键盘出现动画
    NSValue *animationDurValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    //    copy value
    [animationDurValue getValue:&animationDuration];
    
    //    让键盘弹起的时候添加一个动画
    [UIView beginAnimations:@"animal" context:nil];
    [UIView setAnimationDuration:animationDuration];
    

    
    // 动态调整键盘高度
    [self showBackKeyBordHeight:kbSize.height];
    [UIView commitAnimations];
    
//    self.hidden = NO;
    
//    [self addTarget:self action:@selector(cancelBackKeyboard:) forControlEvents:UIControlEventTouchDown];
    
}

// 键盘消失
- (void)handleKeyboardWillHide:(NSNotification *)notification {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.hidden = YES;
    NSDictionary *info = [notification userInfo];
    CGRect keyboardFrame;
    [[info objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    NSValue *animationDurValue = [info objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    NSTimeInterval animationDuration;
    //   把animationDurvalue 值拷贝到animationDuration中
    [animationDurValue getValue:&animationDuration];
    
    [UIView beginAnimations:@"animal" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    if (self) {
        
        CGRect exitBtFrame = CGRectMake(FUNC_X(self), self.tempFrame.origin.y, FUNC_W(self), FUNC_H(self));
        self.frame = exitBtFrame;
        
    }
    [UIView commitAnimations];
    
}

// 键盘出现时调整按钮坐标
- (void)showBackKeyBordHeight:(CGFloat)height {
    
    self.frame = CGRectMake(FUNC_X(self), self.tempFrame.origin.y - height - 30, FUNC_W(self), FUNC_H(self));
    
    if ([self.delegate respondsToSelector:@selector(showkeyButton:)]) {
        [self.delegate showkeyButton:height];
    }
 
}

// 键盘消失时调整按钮坐标(代理实现)
- (void)cancelBackKeyboard:(id)sender {
    if ([self.delegate respondsToSelector:@selector(dismissKeyButton)]) {
        [self.delegate dismissKeyButton];
    }
}

// 未知作用
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// 注销通知
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
