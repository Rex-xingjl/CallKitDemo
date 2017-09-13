//
//  ContactCell.h
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *IDLabel;

@end
