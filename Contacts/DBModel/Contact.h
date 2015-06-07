//
//  Contact.h
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Avatar, Message;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * avatarURL;
@property (nonatomic, retain) NSNumber * userID;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *messages;
@property (nonatomic, retain) Avatar *photo;
@end

@interface Contact (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
