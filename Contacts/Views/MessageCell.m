//
//  MessageCell.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

float const indentTopAndBottomForMessageCell = 5.0f;
float const indentLeftAndRightForMessageCell = 10.0f;

#import "MessageCell.h"

@implementation MessageCell

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
    
    // for Message Label
    /*CGSize sizeMessageLabel;
    
    sizeMessageLabel.width = 250.0f;
    sizeMessageLabel.height = 15.0f;
    
    myOrigine.x = self.bounds.size.width/2 - sizeMessageLabel.width/2;
    myOrigine.y = indentTopAndBottomForMessageCell;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeMessageLabel.width, sizeMessageLabel.height);
    
    self.messageLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    self.messageLabel.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    
    self.messageLabel.numberOfLines = 0;
    
    [self addSubview:self.messageLabel];
    */
    
    
    CGSize sizeMessageLabel;
    
    sizeMessageLabel.width = 200.0f;
    sizeMessageLabel.height = 15.0f;
    
    myOrigine.x = self.bounds.size.width - sizeMessageLabel.width - indentLeftAndRightForMessageCell;
    myOrigine.y = indentTopAndBottomForMessageCell;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeMessageLabel.width, sizeMessageLabel.height);
    
    self.messageLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.messageLabel.textAlignment = NSTextAlignmentLeft;
    self.messageLabel.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    
    self.messageLabel.numberOfLines = 0;
    //self.messageLabel.text = @"Enter large amount of text here";
    //[self.messageLabel sizeToFit];
    
    [self addSubview:self.messageLabel];
    
    
    
    // for Time Ago Label
    CGSize sizeTimeAgoLabel;
    
    sizeTimeAgoLabel.width = 50.0f;
    sizeTimeAgoLabel.height = 15.0f;
    
    myOrigine.x = self.bounds.size.width - sizeTimeAgoLabel.width - indentLeftAndRightForMessageCell;
    myOrigine.y = indentTopAndBottomForMessageCell + self.messageLabel.frame.size.height + 3.0f;
    myFrame = CGRectMake(myOrigine.x - 250, myOrigine.y - 40, sizeTimeAgoLabel.width, sizeTimeAgoLabel.height);
    
    self.timeAgoLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.timeAgoLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5f];
    [self addSubview:self.timeAgoLabel];
    
}

@end
