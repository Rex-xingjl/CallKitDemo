//
//  CallBlockOrIDManager.m
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/9/11.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "CallBlockOrIDManager.h"
#import "ContactModel.h"

#define kExtensionIdentifier @"com.Rex.NumberLabel.PhoneNumberHandler"
#define kViewController [UIApplication sharedApplication].keyWindow.rootViewController

typedef enum : NSUInteger {
    IDNumberManageAdd = 0,
    IDNumberManageDelete,
    BlockNumberManageAdd,
    BlockNumberManageDelete,
} NumberManage;

@implementation CallBlockOrIDManager

+ (CallBlockOrIDManager *)shared {
    static CallBlockOrIDManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)addIdentification:(NSString *)ID toNumber:(NSString *)number complete:(void(^)(BOOL finish))block {
    [self getPM_manage:IDNumberManageAdd number:number Id:ID complete:block];
}

- (void)removeIdentificationForNumber:(NSString *)number complete:(void(^)(BOOL finish))block {
    [self getPM_manage:IDNumberManageDelete number:number Id:@"" complete:block];
}

- (void)addBlockNumber:(NSString *)number complete:(void(^)(BOOL finish))block {
    [self getPM_manage:BlockNumberManageAdd number:number Id:@"" complete:block];
}

- (void)removeBlockNumber:(NSString *)number complete:(void(^)(BOOL finish))block {
    [self getPM_manage:BlockNumberManageDelete number:number Id:@"" complete:block];
}

- (void)getPM_manage:(NumberManage)mange number:(NSString *)number Id:(NSString *)Id complete:(void(^)(BOOL finish))block {
    [self permissionStatusConfirm:^(bool allow) {
        if (allow) {
            [self manage:mange toNumber:number withID:Id complete:block];
        } else {
            if (block) block(NO);
        }
    }];
}

- (void)manage:(NumberManage)manage toNumber:(NSString *)number withID:(NSString *)ID complete:(void(^)(BOOL finish))block{
    NSTimeInterval interval_begin = [[NSDate date] timeIntervalSince1970];
    [SVProgressHUD showWithStatus:@"Updating..."];
    ContactModel * model = [[ContactModel alloc] init];
    model.phoneNumber = number;
    model.identification = ID;

    switch (manage) {
        case IDNumberManageAdd:
            [[FMDataBaseManager shareInstance] updateContact:model toTable:kNumberTable]; break;
        case IDNumberManageDelete:
            [[FMDataBaseManager shareInstance] removeContact:model inTable:kNumberTable]; break;
        case BlockNumberManageAdd:
            [[FMDataBaseManager shareInstance] updateContact:model toTable:kBlockNumberTable]; break;
        case BlockNumberManageDelete:
            [[FMDataBaseManager shareInstance] removeContact:model inTable:kBlockNumberTable]; break;
        default: break;
    }

    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    [manager reloadExtensionWithIdentifier:kExtensionIdentifier completionHandler:^(NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        NSTimeInterval interval_end = [[NSDate date] timeIntervalSince1970];
        NSString * check = @"please try again or check the perrmission";
        NSString * time = [NSString stringWithFormat:@"spend time: %.1f s", interval_end-interval_begin];
        NSString * title = !error ? @"Update Succeed ✓" : @"Update Failed X";
        NSString * message = (manage == IDNumberManageAdd || manage == IDNumberManageDelete) ?
        [NSString stringWithFormat:@"> %@ <\n%@", @"ID Contacts", time] :
        [NSString stringWithFormat:@"> %@ <\n%@", @"Block Contacts", time];
        [UIAlertController showOneActionAlert:kViewController
                                        Title: title
                                      Message: error ? check : message
                                  ActionTitle:@"OK"
                                  EnsureBlock:^{
                                      if (!error && block) {
                                          block(YES);
                                      } else {
                                          if (block) block(NO);
                                      }
                                  }];
    }];
}

- (void)permissionStatusConfirm:(void(^)(bool allow)) block {
    CXCallDirectoryManager *manager = [CXCallDirectoryManager sharedInstance];
    [manager getEnabledStatusForExtensionWithIdentifier:kExtensionIdentifier completionHandler:^(CXCallDirectoryEnabledStatus enabledStatus, NSError * _Nullable error) {
        if (!error) {
            switch (enabledStatus) {
                case CXCallDirectoryEnabledStatusEnabled:
                    if (block) block(YES); break;
                case CXCallDirectoryEnabledStatusUnknown:
                    [SVProgressHUD showInfoWithStatus:@"Unknown permission, please reinstall the app"]; break;
                case CXCallDirectoryEnabledStatusDisabled:
                    [self openSetting]; break;
                default: break;
            }
        } else {
            [UIAlertController showOneActionAlert:kViewController
                                            Title:@"Get Permisstion Error"
                                          Message:@""
                                      ActionTitle:@"OK"
                                      EnsureBlock:nil];
        }
        if (block) block(NO);
    }];
}

- (void)openSetting {
    [UIAlertController showTwoActionAlert:kViewController Title:@"Permission" Message:@"Need Permisstion, please open it:\nSetting->Phone->Call Blocking & Indentification" leftTitle:@"Cancel" rightTitle:@"To Open" EnsureBlock:^{
        NSURL *url = [NSURL URLWithString:@"app-Prefs:root=Phone"];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    } CancelBlock:^{
        [SVProgressHUD showInfoWithStatus:@"You can't use the function without permission"];
    }];
}

@end
