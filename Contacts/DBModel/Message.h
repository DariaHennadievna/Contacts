//
//  Message.h
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSNumber * created;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Contact *from;

@end
