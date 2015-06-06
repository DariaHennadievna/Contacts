//
//  AllContactsVC.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AllContactsVC.h"

float const indentTopAndBottomForCell = 5.0f;

@interface AllContactsVC ()

@property (nonatomic) UITableView *tableView;
@property CGFloat heightForRowInFirstSection;
@property CGFloat heightForRowInSecondSection;

@property (nonatomic) DataManagerForContacts *dataManagerForContacts;


@end

@implementation AllContactsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Contacts";
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[AllMessagesCell class]
           forCellReuseIdentifier:NSStringFromClass([AllMessagesCell class])];
    [self.tableView registerClass:[MessagesFromContactCell class]
           forCellReuseIdentifier:NSStringFromClass([MessagesFromContactCell class])];
    
    [self startGetContacts];
    //[self startGetAvatar];
    
}

#pragma mark - Views

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    
    return _tableView;
}

#pragma mark - Table View Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2; //  секции в Table View
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else
    {
        return 5;
    }   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        AllMessagesCell *allMessagesCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AllMessagesCell class]) forIndexPath:indexPath];
        self.heightForRowInFirstSection= CGRectGetHeight(allMessagesCell.allLabel.bounds) +
                                                        (indentTopAndBottomForCell * 2);
        return allMessagesCell;
    }
    else
    {
        MessagesFromContactCell *messagesFromContactCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessagesFromContactCell class]) forIndexPath:indexPath];
        self.heightForRowInSecondSection = CGRectGetHeight(messagesFromContactCell.avatarView.bounds) +
                                                        (indentTopAndBottomForCell * 2);
        return messagesFromContactCell;
    }
    
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return self.heightForRowInFirstSection;
    }
    else
    {
        return self.heightForRowInSecondSection;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(deselectRowAtIndexPath:) withObject:indexPath afterDelay:0.1f];
    if (indexPath.section == 0)
    {
        [self performSegueWithIdentifier:@"ShowAllMessages" sender:self];
    }
    else
    {
        [self performSegueWithIdentifier:@"ShowContact" sender:self];
    }
}

-(void)deselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Get Contacts

- (void)startGetContacts
{
    RequestManager *myRequestManager = [[RequestManager alloc] init];
    [myRequestManager gettingContactsWithCallback:^(NSError *error, NSArray *result) {
        if (error)
        {
            return;
        }
        //NSLog(@"DATA %@", result);
        DataManagerForContacts *dataManager = [[DataManagerForContacts alloc] initWithData:result];
        self.dataManagerForContacts = dataManager;
        [self dataProcessingForContactsData];
    }];
}

/*
- (void)startGetAvatar
{
    RequestManager *myRequestManager = [[RequestManager alloc] init];
    [myRequestManager gettingAvatarWithCallback:^(NSError *error, NSData *result) {
        if (error)
        {
            return;
        }
        
        NSLog(@"Data = %@", result);
    }];
}
*/

#pragma mark - Data Processing

- (void)dataProcessingForContactsData
{
    [self.dataManagerForContacts countOfObjectsInData];
    NSDictionary *contact = [self.dataManagerForContacts gettingDataForOneContactsAtIndex:1];
    NSLog(@"contact = %@",contact);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAllMessages"])
    {
        if ([segue.destinationViewController isKindOfClass:[AllMassagesVC class]])
        {
            AllMassagesVC *allMessagesVC =
            (AllMassagesVC *)segue.destinationViewController;
            allMessagesVC.title = @"ALL";
        }
    }
    
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

@end
