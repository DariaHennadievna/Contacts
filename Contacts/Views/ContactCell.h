//
//  MessagesFromContactCell.h
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell

@property (nonatomic) UIImageView  *avatarView;
@property (nonatomic) UILabel *numberOfMessagesLabel;
@property (nonatomic) UILabel *userName;

- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
