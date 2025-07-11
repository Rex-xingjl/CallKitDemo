

#import "FMDataBaseManager.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface FMDataBaseManager ()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;

@property (nonatomic, strong) FMDatabase *db;

@end

@implementation FMDataBaseManager

+ (FMDataBaseManager *)shareInstance {
  static FMDataBaseManager *instance = nil;
  static dispatch_once_t predicate;
  dispatch_once(&predicate, ^{
    instance = [[[self class] alloc] init];
    [instance dbQueue];
  });
  return instance;
}

- (FMDatabaseQueue *)dbQueue {
  if (!_dbQueue) {
      
      NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:@"group.rex.test"];
      containerURL = [containerURL URLByAppendingPathComponent:@"Library/"];
      NSString * dbPath = [NSString stringWithFormat:@"%@/%@",containerURL.absoluteString, @"LocalNumberDB.sqlite"];
      _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    if (_dbQueue) {
        [self createTableIfNotExists:kNumberTable];
        [self createTableIfNotExists:kBlockNumberTable];
    }
  }
  return _dbQueue;
}

- (void)createTableIfNotExists:(NSString *)table {
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *createTableSQL = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (phoneNumber integer PRIMARY KEY, identification text)", table];
        BOOL finish = [db executeUpdate:createTableSQL];
        NSLog(@"[Table >> %@ << creat %@]", table, finish ? @"Succeed" : @"Failed");
    }];
}

- (void)closeDBForDisconnect; {
  self.dbQueue = nil;
}

- (void)updateContact:(ContactModel *)contact toTable:(NSString *)table {
    NSString *sql = [NSString stringWithFormat:@"REPLACE INTO %@ (phoneNumber, identification) VALUES (?, ?)", table];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql, contact.phoneNumber, contact.identification];
    }];
}

- (void)removeContact:(ContactModel *)contact inTable:(NSString *)table {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE phoneNumber = %@", table, contact.phoneNumber];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:sql];
    }];
}

- (NSArray *)getAllContacts:(NSString *)table {
    NSMutableArray *allUsers = [NSMutableArray new];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY phoneNumber ASC", table];
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            ContactModel *model = [[ContactModel alloc] init];
            model.phoneNumber = [rs stringForColumn:@"phoneNumber"];
            model.identification = [rs stringForColumn:@"identification"];
            [allUsers addObject:model];
        }
        [rs close];
    }];
    return allUsers;
}

@end
