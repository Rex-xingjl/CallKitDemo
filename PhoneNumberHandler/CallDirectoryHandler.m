//
//  CallDirectoryHandler.m
//  PhoneNumberHandler
//
//  Created by Rex@JJS on 2017/9/8.
//  Copyright © 2017年 Rex. All rights reserved.
//

#import "CallDirectoryHandler.h"
#import "FMDataBaseManager.h"

@interface CallDirectoryHandler () <CXCallDirectoryExtensionContextDelegate>
@end

@implementation CallDirectoryHandler

- (void)beginRequestWithExtensionContext:(CXCallDirectoryExtensionContext *)context {
    context.delegate = self;

    if (![self addBlockingPhoneNumbersToContext:context]) {
        NSLog(@"Unable to add blocking phone numbers");
        NSError *error = [NSError errorWithDomain:@"CallDirectoryHandler" code:1 userInfo:nil];
        [context cancelRequestWithError:error];
        return;
    }
    
    if (![self addIdentificationPhoneNumbersToContext:context]) {
        NSLog(@"Unable to add identification phone numbers");
        NSError *error = [NSError errorWithDomain:@"CallDirectoryHandler" code:2 userInfo:nil];
        [context cancelRequestWithError:error];
        return;
    }
    
    [context completeRequestWithCompletionHandler:nil];
}

- (BOOL)addBlockingPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    NSArray * contacts = [[FMDataBaseManager shareInstance] getAllContacts:kBlockNumberTable];
    for (int i= 0; i < contacts.count; i ++) {
        @autoreleasepool {
            ContactModel * contact = contacts[i];
            if (contact.phoneNumber) {
                CXCallDirectoryPhoneNumber phoneNumber = [contact.phoneNumber longLongValue];
                [context addBlockingEntryWithNextSequentialPhoneNumber:phoneNumber];
            }
            contact = nil;
        }
    }
    return YES;
}

- (BOOL)addIdentificationPhoneNumbersToContext:(CXCallDirectoryExtensionContext *)context {
    NSArray * contacts = [[FMDataBaseManager shareInstance] getAllContacts:kNumberTable];
    for (int i= 0; i < contacts.count; i ++) {
        @autoreleasepool {
            ContactModel * contact = contacts[i];
            if (contact.phoneNumber && contact.identification) {
                CXCallDirectoryPhoneNumber phoneNumber = [contact.phoneNumber longLongValue];
                NSString * label = contact.identification;
                [context addIdentificationEntryWithNextSequentialPhoneNumber:phoneNumber label:label];
            }
            contact = nil;
        }
    }
    return YES;
}

#pragma mark - CXCallDirectoryExtensionContextDelegate

- (void)requestFailedForExtensionContext:(CXCallDirectoryExtensionContext *)extensionContext withError:(NSError *)error {
    // An error occurred while adding blocking or identification entries, check the NSError for details.
    // For Call Directory error codes, see the CXErrorCodeCallDirectoryManagerError enum in <CallKit/CXError.h>.
    //
    // This may be used to store the error details in a location accessible by the extension's containing app, so that the
    // app may be notified about errors which occured while loading data even if the request to load data was initiated by
    // the user in Settings instead of via the app itself.
}

@end
