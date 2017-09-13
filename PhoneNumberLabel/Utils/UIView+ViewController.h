//
//  UIView+ViewController.h
//  DoubleJinGe
//
//  Created by Rex on 16/5/21.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ViewController)

@property (nonatomic, strong) UIViewController * ViewController;
/**
 *  获得一个视图所在的控制器
 */
- (UIViewController *)belongsToViewController;

@end

@interface UIView (SuperViewController)



@end