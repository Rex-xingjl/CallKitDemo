 //
//  UIAlertController+Simplify.h
//  Projectors
//
//  Created by Rex on 16/5/13.
//  Copyright © 2016年 Rex. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EnsureBlock)();
typedef void(^CancelBlock)();

typedef void(^TextEnsureBlock)(NSString * text) ;

typedef void(^ActionSheetBlock)(UIAlertAction * action);

@interface UIAlertController (Simplify)

/**
 *  显示 一个按钮的 AlertView界面
 *  @param target     显示的控制器    @param title   提示框的标题
 *  @param actionTitle     按钮标题
 *  @param ensureBlock    按钮回调block
 */

+ (void)showOneActionAlert:(id)target
                     Title:(NSString *)title
                   Message:(NSString *)message
               ActionTitle:(NSString *)actionTitle
               EnsureBlock:(EnsureBlock)ensureBlock;

/**
 *  显示 两个按钮的 AlertView界面 （不带取消按钮事件）
 *  @param target     显示的控制器    @param title   提示框的标题
 *  @param ensureBlock    右侧按钮回调block
 */
+ (void)showTwoActionAlert:(id)target
                     Title:(NSString *)title
                   Message:(NSString *)message
                 leftTitle:(NSString *)left
                rightTitle:(NSString *)right
               EnsureBlock:(EnsureBlock)ensureBlock;
/**
 *  显示 两个按钮的 AlertView界面 （带取消按钮事件）
 *  @param target     显示的控制器    @param title   提示框的标题
 *  @param cancelBlock    左侧按钮回调block
 *  @param ensureBlock    右侧按钮回调block
 */
+ (void)showTwoActionAlert:(id)target
                     Title:(NSString *)title
                   Message:(NSString *)message
                 leftTitle:(NSString *)left
                rightTitle:(NSString *)right
               EnsureBlock:(EnsureBlock)ensureBlock
               CancelBlock:(CancelBlock)cancelBlock;

/**
 *  显示 带输入框的 <确定/取消> AlertView界面
 *  @param target     显示的控制器    @param title   提示框的标题
 *  @param ensureBlock    右侧按钮回调block
 */
+ (void)showTextAlert:(id)target
                Title:(NSString *)title
              Message:(NSString *)message
          EnsureBlock:(TextEnsureBlock)ensureBlock;

/**
 *  显示AlertView界面
 *  @param target     显示的控制器    @param title   提示框的标题
 *  @param leftTitle  左侧按钮标题    @param leftSel  左侧按钮方法
 *  @param rightTitle 右侧按钮标题    @param rightSel 右侧按钮方法
 */
+ (void)showAlert:(id)target withTitle:(NSString *)title
     leftBtnTitle:(NSString *)leftTitle leftAction:(SEL)leftSel
    rightBtnTitle:(NSString *)rightTitle rightAction:(SEL)rightSel;

/**
 *  显示ActionSheet界面
 *  @param target    显示的控制器
 *  @param title     sheet的标题  @param message  sheet的消息
 *  @param titleArray 标题数量
 *  @param actionSheetBlock 回调的block
 */
+ (void)showSheet:(id)target title:(NSString *)title message:(NSString *)message
     actionTitles:(NSArray *)titleArray
     actionBlocks:(ActionSheetBlock)actionSheetBlock;

/**
 *  显示头像选择ActionSheet界面
 *  @param target     显示的控制器
 *  @param cameraSel   第一个按钮按钮方法
 *  @param photoSel  第二个按钮点击方法
 */

+ (void)showImagePikerActionSheet:(id)target
                         cameraSEL:(SEL)cameraSel
                         photoSEL:(SEL)photoSel;
//+ (void)showImagePikerActionSheet:(id)target;

@end
