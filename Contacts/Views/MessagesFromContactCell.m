//
//  MessagesFromContactCell.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

float const myIndentTopAndBottom = 5.0f;
float const myIndentLeftAndRight = 10.0f;

#import "MessagesFromContactCell.h"

@implementation MessagesFromContactCell


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
    CGSize sizeAvatarView;
    sizeAvatarView.width = 50.0f;
    sizeAvatarView.height = 50.0f;
    
    myOrigine.x = myIndentLeftAndRight;
    myOrigine.y = myIndentTopAndBottom;
    
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeAvatarView.width, sizeAvatarView.height);
    
    self.avatarView = [[UILabel alloc] initWithFrame:myFrame];
    self.avatarView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    [self addSubview:self.avatarView];
    
    // for Count Of Messages Label
    CGSize sizeCountOfMessagesLabel;
    sizeCountOfMessagesLabel.width = 50.0f;
    sizeCountOfMessagesLabel.height = 20.0f;
    
    myOrigine.x = self.center.x + self.bounds.size.width/2 - sizeCountOfMessagesLabel.width - myIndentLeftAndRight;
    myOrigine.y = self.avatarView.center.y - sizeCountOfMessagesLabel.height/2;
    
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeCountOfMessagesLabel.width, sizeCountOfMessagesLabel.height);
    
    self.countOfMessagesLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.countOfMessagesLabel.textAlignment = NSTextAlignmentRight;
    self.countOfMessagesLabel.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    [self addSubview:self.countOfMessagesLabel];
    
}

@end
