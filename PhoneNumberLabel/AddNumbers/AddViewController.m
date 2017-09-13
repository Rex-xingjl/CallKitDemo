//
//  AddViewController.m
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "AddViewController.h"
#import "AddViewController+Touch.h"
#import "AddViewController+Delegate.h"

@interface AddViewController ()

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.inputTFArray enumerateObjectsUsingBlock:^(UITextField * textfield, NSUInteger idx, BOOL * _Nonnull stop) {
        textfield.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
        textfield.leftViewMode = UITextFieldViewModeAlways;
    }];
}


@end
