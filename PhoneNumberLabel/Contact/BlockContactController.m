//
//  BlockContactController.m
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/9/13.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "BlockContactController.h"
#import "BlockContactCell.h"

@interface BlockContactController ()

@property (nonatomic, strong) NSMutableArray * blockContacts;

@end

@implementation BlockContactController

- (NSMutableArray *)blockContacts {
    if (!_blockContacts) {
        NSArray * allIDNumbers = [[FMDataBaseManager shareInstance] getAllContacts:kBlockNumberTable];
        self.blockContacts = [NSMutableArray arrayWithArray:allIDNumbers];
    }
    return _blockContacts;
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
    
    return self.blockContacts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BlockContactCell * cell = [BlockContactCell cellForTableView:tableView];
    ContactModel * model = self.blockContacts[indexPath.row];
    cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
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
        ContactModel * model = self.blockContacts[indexPath.row];
        [[CallBlockOrIDManager shared] removeBlockNumber:model.phoneNumber complete:^(BOOL finish) {
            if (finish) {
                [self.blockContacts removeObjectAtIndex:indexPath.row];
                [self.tableView reloadData];
            } else {
                [SVProgressHUD showInfoWithStatus:@"Please try again"];
            }
        }];
    }
}

@end
