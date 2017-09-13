//
//  UIView+IBExtension.h
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "UIView+IBExtension.h"
#import <objc/runtime.h>

@implementation UIView (IBExtension)

- (void)setBorderWidth:(CGFloat)borderWidth {
    if(borderWidth <0) return;
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius >0;
}

@end
