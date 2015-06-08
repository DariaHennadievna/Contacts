//
//  DataManager.h
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObject+Serialization.h"

// my keys
#define AVATAR_URL @"avatar_url"
#define USER_ID    @"user_id"
#define USER_NAME  @"username"
#define NUMBER_OF_MESSAGES  @"numberOfMessages"
#define MESSAGES   @"messages"
#define CREATED    @"created"
#define TEXT       @"text"
#define AVATAR     @"Avatar"

@interface DataManager : NSObject

+ (instancetype)sharedInstance;

- (void)setAllContacts:(NSArray *)array;
- (void)saveAvatarForUserContact:(NSNumber *)userID withImage:(NSData *)imageData;

- (NSUInteger)numberOfContacts;
- (NSDictionary *)contactDictionaryWithUserId:(NSNumber *)userID;
- (NSArray *)sortedArrayOfContacts;
- (NSData *)avatarForUserContact:(NSNumber *)userID;
- (NSArray *)messagesFromUser:(NSNumber *)userID;
- (NSArray *)allMessages;

@end
