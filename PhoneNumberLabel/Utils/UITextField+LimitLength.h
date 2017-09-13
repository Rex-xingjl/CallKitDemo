//
//  UITextField+LimitLength.h
//  JJSOA
//
//  Created by Koson on 15-2-9.
//  Copyright (c) 2015年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (LimitLength)

- (void)limitTextLength:(int)length;

/**
 *  UITextField 抖动效果
 */
- (void)shake;

@end
