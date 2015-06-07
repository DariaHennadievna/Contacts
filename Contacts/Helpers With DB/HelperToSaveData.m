//
//  HelperToSaveData.m
//  Contacts
//
//  Created by Admin on 07.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "HelperToSaveData.h"

@implementation HelperToSaveData

- (instancetype)initWithContactData:(NSDictionary *)contactData andMassageData:(NSArray *)messageData
{
    self = [super init];
    if (self)
    {
        _contactData = contactData;
        _messageData = messageData;
        _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    }
    
    return self;
}

- (void)saveContactData:(NSDictionary *)contactData
{
    //...
}

- (void)saveMessageData:(NSArray *)messageData forContact:(Contact *)contact
{
    //...
}





@end
