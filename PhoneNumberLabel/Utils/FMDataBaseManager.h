

#import <Foundation/Foundation.h>
#import "ContactModel.h"

#define kNumberTable @"PHONENUMBERTABLE"
#define kBlockNumberTable @"BLOCKNUMBERTABLE"

@interface FMDataBaseManager : NSObject

+ (FMDataBaseManager *)shareInstance;

- (void)closeDBForDisconnect;

- (void)updateContact:(ContactModel *)contact toTable:(NSString *)table;

- (void)removeContact:(ContactModel *)contact inTable:(NSString *)table;

- (NSArray *)getAllContacts:(NSString *)table;

@end
