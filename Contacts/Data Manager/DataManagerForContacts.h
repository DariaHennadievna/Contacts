//
//  DataManagerForContacts.h
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManagerForContacts : NSObject

@property (nonatomic) NSArray *data;

- (instancetype)initWithData:(NSArray *)contactsData;

- (NSUInteger)countOfObjectsInData;

- (NSDictionary *)gettingDataForOneContactsAtIndex:(NSInteger)index;

- (NSDictionary *)gettingContactInfoForData:(NSDictionary *)data;
- (NSArray *)gettingMessagesInfoForContact:(NSDictionary *)dataContact;

@end
