//
//  AllMassagesVC.h
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageFromContactCell.h"
#import "AllContactsVC.h"
#import "ContactVC.h"

@interface AllMassagesVC : UIViewController <UITableViewDataSource,
                                                UITableViewDelegate,
                                                    MessageFromContactCellDelegate>

@end
