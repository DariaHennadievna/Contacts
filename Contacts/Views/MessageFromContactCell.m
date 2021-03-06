//
//  MessageFromContactCell.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

float const indentTopAndBottomForMessagesFromContactCell = 5.0f;
float const indentLeftAndRightForMessagesFromContactCell = 10.0f;

#import "MessageFromContactCell.h"

@implementation MessageFromContactCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self configureCell];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {        
        [self configureCell];
    }
    
    return self;
}

- (void)configureCell
{
    CGPoint myOrigine;
    CGRect myFrame;
    
    // for All Label
    CGSize sizeAvatarView;
    
    sizeAvatarView.width  = 50.0f;
    sizeAvatarView.height = 50.0f;
    
    myOrigine.x = indentLeftAndRightForMessagesFromContactCell;
    myOrigine.y = indentTopAndBottomForMessagesFromContactCell;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeAvatarView.width, sizeAvatarView.height);
    
    self.avatarButton = [[UIButton alloc] initWithFrame:myFrame];
    self.avatar = [[UIImageView alloc] initWithFrame:myFrame];
    //self.avatarView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    [self.avatarButton addSubview:self.avatar];
    [self addSubview:self.avatarButton];
    
    // for Time Ago Label
    CGSize sizeTimeAgoLabel;
    
    sizeTimeAgoLabel.width = 50.0f;
    sizeTimeAgoLabel.height = 15.0f;
    
    myOrigine.x = indentLeftAndRightForMessagesFromContactCell;
    myOrigine.y = indentTopAndBottomForMessagesFromContactCell + self.avatarButton.frame.size.height + 3.0f;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeTimeAgoLabel.width, sizeTimeAgoLabel.height);
    
    self.timeAgoLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.timeAgoLabel.textAlignment = NSTextAlignmentRight;
    self.timeAgoLabel.textColor = [UIColor grayColor];
    [self addSubview:self.timeAgoLabel];
    
    // for Message Label
    CGSize sizeMessageLabel;
    
    sizeMessageLabel.width = 220.0f;
    sizeMessageLabel.height = 15.0f;
    
    myOrigine.x = self.bounds.size.width - sizeMessageLabel.width - indentLeftAndRightForMessagesFromContactCell;
    myOrigine.y = indentTopAndBottomForMessagesFromContactCell;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeMessageLabel.width, sizeMessageLabel.height);
    
    self.messageLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.messageLabel.textAlignment = NSTextAlignmentJustified;
    self.messageLabel.font = [UIFont systemFontOfSize:15];
    //self.messageLabel.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    
    self.messageLabel.adjustsFontSizeToFitWidth  = YES;
    self.messageLabel.numberOfLines = 0;
    
    [self addSubview:self.messageLabel];
    
}

#pragma mark - Actions

- (void)buttonPressed:(id)sender
{
    if (self.delegate) {
        [self.delegate didPressedAvatar:self];
    }
}

@end
