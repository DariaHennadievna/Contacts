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
        //self.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.3f];
        [self configureCell];
    }
    
    return self;
}

- (void)configureCell
{
    CGPoint myOrigine;
    CGRect myFrame;
    
    // for All Label
    CGSize sizeAvatarLabel;
    
    sizeAvatarLabel.width  = 50.0f;
    sizeAvatarLabel.height = 50.0f;
    
    myOrigine.x = indentLeftAndRightForMessagesFromContactCell;
    myOrigine.y = indentTopAndBottomForMessagesFromContactCell;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeAvatarLabel.width, sizeAvatarLabel.height);
    
    self.avatarLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.avatarLabel.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    [self addSubview:self.avatarLabel];
    
    // for Time Ago Label
    CGSize sizeTimeAgoLabel;
    
    sizeTimeAgoLabel.width = 50.0f;
    sizeTimeAgoLabel.height = 15.0f;
    
    myOrigine.x = indentLeftAndRightForMessagesFromContactCell;
    myOrigine.y = indentTopAndBottomForMessagesFromContactCell + self.avatarLabel.frame.size.height + 3.0f;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeTimeAgoLabel.width, sizeTimeAgoLabel.height);
    
    self.timeAgoLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.timeAgoLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
    [self addSubview:self.timeAgoLabel];
    
    // for Message Label
    CGSize sizeMessageLabel;
    
    sizeMessageLabel.width = 200.0f;
    sizeMessageLabel.height = 15.0f;
    
    myOrigine.x = self.bounds.size.width - sizeMessageLabel.width - indentLeftAndRightForMessagesFromContactCell;
    myOrigine.y = indentTopAndBottomForMessagesFromContactCell;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeMessageLabel.width, sizeMessageLabel.height);
    
    self.messageLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    self.messageLabel.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    
    self.messageLabel.numberOfLines = 0;    
    
    [self addSubview:self.messageLabel];
    
    
}

@end