//
//  DrawingboardScoll.m
//  yfd
//
//  Created by 1696477589@qq.com on 2017/5/11.
//  Copyright © 2017年 yj.com. All rights reserved.
//

#import "DrawingboardScoll.h"

@interface DrawingboardScoll ()<UIGestureRecognizerDelegate>

@end
@implementation DrawingboardScoll

//- (instancetype) init{
//    if ([super init]) {
//        UITapGestureRecognizer *tapSingle = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickTap:)];
//        tapSingle.numberOfTapsRequired = 1;
//        tapSingle.numberOfTouchesRequired = 1;
//        tapSingle.delegate = self;
//        [self addGestureRecognizer:tapSingle];
//    }
//    return self;
//}
//
//- (void) clickTap:(UITapGestureRecognizer *)seder{
//    NSLog(@"--------%s",__func__);
//}
//
//- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    NSLog(@"--------%s  touch:%d",__func__,gestureRecognizer.numberOfTouches);
//
//    if (gestureRecognizer.numberOfTouches>1) {
//        return YES;
//    }
//    return NO;
//}
#pragma mark - UIResponder
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    
    //    [[self nextResponder] touchesBegan:touches withEvent:event];
    
    [super touchesBegan:touches withEvent:event];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    
    //    [[self nextResponder]touchesMoved:touches withEvent:event];
    
    [super touchesMoved:touches withEvent:event];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    
    //    [[self nextResponder]touchesEnded:touches withEvent:event];
    
    [super touchesEnded:touches withEvent:event];
}


#pragma mark - UISrollView
/* 如果触摸已经被传递到滚动视图的子视图，则在滚动之前调用。 如果返回否，触摸将继续传递到子视图，滚动将不会发生
 如果canCancelContentTouches为NO，则不调用。 如果视图不是UIControl，则返回YES
 */
//- (BOOL) touchesShouldCancelInContentView:(UIView *)view{
//    NSLog(@"%s",__func__);
//
//    if (self.scrollEnabled) {
//
//        return NO;
//    }
//
//    return YES;
//}

/* default YES 覆盖子类的点，控制触摸事件是否传递到滚动视图的子视图*/
- (BOOL) touchesShouldBegin:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view{
    
    UITouch *anyTouch = touches.anyObject;
    NSLog(@"%s tap:%d touchs:%d event:%d",__func__,anyTouch.tapCount,touches.count,event.allTouches.count);
    
    if (event.allTouches.count==1) {
        
        self.scrollEnabled = NO;
        return YES;
    }
    
    self.scrollEnabled = YES;
    return NO;
}

#pragma mark - UIView

- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%s----------------------> event:%d",__func__,event.allTouches.count);
    
    UIView *view = [super hitTest:point withEvent:event];
    return view;
    
    //    if (event.allTouches.count==1) {
    //
    //    } else {
    //        return nil;
    //    }
}

@end
