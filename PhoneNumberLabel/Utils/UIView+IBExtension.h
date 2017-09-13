//
//  UIView+IBExtension.h
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (YSView)

@property (nonatomic, strong) IBInspectable UIColor * borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;

@end
