//
//  UITableViewCell+Create.m
//  JJSOA
//
//  Created by RuanSTao on 16/7/15.
//  Copyright © 2016年 JJSHome. All rights reserved.
//

#import "UITableViewCell+Create.h"
#import <objc/runtime.h>
@implementation UITableViewCell (Create)

+ (instancetype)cellForTableView:(UITableView *)tableView{

    NSString *identify = NSStringFromClass(self.class);
    id  cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        [tableView registerNib:[UINib nibWithNibName:identify bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identify];
        cell = [tableView dequeueReusableCellWithIdentifier:identify];
    }
    return cell;
}

+ (instancetype)cellForTableViewWithoutNib:(UITableView *)tableView {
    NSString *identify = NSStringFromClass(self.class);
    id cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (nil == cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}

@end
