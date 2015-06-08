//
//  ContactVC.m
//  Contacts
//
//  Created by Admin on 06.06.15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

float const avatarViewHeight = 70.0f;
float const avatarViewWidth  = 70.0f;
float const avatarViewTop    = 70.0f;
float const tableViewTop     = avatarViewTop + avatarViewHeight + 5.0f;
float const indentTopAndBottomForCellForContactVC = 5.0f;

#import "ContactVC.h"

@interface ContactVC ()

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIImageView *avatarView;
@property (nonatomic, strong) NSArray * messages;
@property CGFloat heightForRow;

@end

@implementation ContactVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"self.userID = %@", self.userID);
    self.messages = [[DataManager sharedInstance] messagesFromUser:self.userID];
    NSLog(@"self.messages = %@", self.messages);
    [self.view addSubview:self.avatarView];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MessageCell class]
           forCellReuseIdentifier:NSStringFromClass([MessageCell class])];
}

#pragma mark - Views

- (UIView *)avatarView
{
    if (!_avatarView)
    {
        CGSize sizeAvatarView;
        sizeAvatarView.height = avatarViewHeight;
        sizeAvatarView.width  = avatarViewWidth;
        CGPoint myOrigin;
        myOrigin.x = self.view.center.x - sizeAvatarView.width/2;
        myOrigin.y = avatarViewTop;
        CGRect myFrame = CGRectMake(myOrigin.x, myOrigin.y, sizeAvatarView.width, sizeAvatarView.height);
        _avatarView = [[UIImageView alloc] initWithFrame:myFrame];
        //_avatarView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5f];
        NSData * imageData =  [[DataManager sharedInstance] avatarForUserContact:self.userID];
        _avatarView.image = [UIImage imageWithData:imageData];
    }
    
    return _avatarView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        CGRect myFrame = CGRectMake(0.0f, tableViewTop, self.view.bounds.size.width, self.view.bounds.size.height);
        _tableView = [[UITableView alloc] initWithFrame:myFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
    }
    
    return _tableView;
}

#pragma mark - Table View Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messages count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageCell *messageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MessageCell class]) forIndexPath:indexPath];
    messageCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *messageDictionary = [self.messages objectAtIndex:indexPath.row];
    messageCell.messageLabel.text = [messageDictionary objectForKey:TEXT];
    NSNumber *created = [messageDictionary objectForKey:CREATED];
    NSDate *date =  [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:[created intValue]];
    
    //NSTimeInterval  interval = [date timeIntervalSinceNow];
    //messageCell.timeAgoLabel.text = [NSString stringWithFormat:@"%f hour",(interval/60)/60 ];
    
    // use the "NSDate+TimeAgo.h" pod
    NSString *ago = [date timeAgo];
    messageCell.timeAgoLabel.text = ago;
    NSLog(@"Вывести прошедшее время: \"%@\"", ago);
    
    [messageCell.messageLabel sizeToFit];
    
    CGFloat heightForTimeAgo = CGRectGetHeight(messageCell.timeAgoLabel.bounds);
    CGFloat heightForMessage = CGRectGetHeight(messageCell.messageLabel.bounds);
    
    self.heightForRow = heightForMessage + heightForTimeAgo + (indentTopAndBottomForCellForContactVC * 2);
    
    NSLog(@"cellForRowAtIndexPath = %f", self.heightForRow);
  
    return messageCell;
}

#pragma mark - Table View Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath = %f", self.heightForRow);
    return self.heightForRow;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSelector:@selector(deselectRowAtIndexPath:) withObject:indexPath afterDelay:0.1f];
    NSLog(@"Click!!!");
    //[tableView reloadData];
}

-(void)deselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}






@end
