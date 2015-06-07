//
//  Contact+Creating.h
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Contact.h"
#import "AppDelegate.h"

// my keys
#define AVATAR_URL @"avatar_url"
#define USER_ID    @"user_id"
#define USER_NAME  @"username"

@interface Contact (Creating)

+ (Contact *)contactWithData:(NSDictionary *)data;

@end
