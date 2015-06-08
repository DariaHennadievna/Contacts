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
@property (nonatomic, strong) NSArray * allMessages;
@property (nonatomic, strong) NSNumber *clickedContact;

@end

@implementation AllMassagesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allMessages = [[DataManager sharedInstance] allMessages];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MessageFromContactCell class]
           forCellReuseIdentifier:NSStringFromClass([MessageFromContactCell class])];
    [self.tableView reloadData];
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
    return [self.allMessages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageFromContactCell *messageFromContactCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageFromContactCell class]) forIndexPath:indexPath];
    messageFromContactCell.selectionStyle = UITableViewCellSelectionStyleNone;    
   
    NSDictionary * messageDictionary = [self.allMessages objectAtIndex:indexPath.row];
    
    messageFromContactCell.messageLabel.text = [messageDictionary objectForKey:TEXT] ;
    NSNumber *userID = (NSNumber *)[messageDictionary objectForKey:USER_ID];
    [messageFromContactCell.avatarButton addTarget:self action:@selector(avatarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    messageFromContactCell.avatarButton.tag = [userID integerValue];
    NSData *imageData = [[DataManager sharedInstance] avatarForUserContact:userID];
    messageFromContactCell.avatar.image  = [UIImage imageWithData:imageData];
    
    NSNumber * created = [messageDictionary objectForKey:CREATED];
    NSDate * date =  [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:[created intValue]];
    
    // use the "NSDate+TimeAgo.h" pod
    NSString *ago = [date timeAgo];
    messageFromContactCell.timeAgoLabel.text = ago;
    NSLog(@"Вывести прошедшее время: \"%@\"", ago);
    
    [messageFromContactCell.messageLabel sizeToFit];
    
    CGFloat heightForAvatar = CGRectGetHeight(messageFromContactCell.avatarButton.bounds);
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
    NSLog(@"Click!!!");
}

-(void)deselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Actions
//
- (void)avatarButtonPressed:(UIButton *)sender
{
    self.clickedContact = [NSNumber numberWithInteger:sender.tag];
    [self performSegueWithIdentifier:@"goToContactFromAll" sender:self];  
    
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToContactFromAll"])
    {
        if ([segue.destinationViewController isKindOfClass:[ContactVC class]])
        {
            ContactVC *contactsVC =
            (ContactVC *)segue.destinationViewController;
            contactsVC.title = @"Contact";
            contactsVC.userID  = self.clickedContact;
        }
    }
}


@end
