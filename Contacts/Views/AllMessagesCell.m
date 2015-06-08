//
//  AllMessagesCell.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

float const indentTopAndBottom = 5.0f;
float const indentLeftAndRight = 10.0f;

#import "AllMessagesCell.h"

@implementation AllMessagesCell

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
    CGSize sizeAllLabel;
    
    sizeAllLabel.width = 50.0f;
    sizeAllLabel.height = 30.0f;
    
    myOrigine.x = indentLeftAndRight;
    myOrigine.y = indentTopAndBottom;
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeAllLabel.width, sizeAllLabel.height);
    
    self.allLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.allLabel.font = [UIFont systemFontOfSize:25];
    self.allLabel.text = @"ALL";
    self.allLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.allLabel];
    
    // for Count Of Messages Label
    CGSize sizeCountOfMessagesLabel;
    
    sizeCountOfMessagesLabel.width = 50.0f;
    sizeCountOfMessagesLabel.height = 20.0f;
    
    myOrigine.x = self.center.x + self.bounds.size.width/2 - sizeCountOfMessagesLabel.width - indentLeftAndRight;
    myOrigine.y = self.allLabel.center.y - sizeCountOfMessagesLabel.height/2;
    
    myFrame = CGRectMake(myOrigine.x, myOrigine.y, sizeCountOfMessagesLabel.width, sizeCountOfMessagesLabel.height);
    
    self.countOfMessagesLabel = [[UILabel alloc] initWithFrame:myFrame];
    self.countOfMessagesLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:self.countOfMessagesLabel];
}

@end
