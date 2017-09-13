//
//  UIView+ViewController.m
//  DoubleJinGe
//
//  Created by Rex on 16/5/21.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "UIView+ViewController.h"
#import <objc/runtime.h>

@implementation UIView (ViewController)

static void * UIViewViewController = (void *)@"UIViewViewController";

- (UIViewController *)ViewController {
    return objc_getAssociatedObject(self, &UIViewViewController);
}

- (void)setViewController:(UIViewController *)ViewController {
     objc_setAssociatedObject(self, UIViewViewController, ViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)belongsToViewController {
    
    for (UIView * next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end

@implementation UIView (SuperViewController)

- (UIViewController *)ViewController {
    
    return [self belongsToViewController];
}

@end
