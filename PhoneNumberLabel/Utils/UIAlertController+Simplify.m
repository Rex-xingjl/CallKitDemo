//
//  UIAlertController+Simplify.m
//  Projectors
//
//  Created by Rex on 16/5/13.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import "UIAlertController+Simplify.h"

#define kPresentAlertC [target presentViewController:alertC animated:YES completion:nil];

@interface UIAlertController ()

@end

@implementation UIAlertController (Simplify)

+ (void)showOneActionAlert:(id)target Title:(NSString *)title Message:(NSString *)message ActionTitle:(NSString *)actionTitle EnsureBlock:(EnsureBlock)ensureBlock
{
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title ? : @""
                                                                     message:message  ? : @""
                                                              preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:actionTitle ? : @"确定"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * _Nonnull action) {
                                                 if (ensureBlock) {
                                                     ensureBlock();
                                                 }
                                             }]];
    kPresentAlertC
}

+ (void)showTwoActionAlert:(id)target Title:(NSString *)title Message:(NSString *)message leftTitle:(NSString *)left rightTitle:(NSString *)right EnsureBlock:(EnsureBlock)ensureBlock
{

    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title ? : @""
                                                                     message:message ? : @""
                                                               preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:left ? : @"取消"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * _Nonnull action) {
                                                 
                                             }]];
    [alertC addAction:[UIAlertAction actionWithTitle:right ? : @"确定"
                                                style:UIAlertActionStyleDestructive
                                              handler:^(UIAlertAction * _Nonnull action) {
                                                  if (ensureBlock) {
                                                      ensureBlock();
                                                  }
                                              }]];
    kPresentAlertC
//    [target presentViewController:alertC animated:YES completion:nil];
}

+ (void)showTwoActionAlert:(id)target Title:(NSString *)title Message:(NSString *)message leftTitle:(NSString *)left rightTitle:(NSString *)right EnsureBlock:(EnsureBlock)ensureBlock CancelBlock:(CancelBlock)cancelBlock
{
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title ? : @""
                                                                     message:message ? : @""
                                                              preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:left ? : @"取消"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction * _Nonnull action) {
                                                 if (cancelBlock) {
                                                     cancelBlock();
                                                 }
                                             }]];
    [alertC addAction:[UIAlertAction actionWithTitle:right ? : @"确定"
                                               style:UIAlertActionStyleDestructive
                                             handler:^(UIAlertAction * _Nonnull action) {
                                                 if (ensureBlock) {
                                                     ensureBlock();
                                                 }
                                             }]];
    kPresentAlertC
}

+ (void)showTextAlert:(id)target
            Title:(NSString *)title
          Message:(NSString *)message
      EnsureBlock:(TextEnsureBlock)ensureBlock
//                     CancelBlock:(CancelBlock)cancelBlock
{
    __block UITextField * tf;
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title  ? : @""
                                                                      message:message  ? : @""
                                                               preferredStyle:UIAlertControllerStyleAlert];
    [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        tf = textField;
    }];
    [alertC addAction:[UIAlertAction actionWithTitle:@"确定"
                                                style:UIAlertActionStyleDestructive
                                              handler:^(UIAlertAction * _Nonnull action) {
                                                  if (ensureBlock) {
                                                      ensureBlock(tf.text);
                                                  }
                                              }]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消"
                                                style:UIAlertActionStyleCancel
                                              handler:^(UIAlertAction * _Nonnull action) {
                                                  
                                                  
                                              }]];
   kPresentAlertC
}

+ (void)showAlert:(id)target withTitle:(NSString *)title
     leftBtnTitle:(NSString *)leftTitle leftAction:(SEL)leftSel
    rightBtnTitle:(NSString *)rightTitle rightAction:(SEL)rightSel {
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleAlert];
    [alertC addAction:[UIAlertAction actionWithTitle:leftTitle
                                                style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * _Nonnull action) {
                                                  if (leftSel) {
                                                      ((void (*)(id, SEL))[target methodForSelector:leftSel])(target, leftSel);
                                                  }}]];
    [alertC addAction:[UIAlertAction actionWithTitle:rightTitle
                                                style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * _Nonnull action) {
                                                  if (rightSel) {
                                                      ((void (*)(id, SEL))[target methodForSelector:rightSel])(target, rightSel);
                                                  }}]];
    kPresentAlertC
}

+ (void)showSheet:(id)target title:(NSString *)title message:(NSString *)message
     actionTitles:(NSArray *)titleArray
     actionBlocks:(ActionSheetBlock)actionSheetBlock {
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:title
                                                                           message:message
                                                                    preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i < titleArray.count; i ++) {
        [alertC addAction:[UIAlertAction actionWithTitle:titleArray[i]
                                                         style:UIAlertActionStyleDestructive
                                                       handler:^(UIAlertAction * _Nonnull action) {
                                                           if (actionSheetBlock) {
                                                               actionSheetBlock(action);
                                                           }
                                                       }]];
    }
    
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    kPresentAlertC
}

+ (void)showImagePikerActionSheet:(id)target
                         cameraSEL:(SEL)cameraSel
                         photoSEL:(SEL)photoSel {
    
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"选择头像"
                                                                      message:nil
                                                               preferredStyle:UIAlertControllerStyleActionSheet];
    [alertC addAction:[UIAlertAction actionWithTitle:@"拍照"
                                                style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * _Nonnull action) {
                                                  if (cameraSel) {
                                                      ((void (*)(id, SEL))[target methodForSelector:cameraSel])(target, cameraSel);
                                                  }}]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"本地相册"
                                                style:UIAlertActionStyleDefault
                                              handler:^(UIAlertAction * _Nonnull action) {
                                                  if (photoSel) {
                                                      ((void (*)(id, SEL))[target methodForSelector:photoSel])(target, photoSel);
                                                  }}]];
    [alertC addAction:[UIAlertAction actionWithTitle:@"取消"
                                                style:UIAlertActionStyleCancel
                                              handler:nil]];
    
    kPresentAlertC
}


@end
