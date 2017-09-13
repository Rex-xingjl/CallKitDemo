//
//  CallBlockOrIDManager.h
//  PhoneNumberLabel
//
//  Created by Rex@JJS on 2017/9/11.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CallBlockOrIDManager : NSObject

+ (instancetype)shared;

- (void)addIdentification:(NSString *)ID toNumber:(NSString *)number complete:(void(^)(BOOL finish))block;

- (void)removeIdentificationForNumber:(NSString *)number complete:(void(^)(BOOL finish))block;

- (void)addBlockNumber:(NSString *)number complete:(void(^)(BOOL finish))block;

- (void)removeBlockNumber:(NSString *)nubmer complete:(void(^)(BOOL finish))block;

@end
