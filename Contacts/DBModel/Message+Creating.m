//
//  Message+Creating.m
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "Message+Creating.h"

@implementation Message (Creating)

+ (Message *)messageWithData:(NSDictionary *)data
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    Message *myMessage = (Message *)[NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(self) inManagedObjectContext:context];
    if (myMessage)
    {
        myMessage.created = [data objectForKey:CREATED];
        myMessage.text  = [NSString stringWithFormat:@"%@", [data objectForKey:TEXT]];
    }
    
    return myMessage;
}

@end
