//
//  DataManagerForContacts.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DataManagerForContacts.h"

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

- (void)countOfObjectsInData
{
    //NSLog(@"DATA = %@", self.data);
    NSLog(@"count %lu", (unsigned long)self.data.count);
}

@end
