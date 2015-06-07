//
//  Contact+Creating.m
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Contact+Creating.h"

@implementation Contact (Creating)

+ (Contact *)contactWithData:(NSDictionary *)data
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    Contact *myContact = (Contact *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:context];
    if (myContact)
    {
        myContact.avatarURL = [NSString stringWithFormat:@"%@", [data objectForKey:AVATAR_URL]];
        myContact.userID    = [data objectForKey:USER_ID];
        myContact.username  = [NSString stringWithFormat:@"%@", [data objectForKey:USER_NAME]];
    }
    
    return myContact;
}

@end
