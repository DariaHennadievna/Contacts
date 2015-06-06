//
//  DataManagerForContacts.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "DataManagerForContacts.h"

@implementation DataManagerForContacts

- (instancetype)initWithData:(NSDictionary *)contactsData;
{
    self = [super init];
    if (self)
    {
        _data = contactsData;
    }
    
    return self;
}

@end
