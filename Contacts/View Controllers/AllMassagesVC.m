//
//  AllMassagesVC.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

float const indentTopAndBottomForCellForAllMessagesVC = 5.0f;

#import "AllMassagesVC.h"

@interface AllMassagesVC ()

@property (nonatomic) UITableView *tableView;
@property CGFloat heightForRow;

@end

@implementation AllMassagesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //self.title = @"ALL";
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MessageFromContactCell class]
           forCellReuseIdentifier:NSStringFromClass([MessageFromContactCell class])];
}

#pragma mark - Views

-(UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    
    return _tableView;
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFromContactCell *messageFromContactCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageFromContactCell class]) forIndexPath:indexPath];
    if (indexPath.row == 0)
    {
        messageFromContactCell.messageLabel.text = @"Enter large amount of text here";
    }
    if (indexPath.row == 1)
    {
        messageFromContactCell.messageLabel.text = @"Enter large amount of text here kfjgd ервраве ке екнукеек екнуен etyerty etyerty erry eturyu";
    }
    
    [messageFromContactCell.messageLabel sizeToFit];
    
    CGFloat heightForAvatar = CGRectGetHeight(messageFromContactCell.avatarLabel.bounds);
    CGFloat heightForTimeAgo = CGRectGetHeight(messageFromContactCell.timeAgoLabel.bounds);
    CGFloat heightForMessage = CGRectGetHeight(messageFromContactCell.messageLabel.bounds);
    
    if ((heightForAvatar + heightForTimeAgo) > heightForMessage )
    {
        self.heightForRow = heightForAvatar + heightForTimeAgo + (indentTopAndBottomForCellForAllMessagesVC * 2);
    }
    else if ((heightForAvatar + heightForTimeAgo) < heightForMessage)
    {
        self.heightForRow = heightForMessage + (indentTopAndBottomForCellForAllMessagesVC * 2);
    }
    else
    {
        self.heightForRow = heightForMessage + (indentTopAndBottomForCellForAllMessagesVC * 2);
    }        
        
    return messageFromContactCell;
        
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.heightForRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(deselectRowAtIndexPath:) withObject:indexPath afterDelay:0.1f];    
}

-(void)deselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigation

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowContact"])
    {
        if ([segue.destinationViewController isKindOfClass:[ContactVC class]])
        {
            ContactVC *contactsVC =
             (ContactVC *)segue.destinationViewController;
            contactsVC.title = @"Виталя";            
        }
    }
}
*/


@end
