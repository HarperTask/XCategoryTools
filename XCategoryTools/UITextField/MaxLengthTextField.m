//
//  MaxLengthTextField.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "MaxLengthTextField.h"

@interface MaxLengthTextField ()

@property (nonatomic, copy) NSString *tempStr;
@property (nonatomic, assign) NSInteger maxLength;
@property (nonatomic, assign) NSInteger maxBytes;

@end

@implementation MaxLengthTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _maxLength = 100000;
        _maxBytes = 0;
        
        // 添加输入框内容监控事件
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }
    
    return self;
}

/**
 设置输入最大长度的内容
 
 @param maxLength 输入最大长度的内容
 */
- (void)setMaxLength:(NSInteger)maxLength {
    _maxLength = maxLength;
    
}


/**
 设置输入最大字节的内容
 
 @param maxBytes 输入最大字节的内容
 */
- (void)setMaxBytes:(NSInteger)maxBytes {
    _maxBytes = maxBytes;
}


// 监控输入框内容
- (void)textFieldDidChange:(UITextField *)textField {
    
    if (_maxBytes == 0) {
        long length = [textField.text length];
        
        if (length > _maxLength) {
            textField.text = [textField.text substringToIndex:_maxLength];
        }
        
    }
    else {
        int bytes = [textField.text stringConvertToInt];
        
        if (bytes <= _maxBytes) {
            _tempStr = textField.text;
        }
        else {
            textField.text = _tempStr;
        }
    }
   

}





@end
