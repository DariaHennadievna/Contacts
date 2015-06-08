//
//  AllContactsVC.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

#import "AllContactsVC.h"
#import "UIImageView+AFNetworking.h"

float const indentTopAndBottomForCell = 5.0f;

@interface AllContactsVC ()

@property (nonatomic) UITableView *tableView;
@property CGFloat heightForRowInFirstSection;
@property CGFloat heightForRowInSecondSection;

@property (nonatomic, strong) NSArray *sortedArrayOfContacts;
@property (nonatomic, strong) NSNumber *clickedContact;


@end

@implementation AllContactsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Contacts";
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[AllMessagesCell class]
           forCellReuseIdentifier:NSStringFromClass([AllMessagesCell class])];
    [self.tableView registerClass:[ContactCell class]
           forCellReuseIdentifier:NSStringFromClass([ContactCell class])];
    
    
    self.sortedArrayOfContacts = [[DataManager sharedInstance] sortedArrayOfContacts];
    [self startGetContacts];
    
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
        return [[DataManager sharedInstance] numberOfContacts];// count of contacts
    }   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        AllMessagesCell *allMessagesCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AllMessagesCell class]) forIndexPath:indexPath];
        self.heightForRowInFirstSection= CGRectGetHeight(allMessagesCell.allLabel.bounds) +
                                                        (indentTopAndBottomForCell * 2);
        
        NSArray *allMessages = [[DataManager sharedInstance] allMessages];
        allMessagesCell.countOfMessagesLabel.text = [NSString stringWithFormat:@"%lu >", allMessages.count];
        
        return allMessagesCell;
    }
    else
    {
        ContactCell *messagesFromContactCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ContactCell class]) forIndexPath:indexPath];
        self.heightForRowInSecondSection = CGRectGetHeight(messagesFromContactCell.avatarView.bounds) +
                                                        (indentTopAndBottomForCell * 2);
        
        NSDictionary *dict =  self.sortedArrayOfContacts[indexPath.row];
        messagesFromContactCell.userName.text = [dict objectForKey:USER_NAME];
        messagesFromContactCell.numberOfMessagesLabel.text = [NSString stringWithFormat:@"%@ >", [dict objectForKey:NUMBER_OF_MESSAGES] ];
        
        // используем TAG для того чтобы знать какую ячейку нажали с каким пользователем
        // в TAG записываем ID пользователя
        messagesFromContactCell.tag =  [(NSNumber *)[dict objectForKey:USER_ID] unsignedIntegerValue];
        NSString * urlString  = [dict objectForKey:AVATAR_URL];
        
        __weak ContactCell *weakCell = messagesFromContactCell;
        
        // пока не получили ни одной картинки делаем заставочки для аватарок
        [messagesFromContactCell.avatarView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] placeholderImage:[UIImage imageNamed:@"profile-image-placeholder.png"]
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
         {
             // если данные приходят отображаем картинку
             weakCell.avatarView.image = image;
             [weakCell  setNeedsLayout];
             
             // и сохраняем картинку в базу
             [[DataManager sharedInstance] saveAvatarForUserContact:[NSNumber numberWithInteger:weakCell.tag] withImage:UIImageJPEGRepresentation(image, 1.0)];
             
         }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error)
         {
             // если какая то ошибка или нет интернета то выгружаем картинку из базы
             NSLog(@"%@",[error localizedDescription]);
             NSData *imageData = [[DataManager sharedInstance] avatarForUserContact:[NSNumber numberWithInteger:weakCell.tag]];
             weakCell.avatarView.image  = [UIImage imageWithData:imageData];
             [weakCell setNeedsLayout];
         }];
        
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
        ContactCell *cell = (ContactCell*)[tableView cellForRowAtIndexPath:indexPath];
        // этот параметр userID передадим следующему контроллеру
        self.clickedContact = [NSNumber numberWithInteger:cell.tag];
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
    [myRequestManager gettingContactsWithCallback:^(NSError *error, NSArray *result)
     {
         if (error)
         {
             return;
         }
         //NSLog(@"DATA %@", result);
         
         [[DataManager sharedInstance] setAllContacts:result];
         self.sortedArrayOfContacts = [[DataManager sharedInstance] sortedArrayOfContacts];
         [self.tableView reloadData];
     }];
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
            contactsVC.title = @"Contact";
            contactsVC.userID  = self.clickedContact;
        }
    }
}

@end
