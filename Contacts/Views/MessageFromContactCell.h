//
//  MessageFromContactCell.h
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MessageFromContactCell;

@protocol MessageFromContactCellDelegate <NSObject>

- (void)didPressedAvatar:(MessageFromContactCell *)cell;

@end

@interface MessageFromContactCell : UITableViewCell

@property (nonatomic) UIButton *avatarButton;
@property (nonatomic) UIImageView *avatar;
@property (nonatomic) UILabel *messageLabel;
@property (nonatomic) UILabel *timeAgoLabel;

@property (nonatomic, weak) id <MessageFromContactCellDelegate> delegate;

- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
