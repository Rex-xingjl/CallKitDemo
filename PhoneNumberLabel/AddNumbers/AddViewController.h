//
//  AddViewController.h
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nationalIDTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UITextField *tagMarkTF;
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *inputTFArray;

@property (weak, nonatomic) IBOutlet UISwitch *blockSwitch;


@end
