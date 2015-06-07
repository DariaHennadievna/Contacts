//
//  HelperToSaveData.h
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Contact+Creating.h"
#import "Message+Creating.h"

@interface HelperToSaveData : NSObject

@property (nonatomic) NSDictionary *contactData;
@property (nonatomic) NSArray *messageData;
@property (nonatomic) AppDelegate *appDelegate;

- (instancetype)initWithContactData:(NSDictionary *)contactData andMassageData:(NSArray *)messageData;

- (void)saveContactData:(NSDictionary *)contactData;
- (void)saveMessageData:(NSArray *)messageData forContact:(Contact *)contact;

@end
