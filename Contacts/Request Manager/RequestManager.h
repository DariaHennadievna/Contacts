//
//  RequestManager.h
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

//typedef void (^ContactsAPICallback)(NSError* error, NSDictionary *result);
typedef void (^ContactsAPICallback)(NSError* error, NSArray *result);
typedef void (^AvatarAPICallback)(NSError* error, NSData *result);

@interface RequestManager : NSObject

- (void)gettingContactsWithCallback:(void (^)(NSError *error, NSArray *result))callback;
- (void)gettingAvatarWithCallback:(void (^)(NSError *error, NSData *result))callback;

@end
