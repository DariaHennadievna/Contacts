//
//  Avatar.h
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact;

@interface Avatar : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) Contact *owner;

@end
