//
//  Avatar+Creating.m
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Avatar+Creating.h"

@implementation Avatar (Creating)

+ (Avatar *)avatarWithData:(NSData *)data
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    Avatar *myAvatar = (Avatar *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:context];
    if (myAvatar)
    {
        myAvatar.image = data;
    }
    
    return myAvatar;
}

@end
