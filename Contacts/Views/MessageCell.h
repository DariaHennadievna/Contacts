//
//  MessageCell.h
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell

@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UILabel *timeAgoLabel;

- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
