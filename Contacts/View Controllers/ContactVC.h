//
//  ContactVC.h
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageCell.h"
#import "DataManager.h"
#import "NSDate+TimeAgo.h"

@interface ContactVC : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSNumber * userID;

@end
