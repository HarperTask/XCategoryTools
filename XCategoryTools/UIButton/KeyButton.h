//
//  KeyButton.h
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KeyButtonDelegate <NSObject>

@optional
/** 键盘出现 */
- (void)showkeyButton:(CGFloat)keyHeight;

/** 键盘消失 */
- (void)dismissKeyButton;

@end

@interface KeyButton : UIButton

@property (nonatomic, weak) id <KeyButtonDelegate> delegate;

@property (nonatomic, assign) CGRect tempFrame;

@end
