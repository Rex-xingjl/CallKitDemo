//
//  ContactViewController.m
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/8/2.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "ContactViewController.h"
#import "ContactCell.h"

@interface ContactViewController ()

@property (nonatomic, strong) NSMutableArray * contacts;

@end

@implementation ContactViewController

- (NSMutableArray *)contacts {
    if (!_contacts) {
        NSArray * allIDNumbers = [[FMDataBaseManager shareInstance] getAllContacts:kNumberTable];
        self.contacts = [NSMutableArray arrayWithArray:allIDNumbers];
    }
    return _contacts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.contacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ContactCell * cell = [ContactCell cellForTableView:tableView];
    ContactModel * model = self.contacts[indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    cell.IDLabel.text = model.identification;
    cell.phoneNumberLabel.text = model.phoneNumber;
    cell.backgroundColor = indexPath.row % 2 ? HexRGB(0xf3f3f5) : HexRGB(0xffffff);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ContactModel * model = self.contacts[indexPath.row];
        [[CallBlockOrIDManager shared] removeIdentificationForNumber:model.phoneNumber complete:^(BOOL finish) {
            if (finish) {
                [self.contacts removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
            } else {
                [SVProgressHUD showInfoWithStatus:@"Please try again"];
            }
        }];
    }
}

@end
