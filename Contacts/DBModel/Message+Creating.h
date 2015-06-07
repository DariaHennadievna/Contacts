//
//  Message+Creating.h
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Message.h"
#import "AppDelegate.h"

// my keys
#define CREATED @"created"
#define TEXT    @"text"

@interface Message (Creating)

+ (Message *)messageWithData:(NSDictionary *)data;

@end
