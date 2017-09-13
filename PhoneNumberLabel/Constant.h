//
//  Constant.h
//  JJSProject
//
//  Created by YD-Guozuhong on 16/5/4.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#ifndef Constant_h
#define Constant_h

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SAVE_OBJECT(object,key) {[[NSUserDefaults standardUserDefaults] setObject:object forKey:key] ; [[NSUserDefaults standardUserDefaults]synchronize];}
#define EXRACT_OBJECT(key)        [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define REMOVE_OBJECT(key)   [[NSUserDefaults standardUserDefaults]removeObjectForKey:key]

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...) {}
#endif

#endif
