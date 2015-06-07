//
//  DataManager.h
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject

+ (instancetype) sharedInstance;
- (void) setAllContacts:(NSArray *) array;
- (NSUInteger) numberOfContacts;

@end
