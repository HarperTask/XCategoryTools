//
//  UIScrollView+Deal.m
//  工具类
//
//  Created by Harper on 16/5/3.
//  Copyright © 2016年 X-Station. All rights reserved.
//

#import "UIScrollView+Deal.h"

@implementation UIScrollView (Deal)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //if(!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //if(!self.dragging)
    {
        [[self nextResponder] touchesMoved:touches withEvent:event];
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //if(!self.dragging)
    {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}

/** 是否滑到顶部 */
- (BOOL)isEndToTop {
    CGFloat contentOffsetY = self.contentOffset.y;
 
    if (contentOffsetY == 0) {
        
        return YES;
    }
    else {
        
        return NO;
    }
}

/** 是否滑到底部 */
- (BOOL)isEndToBottom {
    CGFloat height = self.frame.size.height;
    CGFloat contentOffsetY = self.contentOffset.y;
    CGFloat bottomOffset = self.contentSize.height - contentOffsetY;
    
    if (bottomOffset <= height) {
        
        return YES;
    }
    else {
        
        return NO;
    }
}

/** 截长图 */
- (id)saveLongImage {
    
    UIImage *image = nil;
    
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，调整清晰度。
    UIGraphicsBeginImageContextWithOptions(self.contentSize, YES, [UIScreen mainScreen].scale);
    
    CGPoint savedContentOffset = self.contentOffset;
    
    CGRect savedFrame = self.frame;
    
    self.contentOffset = CGPointZero;
    
    self.frame = CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
    
    [self.layer renderInContext: UIGraphicsGetCurrentContext()];
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    self.contentOffset = savedContentOffset;
    
    self.frame = savedFrame;
    
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        //保存图片到相册
        //        UIImageWriteToSavedPhotosAlbum(image, self, NULL, NULL);
    }
    
    return image;
    
//    CGPoint savedContentOffset = scrollView.contentOffset;
//    CGRect savedFrame = scrollView.frame;
//
//    scrollView.frame = CGRectMake(0, scrollView.frame.origin.y, scrollView.contentSize.width, scrollView.contentSize.height);
//    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, YES, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
//    [scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
//
//    scrollView.contentOffset = savedContentOffset;
//    scrollView.frame = savedFrame;
//
//    UIGraphicsEndImageContext();
//
//    if (image != nil) {
//        //保存图片到相册
////        UIImageWriteToSavedPhotosAlbum(image, self, NULL, NULL);
//    }
//    return image;

}
@end
