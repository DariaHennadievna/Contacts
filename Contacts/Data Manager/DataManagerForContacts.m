//
//  DataManagerForContacts.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DataManagerForContacts.h"
#import "Contact+Creating.h"

#define MESSAGES  @"messages"


@implementation DataManagerForContacts

- (instancetype)initWithData:(NSArray *)contactsData;
{
    self = [super init];
    if (self)
    {
        _data = contactsData;
    }
    
    return self;
}

- (NSDictionary *)gettingDataForOneContactsAtIndex:(NSInteger)index
{
    if (index > self.data.count-1)
    {
        return nil;
    }
    
    NSDictionary *contact = [self.data objectAtIndex:index];
    return contact;
}

- (NSDictionary *)gettingContactInfoForData:(NSDictionary *)dataContact
{
    NSMutableDictionary *contactInfo = [[NSMutableDictionary alloc] init];
    
    NSString *avatarURL =  [dataContact objectForKey:AVATAR_URL];
     NSLog(@"avatarURL = %@", avatarURL);
    [contactInfo setObject:avatarURL forKey:AVATAR_URL];
    
    NSNumber *userID = [dataContact objectForKey:USER_ID];
     NSLog(@"userID = %@", userID);
    [contactInfo setObject:userID forKey:USER_ID];
    
    NSString *username =  [dataContact objectForKey:USER_NAME];
     NSLog(@"username = %@", username);
    [contactInfo setObject:username forKey:USER_NAME];
    
    NSLog(@"dictionari of contact's data = %@", contactInfo);
    return [contactInfo copy];
}

- (NSArray *)gettingMessagesInfoForContact:(NSDictionary *)dataContact
{
    NSArray *messagesData = [dataContact objectForKey:MESSAGES];
    NSArray *messages = [[NSArray alloc] initWithArray:messagesData];
    
    NSLog(@"messages = %@", messages);
    return messages;
}

/*
- (NSDictionary *)gettingMessageForContact:(NSDictionary *)contact atIndex:(NSInteger)index
{
    //...
}
*/




- (NSUInteger)countOfObjectsInData
{
    NSUInteger count = self.data.count;
    NSLog(@"count %lu", (unsigned long)count);
    
    return count;
}

@end
