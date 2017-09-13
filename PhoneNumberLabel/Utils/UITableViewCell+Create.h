//
//  UITableViewCell+Create.h
//  JJSOA
//
//  Created by RuanSTao on 16/7/15.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Create)

+ (instancetype)cellForTableView:(UITableView *)tableView;

+ (instancetype)cellForTableViewWithoutNib:(UITableView *)tableView;

@end
