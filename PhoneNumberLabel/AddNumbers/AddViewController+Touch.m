//
//  AddViewController+Touch.m
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "AddViewController+Touch.h"
#import <CallKit/CallKit.h>
#import "FMDataBaseManager.h"
#import "CallBlockOrIDManager.h"

#import "ContactViewController.h"
#import "BlockContactController.h"

#define kStoryboard(viewController) [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:viewController];

@implementation AddViewController (Touch)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)bgViewTapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (IBAction)blockSwitchAction:(UISwitch *)sender {
    
}

- (IBAction)eliminateBtnAction:(UIButton *)sender {
    if (self.phoneNumberTF.text.length <= 0 &&
        self.tagMarkTF.text.length <= 0) {
        return;
    }
    [UIAlertController showTwoActionAlert:self Title:@"Empty the input?" Message:@"" leftTitle:@"Cancel" rightTitle:@"OK" EnsureBlock:^{
        self.phoneNumberTF.text = @"";
        self.tagMarkTF.text = @"";
        self.blockSwitch.on = NO;
    }];
}

- (IBAction)addBtnAction:(UIButton *)sender {
    [self.view endEditing:YES];
    
    if (self.phoneNumberTF.text.length <= 0 ||
        self.nationalIDTF.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"One of number is empty"];
        return;
    }
    if (self.blockSwitch.on == NO &&
        self.tagMarkTF.text.length <= 0) {
        [SVProgressHUD showInfoWithStatus:@"Identification is empty"];
        return;
    }

    NSString * phoneNumber = [NSString stringWithFormat:@"%@%@", self.nationalIDTF.text, self.phoneNumberTF.text];
    
    if (self.tagMarkTF.text.length <= 0) {
        [[CallBlockOrIDManager shared] addBlockNumber:phoneNumber complete:nil];
    } else {
        [[CallBlockOrIDManager shared] addIdentification:self.tagMarkTF.text toNumber:phoneNumber complete:^(BOOL finish) {
            if (finish && self.blockSwitch.on == YES) {
                [[CallBlockOrIDManager shared] addBlockNumber:phoneNumber complete:nil];
            }
        }];
    }
}

- (IBAction)tagMarkContactsBtnAction:(UIButton *)sender {
    ContactViewController * vc = kStoryboard(@"ContactViewController")
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)blockContactsBtnAction:(UIButton *)sender {
    ContactViewController * vc = kStoryboard(@"BlockContactController")
    [self.navigationController pushViewController:vc animated:YES];
}

@end
