//
//  AddViewController+Delegate.m
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "AddViewController+Delegate.h"
#import "UITextField+LimitLength.h"

@implementation AddViewController (Delegate)

#pragma mark - UITextFieldDelegate -

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.layer.borderColor = textField.textColor.CGColor;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text length] <= 0) {
        [SVProgressHUD showInfoWithStatus:@"Empty"];
    }
    [self.view endEditing:YES];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    textField.layer.borderColor = HexRGB(0xf3f3f5).CGColor;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString * mutableStr = [NSMutableString stringWithString:textField.text];
    [mutableStr replaceCharactersInRange:range withString:string];
    if (textField == self.phoneNumberTF) {
        [textField limitTextLength:17];
    }
    if (textField == self.tagMarkTF) {
        [textField limitTextLength:50];
    }
    return YES;
}

#pragma mark - UIScrollViewDelegate -

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

@end
